Return-Path: <linux-kselftest+bounces-42847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C4BC217B
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E70924F656A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896712E7F0E;
	Tue,  7 Oct 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZ7q6fpJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89132E7BC1;
	Tue,  7 Oct 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853961; cv=fail; b=uMpnId03d68qgeYFkk1STp73Bw/DlwwikiQMYspoj1Yy8nYCbCaOObEHmlHjqi6+AwpHubfeEMhz1sHL4oeKnklK0mWPKRdl/M9gYJNA6rBbpjXnsdcWPKZxjt6/ERb8pLWxwYbC5T5EjGDKFVj27cxeEXHvY0WZQl/ib+Cp3e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853961; c=relaxed/simple;
	bh=7As4kZtScBhsCI9pgUSw7H1x1Lg5q2XVb2ZG5EVpU5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqhTADC0JYR88WPV5gY5H0y+L9pcsUrojdku82HgjavsSToEntPuQ1M0YvKOgu2bfCBN+HvGfbHDxa3rOskEbJwKhPrECF4FA84csKj4MLkatOt8AyqqgnK0+YaNNOTX78cYGE/R24TlwKqHKHqPH6U3cuTHAQJSZueY3MNVOKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZ7q6fpJ; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqz46erClMc8bdOIM4mBcEccchoqn1w/Mcstbg3za3+EjPk9U9X1KtZcLcA4vJhzDGc3g5hXWDlgeu10OqIGWIvLAF3Ue/gj3oOl+OmTOvqn+mgTNCNCJiPOEhZOxUGnH51fi4KSRqJ47xmRo1bH7GuaCnThYAPuRFmoijfiwvW/MNk0B0P2OyFPh7Q9L1MuUHY3QDZOD5dgj/GJ5KA1FSjBXP+0AcOnu5/cn1ESCe5EoEIGEvLw+9o3F5U0DRhUbnH6QRSi9aws8lyKudtl7IGGKftiUySxQ+pxvNsNSSF9pRAYX8Ciw5tmsVibzH5Hho/Ny2vlvUzoiasjg6R50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvlcRVwkWS8qd/ywb1RQ+c6ELSxVgdxd8+0130NrMZI=;
 b=SV4TOOw+yqFrZatmhxn/TWVkSegh9kngznDSS+jchdRNuE+apU9j8OA6Ur+2ysQPhIkRLQ0M6G6yNMbIGQDmr740bZGEWvOBlIUDI6vY7Lhu9Pm2aW2Bfywd7w92QmLzSstqQUFBszUx+h+NUx3jwitBm4u9RAN8qjfGZSAI761smpEpxAq6iXrIxdhQoJVCAHoVlQUjDuPhSfAwJrFdVw8PX+snFc1I/RzpM+iJVNzZeWxARixnKdD38FWcQ6C/ihsM+i0pOnQe7kpGSjPqerZwd2DiU8laMsfHRYYxzv3DTh7p8El2+JV/ekIkvEbMzGKm5BQkVmRn8XEFSE9C0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvlcRVwkWS8qd/ywb1RQ+c6ELSxVgdxd8+0130NrMZI=;
 b=eZ7q6fpJBhv0TR10rD2LA30OHYE5sFVdJ8WCmySCMsDgRnLxTgZJBD6+EmCylQr2/niG92uNqiGp7Euc9tH2xRJex16ZyVj08d+o4Q9/f5sI4AmSNO75xp5j87S+Eb2zClYLufDXg0Q1F1LvrIjqCXiCoXMd7310EG5EhLt8qcUiHvw23sendnMP6KmgngWUdsOEyQ1GSCctqIID1en6UeB9sNIQ9JvtXEYeNMxKu2xXnK/CjZjUk9QBFMyls47LKzfyx3l9eFV8Qe9BGNZh+f2135LsQnVBxBt9D6iG1AxGwaQbFXtDAuRIjr69P6fm/XA8+3KJoXAoWu/hBfpbKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:19:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:18:59 +0000
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
Subject: [PATCH v6 14/15] iommu/amd: Remove AMD io_pgtable support
Date: Tue,  7 Oct 2025 13:11:59 -0300
Message-ID: <14-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0293.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b9f3fb-16c3-47d6-6b61-08de05bd387f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1wJzlwuJAvMnNXUrwf0i6qjAuz+l80eusBjIf/hZh17j0wVQK0tPRaFjwBd?=
 =?us-ascii?Q?oMvKDB5WjV+/+i+R1Di6TmOYTHXx1lMe5BKQNAmAUWPvWZZ7uqGg76B4kulF?=
 =?us-ascii?Q?LCWBq6m8qiT9HBjBRBFKf1UMrBWe3IwqLEanADAMl7Leodvg0TvOiXpGuZX0?=
 =?us-ascii?Q?6P1l9M2EzBFuu2lTcOzVLUzZ1JYwe2Ra5MioDGW/vNjeJhwWgxyC+UOidp+S?=
 =?us-ascii?Q?TAP2J9o8Zn18oq5+JulTR86/WjMiMylwd4EwLaVan/QrfnzOKdBCQU5wcycP?=
 =?us-ascii?Q?Tc6L8yM5BSV7glvk1riugm+5OUwaYOB4PuxQxcaXISvcbu+wE4WcT3Qc5BMc?=
 =?us-ascii?Q?jrvML7++cGXa2a2ge4wdTiERY+VmVA7clCsAJcJy0MfrGZnj8rTO3ybptGhj?=
 =?us-ascii?Q?nfsOAJHK9bWc0T+HKLlWsB4IAe6l9cH2IUswuf1+GSUh9Y/2okxGum7KDRcV?=
 =?us-ascii?Q?VHM7bm0l/rJ5R/Sk2mnc+rt94DjGDCyDrAQ/gqQxSJQOBHBTckMgbszTg4XP?=
 =?us-ascii?Q?tgIjx7MnAHzPcT/fp7QjBPe6c5H96Lt+hfClsnPdjR3IwbSHal9lPso9gT1p?=
 =?us-ascii?Q?k9p6OL6rMfHNnJBn39YJa/s+AbL2/QIRo8AVR5Oowcq7zsNMA7S2zSmDiEUi?=
 =?us-ascii?Q?pfk3K1p7H3fD7JZ3q9ORysoZTl2eL+6eDfJxtsKZT6wEBpX3VBS7tcL6k6Bq?=
 =?us-ascii?Q?heoARID/3avY7KADUI+6q1+HFULzClqHe0wn6FI4H6ACyTasLtS5AwBEB8aG?=
 =?us-ascii?Q?96PbzbxpK41JGCSa7kc1vBzTTEVfy/89BEhn5TwIpAlTdoSM2FeLn6WrlVQy?=
 =?us-ascii?Q?J991lbV0iDLbbIvxQcf7W1F0sM6lnPOksONSVFgmM37kT5ZA5yTfDSud7BYg?=
 =?us-ascii?Q?P+6C6TQXCngki9BCfvU0Z01Iv+56S7tJe0ikfQ13mc2r3t9pozL/6ySoTfLw?=
 =?us-ascii?Q?WGIcDmOk5qVKcO3Lx/e5FzC0k19HIQ7GVj0AaqFowdj1xPWQM/Cfc1Y1CeMc?=
 =?us-ascii?Q?BmXk65ex7/VlF2AOKWKuZZa41rKRA0w3IKn8A2D7HPZPWWXCwe7u0qUTxAEz?=
 =?us-ascii?Q?ICrB80xhPAlaK1UrQwkJO56+pz94LcKLUC8HTErp/pJFnDxwCp/B5niG8fsS?=
 =?us-ascii?Q?mq+vuxse90MbDQVUJ5iOYbDS4Ia45rjCUf7G94sg4wI3460rUwVRmYUL3mET?=
 =?us-ascii?Q?doJSb82m6Fq5atHJo2sIA0r9QdkGPgOAjm3dm+f9e5ZBmUHlGUnNkkErugrn?=
 =?us-ascii?Q?2o4amvAmS3f5ePS/Vi7Eacgt58WkB6ZXPL8Ep7KzvCQwAym5UL1TXMhvNV6h?=
 =?us-ascii?Q?JmdnSDMeTgsnW65PnB7bdcw3GGnZjAYttXF7j9MrEMj2jD5/wZ1tFfJtFKDl?=
 =?us-ascii?Q?qBkASClRqAU2HLVe45RBSzyAReLrYyumULmcJ4yIB5DI05Mm3twuv/F52C2R?=
 =?us-ascii?Q?oyuCPAeGcOYjVynjadffCBUMhcBWldO96xmPxpbt+j2jPXUUYBgmJmbNbs3f?=
 =?us-ascii?Q?meTsOYTdZN7dv+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KIhjWJq1ruDgimaupG3FXl6DCIw92MHv41nqNYHzn/D7fuBCMkii9O6RM7Q?=
 =?us-ascii?Q?pKWs5jpywbmPKOxFti5nGubjjmvi5+pmcauxacP1qmuAdDvzyikjJbvMpyz5?=
 =?us-ascii?Q?LDUcWcUEgAE3PDEwZmhHPIWkiC6mlgU5SkJcG5wAaT49qS2qAUWaFQt8COVe?=
 =?us-ascii?Q?NjvRBZJ787vl+riRBN2o3lawogkCZjFI8ez6JjqWHJt2cuossLc7eZhToQZ6?=
 =?us-ascii?Q?gbqVNKXKmfcDflymrphQKtytiHWTAnk4r2eHmRRvDOugkUSoEsgg0YV3gFsV?=
 =?us-ascii?Q?aa0g9YHINobVPmME5mSuC9oh668EC+WjYZWToZ7lhmw9eLX5CzRWyNx4uADh?=
 =?us-ascii?Q?IFf8vbe1U77IAW0m/LL1FLBYbD0mui23wlrlu8wkShDZbcCqnACwg6glxSYK?=
 =?us-ascii?Q?/Wo1rCluvX9g6buXXLaXvB9a4PY23Nia1eB9097ZmZwYFBA2CXuP8UdaOInA?=
 =?us-ascii?Q?K/Vty35hMqeEK4ufanvX4vfbUqj0eMZzYKiE2LeWdPDeHW23Uz2Rwnz0xLvc?=
 =?us-ascii?Q?VhFLLqSt0kF+hCfX/YqRbL0dbJ03qhxOySF0zBqBhRhw8PO35SK5huHvdgV7?=
 =?us-ascii?Q?YdqIhtlqXlN0gjRsXyRjyiaCCNatDN/y/ucr/CV6fwTrpIjBRPwZ65EGy929?=
 =?us-ascii?Q?k82Xt8YH6u54BiAiNOOiHw2j6eLWII0ixENZpH/x+dXIEn5mbghtEah0ZXVR?=
 =?us-ascii?Q?4j65aqqvkIOiOnkboQkla24ngtqK/iAos50Q9EO0QF+nqxP6MxBeSRv8jq5S?=
 =?us-ascii?Q?AhnLcs3zmTPcmZ0hRejcbhSIHekIAboYhw4xwQbX6S5Uxo7UdD7ChYTV7NSA?=
 =?us-ascii?Q?1kQvLU39xQx4HpotlnSq/sQRAuGoEa/MYpZEGKliBWt3x0x7i01Sz1/o/5iD?=
 =?us-ascii?Q?ZVbuKEBDRBm7bBKu9VyO3H+EGY3iUnd7muFdMwz1MGi7V3zt5oPKk9Bu2OUw?=
 =?us-ascii?Q?gJLQ6xlEjY+6Zas9agsN3/YIEieGMXUKAV74ITKU9A1GCvywGGuOqsoh/PzB?=
 =?us-ascii?Q?yUtRO512NUxAP+fkFcOz6uez6V2px/4vuuJMeeHjAjchV7ri41d+k+YAZxYJ?=
 =?us-ascii?Q?kHyS+uAfF/9WuB0PNfAYNwUiaSIT2dGQ6H3f1KH9cAcbsrqD7yU17CcxfuvU?=
 =?us-ascii?Q?bWq47qeU2UUzF0vVyjuTGzqoiDQk4+3cTvDiO+UjUG1pbBeQLkeSWExhGsLM?=
 =?us-ascii?Q?Kjnjomz0xnACAY09RjJKUK8MsY2fL4iy0he8zPns4MdPFGkAigTIZulLlR5U?=
 =?us-ascii?Q?yC319Gd0xu03WRnO1WclAZorFszaT4bBECVDF4yTvRcH6MfQlRwNuiFPrrm1?=
 =?us-ascii?Q?fvT0Vn1iyZT/DbS4v9EzqMltF6HCGUmHiKZJW9VBQAiDc42c/1B/MFz1TyYm?=
 =?us-ascii?Q?p1eHbzNqY73f1g0DEd/RO7kCgn88xH7kokDOfxqD9BoPeGbrXR00mD+Q4lsx?=
 =?us-ascii?Q?3iJxdtKT+VD7Bp1rEs8VwZjf5KlP5W7R4pT2V/sx/UDMKVOFHxE+ce9hwgL0?=
 =?us-ascii?Q?Uwj80sHlUADuBpGb3Odcj3uFaqMCiZaC9EanwJMEb89I3rc4tSQ3K702yfNe?=
 =?us-ascii?Q?4O/ySrlyb6mtpKenLIo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b9f3fb-16c3-47d6-6b61-08de05bd387f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:18:59.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIK73KLbaMTm/wYpjZYCEIkl9XnFJRkcFJzyoFtPHseKmGp1KOKwpLQmoH7vetuX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

