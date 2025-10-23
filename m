Return-Path: <linux-kselftest+bounces-43940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4FC02E3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A197A4F1689
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B02765F8;
	Thu, 23 Oct 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bi9P4kyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2A272E7C;
	Thu, 23 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243677; cv=fail; b=sBF+9QXAzuSzDT15OrYLpgplvrQ8S2DdjF0wYYNsHt/XulXtM0pkyLiONnLZX0pG5tOaRweKEqXToHrUYEyslFRaoMRjhJcb/tBa+UDXR7wHTLsjAQ6gJt4iV9AyXiextoepjy7eddD3pi4nGe33DGBfER58E3IWSC122/KIYxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243677; c=relaxed/simple;
	bh=xxViaOHDvnj5xE3u7JIgpsi8QMuRYbYagEuB+lmya2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szVz3Q/5rt6yM/qZYOJ46gL7V+8gGSmBEvd/gSbKkvaIBobiu37Tdtuiyhc9pE0LzBCc4XpYix0gzlEYzUVRL5qOoDdGrsm9c4ZZUDDSkdFeH4Ntc+DbSoGj6WsMsBn/qfp0qw+OrQWe5BC8v6u34Ep1S3qote3kvXhfntxdoSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bi9P4kyA; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx8ulXOEMNQEakZUnR74XXOze3nesERM7/PlQACQt2dwsI78MGXsZjP4mIIFDOk0kHDt5bMh79k8q9zSO4rWY2iXQ4LYyWfsioiG/ujsN8A1R8Aj1kplGBqULboEI2A/E+Exx5nPTWigyS7EwnCaXK0O0hQRk/ipeVfel56oAfe/3fLgh5wMcUUDoLiZfSiz10Qe+We4QGxlbz3uJIQKd35KlEMqiuN7s4jtmnjrh/WhGDbdWBE3ryDujVM8BUDltDtPL0GaceS8HYrNj6IvHCg+MDL7mtug10rq4gVFszbYeoNXeycW6gX0aDvMLpMMjZVl+9xw6D1d7HvTKvDbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hwvjhYQzcxdJ6s7k/Nu+3pZjQcte1K0Np0WON64AeM=;
 b=GVUChEe4jslKl78f3rh9WyOCIEX7WVNcFgsqXxziIfPv4bxBj3tdHlnR9qEVXdhscVg4Hy7cSZoMJdi7WW0HdWix0um6iXoiZhP0G4aPhss8+3+H1xlm719+7AFFsaIcuN3DlcyY3UIWBB8bwDnDtePYTR447Cb6vtvXJJBJyy5LCZFZ8FnBxM8m0LicbqE7Sv90cXaRdSYonBknBYNNMinimjDd8H+BZCXmLb+E2qz94niaU21gP98i1wnkPNLFgzyjW/iI4piJZwtjnp/+wA5ro6WRv52dsIfAOlXkiWN5o/wfnffcOCVCFLbx8Dn0FMRmqYed/hrlrioBGxk/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hwvjhYQzcxdJ6s7k/Nu+3pZjQcte1K0Np0WON64AeM=;
 b=Bi9P4kyAnMBudYQPPV2M90PFRNLwvnNLURwqWHpHUx4dZmGyClXL8McmD7IAB6SUbTJW1H+AGfVwRvzsFsFQpYC9V5NZ6FJpTyKyRTtrWbhI/lJWVKnFStCKRITPQcHzrm1Ox/yqZsJiDi8OrfLPaNj4krKdZri0M8gmECWcDEDhgchzZkDO2/lkAo8IBt/pkUW3G2RvJnRjhVoTDlrDyXtzu3/4h5af+G6rTyBE5U5mTVdznQSEInIZpPVhQzP/kQ2SUsv0RxoZNIzbXgJwtUyYTlxhqj+hI6kUjlm24/GD5uMJqi/tjVqtYY90vIduzzoqsQ0dabjruO/a8uPSqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:21:04 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:04 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v7 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Thu, 23 Oct 2025 15:20:33 -0300