None of this is used anymore, delete it.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |  98 -----
 drivers/iommu/amd/io_pgtable.c      | 575 ----------------------------
 drivers/iommu/amd/io_pgtable_v2.c   | 370 ------------------
 drivers/iommu/io-pgtable.c          |   4 -
 include/linux/io-pgtable.h          |   2 -
 6 files changed, 1 insertion(+), 1050 deletions(-)
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 59c04a67f39825..5412a563c6979c 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-y += iommu.o init.o quirks.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d1849d5dc58608..dde3d8f5b822b9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -18,7 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
-#include <linux/io-pgtable.h>
 #include <linux/generic_pt/iommu.h>
 
 /*
@@ -338,76 +337,7 @@
 #define GUEST_PGTABLE_4_LEVEL	0x00
 #define GUEST_PGTABLE_5_LEVEL	0x01
 
-#define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
-#define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
-				  ((1ULL << PM_LEVEL_SHIFT((x))) - 1): \
-				   (0xffffffffffffffffULL))
-#define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
-#define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
-#define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
-				 IOMMU_PTE_PR | IOMMU_PTE_IR | IOMMU_PTE_IW)
-#define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
-
-#define PM_MAP_4k		0
 #define PM_ADDR_MASK		0x000ffffffffff000ULL
-#define PM_MAP_MASK(lvl)	(PM_ADDR_MASK & \
-				(~((1ULL << (12 + ((lvl) * 9))) - 1)))
-#define PM_ALIGNED(lvl, addr)	((PM_MAP_MASK(lvl) & (addr)) == (addr))
-
-/*
- * Returns the page table level to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_LEVEL(pagesize) \
-		((__ffs(pagesize) - 12) / 9)
-/*
- * Returns the number of ptes to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_PTE_COUNT(pagesize) \
-		(1ULL << ((__ffs(pagesize) - 12) % 9))
-
-/*
- * Aligns a given io-virtual address to a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_ALIGN(address, pagesize) \
-		((address) & ~((pagesize) - 1))
-/*
- * Creates an IOMMU PTE for an address and a given pagesize
- * The PTE has no permission bits set
- * Pagesize is expected to be a power-of-two larger than 4096
- */
-#define PAGE_SIZE_PTE(address, pagesize)		\
-		(((address) | ((pagesize) - 1)) &	\
-		 (~(pagesize >> 1)) & PM_ADDR_MASK)
-
-/*
- * Takes a PTE value with mode=0x07 and returns the page size it maps
- */
-#define PTE_PAGE_SIZE(pte) \
-	(1ULL << (1 + ffz(((pte) | 0xfffULL))))
-
-/*
- * Takes a page-table level and returns the default page-size for this level
- */
-#define PTE_LEVEL_PAGE_SIZE(level)			\
-	(1ULL << (12 + (9 * (level))))
-
-/*
- * The IOPTE dirty bit
- */
-#define IOMMU_PTE_HD_BIT (6)
-
-/*
- * Bit value definition for I/O PTE fields
- */
-#define IOMMU_PTE_PR	BIT_ULL(0)
-#define IOMMU_PTE_HD	BIT_ULL(IOMMU_PTE_HD_BIT)
-#define IOMMU_PTE_U	BIT_ULL(59)
-#define IOMMU_PTE_FC	BIT_ULL(60)
-#define IOMMU_PTE_IR	BIT_ULL(61)
-#define IOMMU_PTE_IW	BIT_ULL(62)
 
 /*
  * Bit value definition for DTE fields
@@ -437,12 +367,6 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
-#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
-#define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
-#define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
-#define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
-
 #define IOMMU_PROT_MASK 0x03
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
@@ -535,19 +459,6 @@ struct amd_irte_ops;
 
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
 
-#define io_pgtable_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl)
-
-#define io_pgtable_ops_to_data(x) \
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-#define io_pgtable_ops_to_domain(x) \
-	container_of(io_pgtable_ops_to_data(x), \
-		     struct protection_domain, iop)
-
-#define io_pgtable_cfg_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl.cfg)
-
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
@@ -555,14 +466,6 @@ struct gcr3_tbl_info {
 	u16	domid;		/* Per device domain ID */
 };
 