Message-ID: <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9940faae-f356-42b2-de65-08de1260e739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+1FjXdJgk9ouxJTDGukrQ+55y+WIuh9CzZ+cZMmcYDpXdaM8jaiLpSNlMt+W?=
 =?us-ascii?Q?L1DWCQaB3csMXnojgofoobeosmZh7GHu+my4bqlLw5lrPlB5il3AFblUpTLk?=
 =?us-ascii?Q?/Okh7fqDfwvKiE2avh6rF23cfVEmqNrFk35X+Tgd3R8lUSi+LjU7lR+vJTCR?=
 =?us-ascii?Q?GUObguwuz5cIpRVkzYIzthTbVMtFsXMUu+/Fl9iWX6qc4FxrhY+j/9kLGqwc?=
 =?us-ascii?Q?LPqXDtsUrI0AkrUE22EI8g5jw0ohu4Rk6xsZoRU2pSat0cmGzQq5i3RDWfz8?=
 =?us-ascii?Q?ytQXLhFr8SYE9SzA8xG9hzEnGoxSpHz496n5LR6Hxph0RsLBSrBhx0gvumdp?=
 =?us-ascii?Q?NcL/0snItdDZDJSNPJJxR3BODRPKR5gXLxgUplGU9VgHco3wg2ephdb2hsiL?=
 =?us-ascii?Q?09tnFRPvnyxT3zcQKbCTFh+cMfpJATOLYRlJw57tXNDCDhHjipad81za+R8M?=
 =?us-ascii?Q?DUsCq0D/QgorUYVdZL9mZ8FRDsdWl2CQYKrPWAaNd5c7ywjjTm/qmFSvnc4j?=
 =?us-ascii?Q?TZJQHPAjP3ip8SdoX3BR4SLUQ9WcxABbvSB6J9RAGRbv1ZSKMUBn8yTuej1f?=
 =?us-ascii?Q?z951/1wi1+xVw1lpnejQSps08q/wkJbyu0E56V90IA3sWCQuKnRt0pMTl6ml?=
 =?us-ascii?Q?xUIR+5UEcgg3wNctdQf7lDHcUz3D1klssEoB7RfD6g2DzvFzvvw1KGqPC/82?=
 =?us-ascii?Q?3PjaencaCfgZqTZsmbxSWDk06sa30t0N31aJ5slWez9WTYB8D9BKZ8apv2/6?=
 =?us-ascii?Q?fiy+ttfO2a/Ag5NT+r4KQgGvucfyIsqHBYEfcKjChzj0izNEjpIGDknbA/Ob?=
 =?us-ascii?Q?hUPm9N0q3lGKNv1cS1+2FYIRu/rJKlCwPO39dJwvAPR/o3An6Zs7c2Ygx6G0?=
 =?us-ascii?Q?glHnwwiNQZC4SEF9ongVg5Ir8xGAH5GIHD6NRNFv0/HCoEnpgrczneXXAkXu?=
 =?us-ascii?Q?Oez9vxZNFl6CQ2OnC4X7s6cdzGeawR1R4rGxfVXPCx3Guy4fVMr1ppQ7pcaK?=
 =?us-ascii?Q?rbAlN6YQ9IxbT77J3fACu/l31Jz98sh+pArGvMPHy9/zv6iCBCKskTATzp+n?=
 =?us-ascii?Q?d011b/GWpZaqRi5v9kDtfvhr81TYCT8IwcCf3c71dAam2cjD7iE9X6dZB4i+?=
 =?us-ascii?Q?tJtVtWKr4wOZKzzmKHVcnwl3UhrpEWcKRl8NnYFrKsLaSS/FpXMoKoyV+5An?=
 =?us-ascii?Q?tvfAq37aFMbbZHC7W71Td78QMbTfm6V42iQ8redLe543wYxe3/mezJQP38FW?=
 =?us-ascii?Q?QCab6e/R3uTfWlrPBKy3pXT23gVc8f7V10z76OZt81dyLEes41VFunD3j/fA?=
 =?us-ascii?Q?WQtJKCwDlDTde51K86bJO9UA2K5OFlSjo2kk2Z5GWuhfvvaUjGziUWirpbyC?=
 =?us-ascii?Q?TkaY8ZS+W8RauWSyW8HfDRS05pwteie+Yoy6XzUM+yqdeXMJyfcP+v6DMCgK?=
 =?us-ascii?Q?tefn6+cy8ksGsyWDttu6iQBySKipWRwcMgXYSjGSxOw8G3+82Y0ds1aRIJF3?=
 =?us-ascii?Q?V2Xf4hPQ/Nf5kiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?85Uc8gH9WTTyYS7X9eno67d8y2BOq5GCcp/gv1KvIQr+ORc95hSo6dDCOXwZ?=
 =?us-ascii?Q?HSYXq1ydhNCaZ+NACapskTAoYceuZMjUcNSoxdhUypXkQD7Un+lVuhBOB9FK?=
 =?us-ascii?Q?GZZZB4dfKBwsIstw0Ck4VnFsS+iSqynVn4v6EorCrfoSi/KTABT0rgETosq/?=
 =?us-ascii?Q?Zis/JbbnVyJ/NkBiyujWbfJAlD/ZKEtoDQ5to8TfakpQVPHoIH0rz8UuvsRO?=
 =?us-ascii?Q?I8XGHVP44D1LrZy8Fx8nUkuxkkw5RInPMfpgUr/4gnal27Gqqa+I0Qps0p4o?=
 =?us-ascii?Q?KWA/mDFfMTAwNpkO+iEemEiudO3iG3DDxUL5qSUDN4iwSYUKhNNyV12lBbfV?=
 =?us-ascii?Q?ck9e9j0GNz4xouzli6XnT+Qn7XrcZQyg8ySRSnkm0zK68xXr2mBb8ng4lbbn?=
 =?us-ascii?Q?pxILC4uODpp+I+Yl6vYkNPBqD3ElskxSNQCbuhUHCkVtRm3eD6akpilCNT6u?=
 =?us-ascii?Q?LZ5HSV/f22MTVWbJ2dJc1E4vEms77IiI1+6mmgnTBLsDLgeZUAwjZH+frfDy?=
 =?us-ascii?Q?n1zUOKNBIH4R0GO0CRj8eqDVfiy2GkBji+ZXcJNIemaCQkYgG6rEOlXemZoP?=
 =?us-ascii?Q?GoQABRE3Pg3jfY74kEqkCsnNTiAi9iQkxXHthNb0TsIp0hQAeSNxVEga/HU3?=
 =?us-ascii?Q?PBGJnk5tjqV+b3/cXXhHSSeHIyGYvU8MXosB8YZfWaPTdGA8QKWWKIxw7Fel?=
 =?us-ascii?Q?fYjXmqnamrLTUmBRbeukWdnOXByL4eO/Y7QiScF/86cf8eOglRpFMDqNebyO?=
 =?us-ascii?Q?6ELzU4syJ1CFqLMynpYiTr5TlWrRuo1+zBxHh5G79fO8e8yUYf3wKa8w3SW/?=
 =?us-ascii?Q?liy4TznzF0Z6fskytjf7sOqknULcoVrCZh4JJDAANNDYIP7k50Vz8MVmfVgB?=
 =?us-ascii?Q?HiJSCHvv+9FBnWpBLmUfb1i5VW395/9Ms90wGoSPK9DoEAyWuxz3fiYGJjy8?=
 =?us-ascii?Q?vVhz2/TwL+lLJIJuYb+fri8mNxuHPBFCueuUU3XOw07NPDXZZCpLQOechuJZ?=
 =?us-ascii?Q?K0Xdss+k8N4563Lwq+NMVf7gUxBvbdLZpoq0c7l9VocR3kNurShlnj93OKhB?=
 =?us-ascii?Q?pQfjZ8t9MJi1rXLtfDMjU3ZbywKxrmMia2xZG9gdsFPV9O/5TVQCAxWIPMf6?=
 =?us-ascii?Q?Sa+07k6WYFwTQwPLvhKCJG/0kT0zstYUFA8bgAYAU8adsw2hDueOrPl/B29U?=
 =?us-ascii?Q?eFltWNx/IFLSCKT/h9XWhQlM22WF1QIF4NFs8Qf/ULms+6yytfW20qUEEdGm?=
 =?us-ascii?Q?+VCtPkTeyd0JxeAA98J9DCb2/IaDu+mApbVCi3PaozOOLbIgtHIL01b2Yccw?=
 =?us-ascii?Q?jOkD1IhhBE+NP0vni2ktL2063+FGcSmKEpoMgMkScr48D1HL93VcN4XyxNKF?=
 =?us-ascii?Q?F4DT6/pkzuc6ETWw30dytPXSL6HhwPSakiiFWLRMsogm3KJbXOyi9tfigyWe?=
 =?us-ascii?Q?yhfLDV48C4ohRE1sfAKifzzTPmTln305MdigQOQ+nrBoxDrJhSdwb+EzyobN?=
 =?us-ascii?Q?U3PCFOd+ySRkB63P0ETYEZFVdkGH+jScSxRZYOUZ4CLjrEbFYNSiB4zsFoBK?=
 =?us-ascii?Q?1m+4LYj8/dH65ijCmjdC6/LvsG+Vnz6YCve6KgmD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9940faae-f356-42b2-de65-08de1260e739
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:54.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usPTyjy7L/xpx6hMIabrLo+rfkpbGrTjzQp6AYHUMxL+xR9v+M71dEUtXCxHCIXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

The existing IOMMU page table implementations duplicate all of the working
algorithms for each format. By using the generic page table API a single C
version of the IOMMU algorithms can be created and re-used for all of the
different formats used in the drivers. The implementation will provide a
single C version of the iommu domain operations: iova_to_phys, map, unmap,
and read_and_clear_dirty.

Further, adding new algorithms and techniques becomes easy to do across
the entire fleet of drivers and formats.

The C functions are drop in compatible with the existing iommu_domain_ops
using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
compilation unit will produce exported symbols following the pattern
pt_iommu_FMT_map_pages() which the macro directly maps to the
iommu_domain_ops members. This avoids the additional function pointer
indirection like io-pgtable has.

The top level struct used by the drivers is pt_iommu_table_FMT. It
contains the other structs to allow container_of() to move between the
driver, iommu page table, generic page table, and generic format layers.

   struct pt_iommu_table_amdv1 {
       struct pt_iommu {
	      struct iommu_domain domain;
       } iommu;
       struct pt_amdv1 {
	      struct pt_common common;
       } amdpt;
   };

The driver is expected to union the pt_iommu_table_FMT with its own
existing domain struct:

   struct driver_domain {
       union {
	       struct iommu_domain domain;
	       struct pt_iommu_table_amdv1 amdv1;
       };
   };
   PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);