-struct amd_io_pgtable {
-	seqcount_t		seqcount;	/* Protects root/mode update */
-	struct io_pgtable	pgtbl;
-	int			mode;
-	u64			*root;
-	u64			*pgd;		/* v2 pgtable pgd pointer */
-};
-
 enum protection_domain_mode {
 	PD_MODE_NONE,
 	PD_MODE_V1,
@@ -597,7 +500,6 @@ struct protection_domain {
 		struct pt_iommu_x86_64 amdv2;
 	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
deleted file mode 100644
index f64244938c9af7..00000000000000
--- a/drivers/iommu/amd/io_pgtable.c
+++ /dev/null
@@ -1,575 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table allocator.
- *
- * Copyright (C) 2020 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- */
-
-#define pr_fmt(fmt)     "AMD-Vi: " fmt
-#define dev_fmt(fmt)    pr_fmt(fmt)
-
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/dma-mapping.h>
-#include <linux/seqlock.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-/*
- * Helper function to get the first pte of a large mapping
- */
-static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
-			 unsigned long *count)
-{
-	unsigned long pte_mask, pg_size, cnt;
-	u64 *fpte;
-
-	pg_size  = PTE_PAGE_SIZE(*pte);
-	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
-	pte_mask = ~((cnt << 3) - 1);
-	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
-
-	if (page_size)
-		*page_size = pg_size;
-
-	if (count)
-		*count = cnt;
-
-	return fpte;
-}
-
-static void free_pt_lvl(u64 *pt, struct iommu_pages_list *freelist, int lvl)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < 512; ++i) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		/* Large PTE? */
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||
-		    PM_PTE_LEVEL(pt[i]) == 7)
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = IOMMU_PTE_PAGE(pt[i]);
-		if (lvl > 2)
-			free_pt_lvl(p, freelist, lvl - 1);
-		else
-			iommu_pages_list_add(freelist, p);
-	}
-
-	iommu_pages_list_add(freelist, pt);
-}
-
-static void free_sub_pt(u64 *root, int mode, struct iommu_pages_list *freelist)
-{
-	switch (mode) {
-	case PAGE_MODE_NONE:
-	case PAGE_MODE_7_LEVEL:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		iommu_pages_list_add(freelist, root);
-		break;
-	case PAGE_MODE_2_LEVEL:
-	case PAGE_MODE_3_LEVEL:
-	case PAGE_MODE_4_LEVEL:
-	case PAGE_MODE_5_LEVEL:
-	case PAGE_MODE_6_LEVEL:
-		free_pt_lvl(root, freelist, mode);
-		break;
-	default:
-		BUG();
-	}
-}
-
-/*
- * This function is used to add another level to an IO page table. Adding
- * another level increases the size of the address space by 9 bits to a size up
- * to 64 bits.
- */
-static bool increase_address_space(struct amd_io_pgtable *pgtable,
-				   unsigned long address,
-				   unsigned int page_size_level,
-				   gfp_t gfp)
-{
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	struct protection_domain *domain =
-		container_of(pgtable, struct protection_domain, iop);
-	unsigned long flags;
-	bool ret = true;
-	u64 *pte;
-
-	pte = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp, SZ_4K);
-	if (!pte)
-		return false;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (address <= PM_LEVEL_SIZE(pgtable->mode) &&
-	    pgtable->mode - 1 >= page_size_level)
-		goto out;
-
-	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == amd_iommu_hpt_level))
-		goto out;
-
-	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
-
-	write_seqcount_begin(&pgtable->seqcount);
-	pgtable->root  = pte;
-	pgtable->mode += 1;
-	write_seqcount_end(&pgtable->seqcount);
-
-	pte = NULL;
-	ret = true;
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-	iommu_free_pages(pte);
-
-	return ret;
-}
-
-static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long page_size,
-		      u64 **pte_page,
-		      gfp_t gfp,
-		      bool *updated)
-{
-	unsigned long last_addr = address + (page_size - 1);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	unsigned int seqcount;
-	int level, end_lvl;
-	u64 *pte, *page;
-
-	BUG_ON(!is_power_of_2(page_size));
-
-	while (last_addr > PM_LEVEL_SIZE(pgtable->mode) ||
-	       pgtable->mode - 1 < PAGE_SIZE_LEVEL(page_size)) {
-		/*
-		 * Return an error if there is no memory to update the
-		 * page-table.
-		 */
-		if (!increase_address_space(pgtable, last_addr,
-					    PAGE_SIZE_LEVEL(page_size), gfp))
-			return NULL;
-	}
-
-
-	do {
-		seqcount = read_seqcount_begin(&pgtable->seqcount);
-
-		level   = pgtable->mode - 1;
-		pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
-
-
-	address = PAGE_SIZE_ALIGN(address, page_size);
-	end_lvl = PAGE_SIZE_LEVEL(page_size);
-
-	while (level > end_lvl) {
-		u64 __pte, __npte;
-		int pte_level;
-
-		__pte     = *pte;
-		pte_level = PM_PTE_LEVEL(__pte);
-
-		/*
-		 * If we replace a series of large PTEs, we need
-		 * to tear down all of them.
-		 */
-		if (IOMMU_PTE_PRESENT(__pte) &&
-		    pte_level == PAGE_MODE_7_LEVEL) {
-			unsigned long count, i;
-			u64 *lpte;
-
-			lpte = first_pte_l7(pte, NULL, &count);
-
-			/*
-			 * Unmap the replicated PTEs that still match the
-			 * original large mapping
-			 */
-			for (i = 0; i < count; ++i)
-				cmpxchg64(&lpte[i], __pte, 0ULL);
-
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte) ||
-		    pte_level == PAGE_MODE_NONE) {
-			page = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp,
-							 SZ_4K);
-
-			if (!page)
-				return NULL;
-
-			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
-
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		/* No level skipping support yet */
-		if (pte_level != level)
-			return NULL;
-
-		level -= 1;
-
-		pte = IOMMU_PTE_PAGE(__pte);
-
-		if (pte_page && level == end_lvl)
-			*pte_page = pte;
-
-		pte = &pte[PM_LEVEL_INDEX(level, address)];
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address. If
- * there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long *page_size)
-{
-	int level;
-	unsigned int seqcount;
-	u64 *pte;
-
-	*page_size = 0;
-
-	if (address > PM_LEVEL_SIZE(pgtable->mode))
-		return NULL;
-
-	do {
-		seqcount = read_seqcount_begin(&pgtable->seqcount);
-		level	   =  pgtable->mode - 1;
-		pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
-
-	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
-
-	while (level > 0) {
-
-		/* Not Present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
-		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
-			break;
-
-		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
-			return NULL;
-
-		level -= 1;
-
-		/* Walk to the next level */
-		pte	   = IOMMU_PTE_PAGE(*pte);
-		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
-		*page_size = PTE_LEVEL_PAGE_SIZE(level);
-	}
-
-	/*
-	 * If we have a series of large PTEs, make
-	 * sure to return a pointer to the first one.
-	 */
-	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
-		pte = first_pte_l7(pte, page_size, NULL);
-
-	return pte;
-}
-
-static void free_clear_pte(u64 *pte, u64 pteval,
-			   struct iommu_pages_list *freelist)
-{
-	u64 *pt;
-	int mode;
-
-	while (!try_cmpxchg64(pte, &pteval, 0))
-		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-
-	if (!IOMMU_PTE_PRESENT(pteval))
-		return;
-
-	pt   = IOMMU_PTE_PAGE(pteval);
-	mode = IOMMU_PTE_MODE(pteval);
-
-	free_sub_pt(pt, mode, freelist);
-}
-
-/*
- * Generic mapping functions. It maps a physical address into a DMA
- * address space. It allocates the page table pages if necessary.
- * In the future it can be extended to a generic mapping function
- * supporting all features of AMD IOMMU page tables like level skipping
- * and full 64 bit address spaces.
- */
-static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-	bool updated = false;
-	u64 __pte, *pte;
-	int ret, i, count;
-	size_t size = pgcount << __ffs(pgsize);
-	unsigned long o_iova = iova;
-
-	BUG_ON(!IS_ALIGNED(iova, pgsize));
-	BUG_ON(!IS_ALIGNED(paddr, pgsize));
-
-	ret = -EINVAL;
-	if (!(prot & IOMMU_PROT_MASK))
-		goto out;
-
-	while (pgcount > 0) {
-		count = PAGE_SIZE_PTE_COUNT(pgsize);
-		pte   = alloc_pte(pgtable, iova, pgsize, NULL, gfp, &updated);
-
-		ret = -ENOMEM;
-		if (!pte)
-			goto out;
-
-		for (i = 0; i < count; ++i)
-			free_clear_pte(&pte[i], pte[i], &freelist);
-
-		if (!iommu_pages_list_empty(&freelist))
-			updated = true;
-
-		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
-			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-
-		if (prot & IOMMU_PROT_IR)
-			__pte |= IOMMU_PTE_IR;
-		if (prot & IOMMU_PROT_IW)
-			__pte |= IOMMU_PTE_IW;
-
-		for (i = 0; i < count; ++i)
-			pte[i] = __pte;
-
-		iova  += pgsize;
-		paddr += pgsize;
-		pgcount--;
-		if (mapped)
-			*mapped += pgsize;
-	}
-
-	ret = 0;
-
-out:
-	if (updated) {
-		struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&dom->lock, flags);
-		/*
-		 * Flush domain TLB(s) and wait for completion. Any Device-Table
-		 * Updates and flushing already happened in
-		 * increase_address_space().
-		 */
-		amd_iommu_domain_flush_pages(dom, o_iova, size);
-		spin_unlock_irqrestore(&dom->lock, flags);
-	}
-
-	/* Everything flushed out, free pages now */
-	iommu_put_pages_list(&freelist);
-
-	return ret;
-}
-
-static unsigned long iommu_v1_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long long unmapped;
-	unsigned long unmap_size;
-	u64 *pte;
-	size_t size = pgcount << __ffs(pgsize);
-
-	BUG_ON(!is_power_of_2(pgsize));
-
-	unmapped = 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (pte) {
-			int i, count;
-
-			count = PAGE_SIZE_PTE_COUNT(unmap_size);
-			for (i = 0; i < count; i++)
-				pte[i] = 0ULL;
-		} else {
-			return unmapped;
-		}
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-static bool pte_test_and_clear_dirty(u64 *ptep, unsigned long size,
-				     unsigned long flags)
-{
-	bool test_only = flags & IOMMU_DIRTY_NO_CLEAR;
-	bool dirty = false;
-	int i, count;
-
-	/*
-	 * 2.2.3.2 Host Dirty Support
-	 * When a non-default page size is used , software must OR the
-	 * Dirty bits in all of the replicated host PTEs used to map
-	 * the page. The IOMMU does not guarantee the Dirty bits are
-	 * set in all of the replicated PTEs. Any portion of the page
-	 * may have been written even if the Dirty bit is set in only
-	 * one of the replicated PTEs.
-	 */
-	count = PAGE_SIZE_PTE_COUNT(size);
-	for (i = 0; i < count && test_only; i++) {
-		if (test_bit(IOMMU_PTE_HD_BIT, (unsigned long *)&ptep[i])) {
-			dirty = true;
-			break;
-		}
-	}
-
-	for (i = 0; i < count && !test_only; i++) {
-		if (test_and_clear_bit(IOMMU_PTE_HD_BIT,
-				       (unsigned long *)&ptep[i])) {
-			dirty = true;
-		}
-	}
-
-	return dirty;
-}
-
-static int iommu_v1_read_and_clear_dirty(struct io_pgtable_ops *ops,
-					 unsigned long iova, size_t size,
-					 unsigned long flags,
-					 struct iommu_dirty_bitmap *dirty)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long end = iova + size - 1;
-
-	do {
-		unsigned long pgsize = 0;
-		u64 *ptep, pte;
-
-		ptep = fetch_pte(pgtable, iova, &pgsize);
-		if (ptep)
-			pte = READ_ONCE(*ptep);
-		if (!ptep || !IOMMU_PTE_PRESENT(pte)) {
-			pgsize = pgsize ?: PTE_LEVEL_PAGE_SIZE(0);
-			iova += pgsize;
-			continue;
-		}
-
-		/*
-		 * Mark the whole IOVA range as dirty even if only one of
-		 * the replicated PTEs were marked dirty.
-		 */
-		if (pte_test_and_clear_dirty(ptep, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, iova, pgsize);
-		iova += pgsize;
-	} while (iova < end);
-
-	return 0;
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v1_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return;
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > amd_iommu_hpt_level);
-
-	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
-	iommu_put_pages_list(&freelist);
-}
-
-static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-
-	pgtable->root =
-		iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->root)
-		return NULL;
-	pgtable->mode = PAGE_MODE_3_LEVEL;
-	seqcount_init(&pgtable->seqcount);
-
-	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
-	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
-	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v1_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v1_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v1_iova_to_phys;
-	pgtable->pgtbl.ops.read_and_clear_dirty = iommu_v1_read_and_clear_dirty;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
-	.alloc	= v1_alloc_pgtable,
-	.free	= v1_free_pgtable,
-};
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
deleted file mode 100644
index b47941353ccbb8..00000000000000
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ /dev/null
@@ -1,370 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table v2 allocator.
- *
- * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- * Author: Vasant Hegde <vasant.hegde@amd.com>
- */
-
-#define pr_fmt(fmt)	"AMD-Vi: " fmt
-#define dev_fmt(fmt)	pr_fmt(fmt)
-
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-#define IOMMU_PAGE_PRESENT	BIT_ULL(0)	/* Is present */
-#define IOMMU_PAGE_RW		BIT_ULL(1)	/* Writeable */
-#define IOMMU_PAGE_USER		BIT_ULL(2)	/* Userspace addressable */
-#define IOMMU_PAGE_PWT		BIT_ULL(3)	/* Page write through */
-#define IOMMU_PAGE_PCD		BIT_ULL(4)	/* Page cache disabled */
-#define IOMMU_PAGE_ACCESS	BIT_ULL(5)	/* Was accessed (updated by IOMMU) */
-#define IOMMU_PAGE_DIRTY	BIT_ULL(6)	/* Was written to (updated by IOMMU) */
-#define IOMMU_PAGE_PSE		BIT_ULL(7)	/* Page Size Extensions */
-#define IOMMU_PAGE_NX		BIT_ULL(63)	/* No execute */
-
-#define MAX_PTRS_PER_PAGE	512
-
-#define IOMMU_PAGE_SIZE_2M	BIT_ULL(21)
-#define IOMMU_PAGE_SIZE_1G	BIT_ULL(30)
-
-
-static inline int get_pgtable_level(void)
-{
-	return amd_iommu_gpt_level;
-}
-
-static inline bool is_large_pte(u64 pte)
-{
-	return (pte & IOMMU_PAGE_PSE);
-}
-
-static inline u64 set_pgtable_attr(u64 *page)
-{
-	u64 prot;
-
-	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
-	prot |= IOMMU_PAGE_ACCESS;
-
-	return (iommu_virt_to_phys(page) | prot);
-}
-
-static inline void *get_pgtable_pte(u64 pte)
-{
-	return iommu_phys_to_virt(pte & PM_ADDR_MASK);
-}
-
-static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
-{
-	u64 pte;
-
-	pte = __sme_set(paddr & PM_ADDR_MASK);
-	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
-	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
-
-	if (prot & IOMMU_PROT_IW)
-		pte |= IOMMU_PAGE_RW;
-
-	/* Large page */
-	if (pg_size == IOMMU_PAGE_SIZE_1G || pg_size == IOMMU_PAGE_SIZE_2M)
-		pte |= IOMMU_PAGE_PSE;
-
-	return pte;
-}
-
-static inline u64 get_alloc_page_size(u64 size)
-{
-	if (size >= IOMMU_PAGE_SIZE_1G)
-		return IOMMU_PAGE_SIZE_1G;
-
-	if (size >= IOMMU_PAGE_SIZE_2M)
-		return IOMMU_PAGE_SIZE_2M;
-
-	return PAGE_SIZE;
-}
-
-static inline int page_size_to_level(u64 pg_size)
-{
-	if (pg_size == IOMMU_PAGE_SIZE_1G)
-		return PAGE_MODE_3_LEVEL;
-	if (pg_size == IOMMU_PAGE_SIZE_2M)
-		return PAGE_MODE_2_LEVEL;
-
-	return PAGE_MODE_1_LEVEL;
-}
-
-static void free_pgtable(u64 *pt, int level)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < MAX_PTRS_PER_PAGE; i++) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		if (is_large_pte(pt[i]))
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = get_pgtable_pte(pt[i]);
-		if (level > 2)
-			free_pgtable(p, level - 1);
-		else
-			iommu_free_pages(p);
-	}
-
-	iommu_free_pages(pt);
-}
-
-/* Allocate page table */
-static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
-			 unsigned long pg_size, gfp_t gfp, bool *updated)
-{
-	u64 *pte, *page;
-	int level, end_level;
-
-	level = get_pgtable_level() - 1;
-	end_level = page_size_to_level(pg_size);
-	pte = &pgd[PM_LEVEL_INDEX(level, iova)];
-	iova = PAGE_SIZE_ALIGN(iova, PAGE_SIZE);
-
-	while (level >= end_level) {
-		u64 __pte, __npte;
-
-		__pte = *pte;
-
-		if (IOMMU_PTE_PRESENT(__pte) && is_large_pte(__pte)) {
-			/* Unmap large pte */
-			cmpxchg64(pte, *pte, 0ULL);
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte)) {
-			page = iommu_alloc_pages_node_sz(nid, gfp, SZ_4K);
-			if (!page)
-				return NULL;
-
-			__npte = set_pgtable_attr(page);
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		level -= 1;
-		pte = get_pgtable_pte(__pte);
-		pte = &pte[PM_LEVEL_INDEX(level, iova)];
-	}
-
-	/* Tear down existing pte entries */
-	if (IOMMU_PTE_PRESENT(*pte)) {
-		u64 *__pte;
-
-		*updated = true;
-		__pte = get_pgtable_pte(*pte);
-		cmpxchg64(pte, *pte, 0ULL);
-		if (pg_size == IOMMU_PAGE_SIZE_1G)
-			free_pgtable(__pte, end_level - 1);
-		else if (pg_size == IOMMU_PAGE_SIZE_2M)
-			iommu_free_pages(__pte);
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address.
- * If there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long iova, unsigned long *page_size)
-{
-	u64 *pte;
-	int level;
-
-	level = get_pgtable_level() - 1;
-	pte = &pgtable->pgd[PM_LEVEL_INDEX(level, iova)];
-	/* Default page size is 4K */
-	*page_size = PAGE_SIZE;
-
-	while (level) {
-		/* Not present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Walk to the next level */
-		pte = get_pgtable_pte(*pte);
-		pte = &pte[PM_LEVEL_INDEX(level - 1, iova)];
-
-		/* Large page */
-		if (is_large_pte(*pte)) {
-			if (level == PAGE_MODE_3_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_1G;
-			else if (level == PAGE_MODE_2_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_2M;
-			else
-				return NULL;	/* Wrongly set PSE bit in PTE */
-
-			break;
-		}
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
-static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	u64 *pte;
-	unsigned long map_size;
-	unsigned long mapped_size = 0;
-	unsigned long o_iova = iova;
-	size_t size = pgcount << __ffs(pgsize);
-	int ret = 0;
-	bool updated = false;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize) || !pgcount)
-		return -EINVAL;
-
-	if (!(prot & IOMMU_PROT_MASK))
-		return -EINVAL;
-
-	while (mapped_size < size) {
-		map_size = get_alloc_page_size(pgsize);
-		pte = v2_alloc_pte(cfg->amd.nid, pgtable->pgd,
-				   iova, map_size, gfp, &updated);
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		*pte = set_pte_attr(paddr, map_size, prot);
-
-		iova += map_size;
-		paddr += map_size;
-		mapped_size += map_size;
-	}
-
-out:
-	if (updated) {
-		struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&pdom->lock, flags);
-		amd_iommu_domain_flush_pages(pdom, o_iova, size);
-		spin_unlock_irqrestore(&pdom->lock, flags);
-	}
-
-	if (mapped)
-		*mapped += mapped_size;
-
-	return ret;
-}
-
-static unsigned long iommu_v2_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	unsigned long unmap_size;
-	unsigned long unmapped = 0;
-	size_t size = pgcount << __ffs(pgsize);
-	u64 *pte;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
-		return 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (!pte)
-			return unmapped;
-
-		*pte = 0ULL;
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v2_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v2_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-
-	if (!pgtable || !pgtable->pgd)
-		return;
-
-	/* Free page table */
-	free_pgtable(pgtable->pgd, get_pgtable_level());
-	pgtable->pgd = NULL;
-}
-
-static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-	int ias = IOMMU_IN_ADDR_BIT_SIZE;
-
-	pgtable->pgd = iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->pgd)
-		return NULL;
-
-	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
-		ias = 57;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v2_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v2_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v2_iova_to_phys;
-
-	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-	cfg->ias           = ias;
-	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
-	.alloc	= v2_alloc_pgtable,
-	.free	= v2_free_pgtable,
-};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 8841c1487f0048..843fec8e8a511c 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -28,10 +28,6 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
 #endif
-#ifdef CONFIG_AMD_IOMMU
-	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
-	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
-#endif
 };
 
 static int check_custom_allocator(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 138fbd89b1e633..75fd67cc2b7a46 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -15,8 +15,6 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S2,
 	ARM_V7S,
 	ARM_MALI_LPAE,
-	AMD_IOMMU_V1,
-	AMD_IOMMU_V2,
 	APPLE_DART,
 	APPLE_DART2,
 	IO_PGTABLE_NUM_FMTS,
-- 
2.43.0