To create an alias to avoid renaming 'domain' in a lot of driver code.

This allows all the layers to access all the necessary functions to
implement their different roles with no change to any of the existing
iommu core code.

Implement the basic starting point: pt_iommu_init(), get_info() and
deinit().

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  13 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 259 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 150 ++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index fb0f431ddba0a8..a81dfdd72ca016 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -17,4 +17,17 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
+	help
+	  Generic library for building IOMMU page tables
+
+	  IOMMU_PT provides an implementation of the page table operations
+	  related to struct iommu_domain using GENERIC_PT. It provides a single
+	  implementation of the page table operations that can be shared by
+	  multiple drivers.
 endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
new file mode 100644
index 00000000000000..5b631bc07cbc16
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Template to build the iommu module and kunit from the format and
+ * implementation headers.
+ *
+ * The format should have:
+ *  #define PT_FMT <name>
+ *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
+ * And optionally:
+ *  #define PT_FORCE_ENABLED_FEATURES ..
+ *  #define PT_FMT_VARIANT <suffix>
+ */
+#include <linux/args.h>
+#include <linux/stringify.h>
+
+#ifdef PT_FMT_VARIANT
+#define PTPFX_RAW \
+	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
+#else
+#define PTPFX_RAW PT_FMT
+#endif
+
+#define PTPFX CONCATENATE(PTPFX_RAW, _)
+
+#define _PT_FMT_H PT_FMT.h
+#define PT_FMT_H __stringify(_PT_FMT_H)
+
+#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
+#define PT_DEFS_H __stringify(_PT_DEFS_H)
+
+#include <linux/generic_pt/common.h>
+#include PT_DEFS_H
+#include "../pt_defs.h"
+#include PT_FMT_H
+#include "../pt_common.h"
+
+#include "../iommu_pt.h"
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
new file mode 100644
index 00000000000000..564f2d3a6e11e1
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * "Templated C code" for implementing the iommu operations for page tables.
+ * This is compiled multiple times, over all the page table formats to pick up
+ * the per-format definitions.
+ */
+#ifndef __GENERIC_PT_IOMMU_PT_H
+#define __GENERIC_PT_IOMMU_PT_H
+
+#include "pt_iter.h"
+
+#include <linux/export.h>
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+
+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
+
+struct pt_iommu_collect_args {
+	struct iommu_pages_list free_list;
+};
+
+static int __collect_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_collect_args *collect = arg;
+	int ret;
+
+	if (!pt_can_have_table(&pts))
+		return 0;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_pages_list_add(&collect->free_list, pts.table_lower);
+			ret = pt_descend(&pts, arg, __collect_tables);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+	return 0;
+}
+
+static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
+						 uintptr_t top_of_table,
+						 gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(common);
+
+	/*
+	 * Top doesn't need the free list or otherwise, so it technically
+	 * doesn't need to use iommu pages. Use the API anyhow as the top is
+	 * usually not smaller than PAGE_SIZE to keep things simple.
+	 */
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
+}
+
+static void NS(get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_top_range(common);
+	struct pt_state pts = pt_init_top(&range);
+	pt_vaddr_t pgsize_bitmap = 0;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
+		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
+		     pts.level++) {
+			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
+				break;
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+		}
+	} else {
+		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+	}
+
+	/* Hide page sizes larger than the maximum OA */
+	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	/*
+	 * The driver has to already have fenced the HW access to the page table
+	 * and invalidated any caching referring to this memory.
+	 */
+	iommu_put_pages_list(&collect.free_list);
+}
+
+static const struct pt_iommu_ops NS(ops) = {
+	.get_info = NS(get_info),
+	.deinit = NS(deinit),
+};
+
+static int pt_init_common(struct pt_common *common)
+{
+	struct pt_range top_range = pt_top_range(common);
+
+	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
+		return -EINVAL;
+
+	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
+	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
+		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
+
+	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
+		common->features |= BIT(PT_FEAT_FULL_VA);
+
+	/* Requested features must match features compiled into this format */
+	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
+	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
+	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
+		     PT_FORCE_ENABLED_FEATURES))
+		return -EOPNOTSUPP;
+
+	if (common->max_oasz_lg2 == 0)
+		common->max_oasz_lg2 = pt_max_oa_lg2(common);
+	else
+		common->max_oasz_lg2 = min(common->max_oasz_lg2,
+					   pt_max_oa_lg2(common));
+	return 0;
+}
+
+static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
+				struct iommu_domain *domain)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_iommu_info info;
+	struct pt_range range;
+
+	NS(get_info)(iommu_table, &info);
+
+	domain->type = __IOMMU_DOMAIN_PAGING;
+	domain->pgsize_bitmap = info.pgsize_bitmap;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		range = _pt_top_range(common,
+				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
+	else
+		range = pt_top_range(common);
+
+	/* A 64-bit high address space table on a 32-bit system cannot work. */
+	domain->geometry.aperture_start = (unsigned long)range.va;
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va)
+		return -EOVERFLOW;
+
+	/*
+	 * The aperture is limited to what the API can do after considering all
+	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
+	 * to store a VA. Set the aperture to something that is valid for all
+	 * cases. Saturate instead of truncate the end if the types are smaller
+	 * than the top range. aperture_end should be called aperture_last.
+	 */
+	domain->geometry.aperture_end = (unsigned long)range.last_va;
+	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
+		domain->geometry.aperture_end = ULONG_MAX;
+		domain->pgsize_bitmap &= ULONG_MAX;
+	}
+	domain->geometry.force_aperture = true;
+
+	return 0;
+}
+
+static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_iommu cfg = *iommu_table;
+
+	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
+	memset_after(fmt_table, 0, iommu.domain);
+
+	/* The caller can initialize some of these values */
+	iommu_table->nid = cfg.nid;
+}
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_table_p *table_mem;
+	int ret;
+
+	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
+	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
+		return -EINVAL;
+
+	pt_iommu_zero(fmt_table);
+	common->features = cfg->common.features;
+	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
+	ret = pt_iommu_fmt_init(fmt_table, cfg);
+	if (ret)
+		return ret;
+
+	if (cfg->common.hw_max_oasz_lg2 > pt_max_oa_lg2(common))
+		return -EINVAL;
+
+	ret = pt_init_common(common);
+	if (ret)
+		return ret;
+
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
+	    (pt_feature(common, PT_FEAT_FULL_VA) ||
+	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
+		return -EINVAL;
+
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+
+	/* Must be last, see pt_iommu_deinit() */
+	iommu_table->ops = &NS(ops);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
+
+#ifdef pt_iommu_fmt_hw_info
+#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
+#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
+void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
+		      struct pt_iommu_table_hw_info *info)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range top_range = pt_top_range(common);
+
+	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
+MODULE_IMPORT_NS("GENERIC_PT");
+
+#endif  /* __GENERIC_PT_IOMMU_PT_H */
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
new file mode 100644
index 00000000000000..defa96abc49781
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_IOMMU_H
+#define __GENERIC_PT_IOMMU_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+struct pt_iommu_ops;
+
+/**
+ * DOC: IOMMU Radix Page Table
+ *
+ * The IOMMU implementation of the Generic Page Table provides an ops struct
+ * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
+ * the generic map/unmap interface.
+ *
+ * This interface uses a caller provided locking approach. The caller must have
+ * a VA range lock concept that prevents concurrent threads from calling ops on
+ * the same VA. Generally the range lock must be at least as large as a single
+ * map call.
+ */
+
+/**
+ * struct pt_iommu - Base structure for IOMMU page tables
+ *
+ * The format-specific struct will include this as the first member.
+ */
+struct pt_iommu {
+	/**
+	 * @domain: The core IOMMU domain. The driver should use a union to
+	 * overlay this memory with its previously existing domain struct to
+	 * create an alias.
+	 */
+	struct iommu_domain domain;
+
+	/**
+	 * @ops: Function pointers to access the API
+	 */
+	const struct pt_iommu_ops *ops;
+
+	/**
+	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
+	 * may want to set the NID to the device's NID, if there are multiple
+	 * table walkers.
+	 */
+	int nid;
+};
+
+/**
+ * struct pt_iommu_info - Details about the IOMMU page table
+ *
+ * Returned from pt_iommu_ops->get_info()
+ */
+struct pt_iommu_info {
+	/**
+	 * @pgsize_bitmap: A bitmask where each set bit indicates
+	 * a page size that can be natively stored in the page table.
+	 */
+	u64 pgsize_bitmap;
+};
+
+struct pt_iommu_ops {
+	/**
+	 * @get_info: Return the pt_iommu_info structure
+	 * @iommu_table: Table to query
+	 *
+	 * Return some basic static information about the page table.
+	 */
+	void (*get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info);
+
+	/**
+	 * @deinit: Undo a format specific init operation
+	 * @iommu_table: Table to destroy
+	 *
+	 * Release all of the memory. The caller must have already removed the
+	 * table from all HW access and all caches.
+	 */
+	void (*deinit)(struct pt_iommu *iommu_table);
+};
+
+static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
+{
+	/*
+	 * It is safe to call pt_iommu_deinit() before an init, or if init
+	 * fails. The ops pointer will only become non-NULL if deinit needs to be
+	 * run.
+	 */
+	if (iommu_table->ops)
+		iommu_table->ops->deinit(iommu_table);
+}
+
+/**
+ * struct pt_iommu_cfg - Common configuration values for all formats
+ */
+struct pt_iommu_cfg {
+	/**
+	 * @features: Features required. Only these features will be turned on.
+	 * The feature list should reflect what the IOMMU HW is capable of.
+	 */
+	unsigned int features;
+	/**
+	 * @hw_max_vasz_lg2: Maximum VA the IOMMU HW can support. This will
+	 * imply the top level of the table.
+	 */
+	u8 hw_max_vasz_lg2;
+	/**
+	 * @hw_max_oasz_lg2: Maximum OA the IOMMU HW can support. The format
+	 * might select a lower maximum OA.
+	 */
+	u8 hw_max_oasz_lg2;
+};
+
+/* Generate the exported function signatures from iommu_pt.h */
+#define IOMMU_PROTOTYPES(fmt)                                             \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
+				  const struct pt_iommu_##fmt##_cfg *cfg, \
+				  gfp_t gfp);                             \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+				      struct pt_iommu_##fmt##_hw_info *info)
+#define IOMMU_FORMAT(fmt, member)       \
+	struct pt_iommu_##fmt {         \
+		struct pt_iommu iommu;  \
+		struct pt_##fmt member; \
+	};                              \
+	IOMMU_PROTOTYPES(fmt)
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
+
+#undef IOMMU_PROTOTYPES
+#undef IOMMU_FORMAT
+#endif
-- 
2.43.0


