Return-Path: <linux-kselftest+bounces-44744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F076CC32ADD
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A842533D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEC341648;
	Tue,  4 Nov 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RlClocdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC15340A73;
	Tue,  4 Nov 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281042; cv=fail; b=dpxockrjLtW2R52CV+K1K7q1Zi/C0ja+K29IX6u+J6K800emDMJrl+AGMh43fO4XXOc0Zv2rrg42RdyklKw1t5rgeEOFYFn2APLW3JKEkCUHxRLbi01Cf35/HME8ECyRnW5dikeeBB3iCbbx6Ib+G3AdnnZtmx5cLFDeQ31qCHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281042; c=relaxed/simple;
	bh=B6WCcC1uF+pW4gmUDFSzkuI+UA6DwcHIVxTpPUKdSN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnZ9DZt75CqmPnRA4TWy8xgxmSvdhEXUh+CWKZzULQPd6HBYvuAa2E5zd8eWpxmQrHGicGPrVypYnZ+FucxoI2537A8oup0OlQWJeQK3MpUs1P1eeGezedFV0t/qcBwVh+2BeBNfU6+nb8FcGcknPciHHs19mc1jEcjR8cuDGDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlClocdN; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5u9Ztlf8FBKIUp79GJF7FewCAIPWkxfKVAGl12QSo8xVQh9We1rVqWj6tegeU7bTIighXjKMQJ0tkHW5tN0NFwNyWe3qkKWfpE8OGGDbPxnsSzY/EG/+K1jMjBEFAoj7JCYbx+TZF9Ve4iQswEUxinylatYp7oUGGoJO+p6yBF0rspX3EyIWnsDtO2Ii8O53t4+rZjdH/ml+A88ILspC1Bqu7VSESd8c0XXm7KomH16Fc8Gc1RnnVw5f6XVGL/z3q2emxfLr4PJwuEAB90KEOGYxK6rl8PvAJI6QehDxcsAVPP8HOAwwloqW5BfcdbAJKlTVfeXHvaZLsVNOZLzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQjt73R8DxC9mdIn0GHxGQPlry5gNrATXpnWQ75ZOHI=;
 b=QjJc1NasUXDb6pUrlk8Xx1rnmFiiDKoojyrLIy+alRUFgJScNDYzMXPwEZe7pF0AyzgCDC+usFDYT2dSNXPUlWIyiSK54WXvFzd50htf1814ehnt3twV0Eqq+CFe5Z01+hRp7I+ho5jljnVVJ/k5YLSy9i0VWB22rIncuAwf3ZLMQS6QVniElHlK+9eBZcsMBGsP3Mp74bZ0sAiBT/Ba2Hb717cdAyijvKGEiwAZzfAWpTbLbjSjwyFgP/4SBcJ1icYxvh3Pde7+o3hlsMvYNWRNJQ0KICWImjN9RC6akWiLEkl68MCa8D3s658s0KXPtjJpBh001piBQMpX8bN+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQjt73R8DxC9mdIn0GHxGQPlry5gNrATXpnWQ75ZOHI=;
 b=RlClocdN6Tia0iq8hqXn3o0d1AafeLEi1CJ4ul0jD0l7RVyj9rqYlCWQH1uKaeTkFv9ssfoukNqeNsKPhSIj8B38HW5cZ4G799L4/N+n6C1RhIcX0cHR9uoOIO6Dcn5uquO1EyDbot2C+e1Liw7xDrBdWKIgG05dFmCMhJDO958Kwj3SQk/8RFnBxLZpnW34FQ8J8tB3aIGl7MmKi9XETnsmqwZNvj50rfw2OWZx+BrOECe3oY6l/ldOqlelDT4/yXxPFJPKh7us0HAih04TLqfHTleOF1Q2txlF4CFaZYqBohfsbppEjdKkZnMsECvJYyXzs7kNQeUwEnl1g1y7vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:20 +0000
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
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 14/15] iommu/amd: Remove AMD io_pgtable support
Date: Tue,  4 Nov 2025 14:30:12 -0400
Message-ID: <14-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa5684d-2b1b-479a-cd74-08de1bd03355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P7M37dai9xXM8nnSU/FoE+ZEudwFeuhg7axAMXcrG0GtHa+WZSCZJ/fifB/W?=
 =?us-ascii?Q?ZrlLPgLfQRpRG9Test7cbTsdJCS+ktAc1fVAviwABWl+tVR1k87kauNUgsuL?=
 =?us-ascii?Q?NS/g4n2t4lq2othb2hsqmqUCA2f4RfyeYDkOZTvJO7fLGJSzfWPsLlNQqTpV?=
 =?us-ascii?Q?6/CgJ477uNqMW7C++RBeSmvalz1lxNKnO2BpD2lRxRZu+Yj3YzGFaqrVUoyN?=
 =?us-ascii?Q?xJ/uBXqIyVK083wyoOQNft1HxKaMGXOaRZMy3IweSKjuTP/SQy8gMT0NEEBY?=
 =?us-ascii?Q?wV55fSVjwXhmxxbYW/1f7VnmL5iWQvAiV4ASTs9lUhIvnLnCk3Jm+/HaN9ed?=
 =?us-ascii?Q?x6jY5yQLzzWbyheIBPx+x6k/1zHp/7t83QA67xCfA/XDCjv+/jqhxbjaZzGm?=
 =?us-ascii?Q?RrLebGMERPzeLQuFcKq6aGu6e1jbnlAdSFioByeTBTANT/4JgaR3jwMI8czL?=
 =?us-ascii?Q?cJo5n+jQkX1ZI/glDRcLeL6u4NAQbP3dSk9o9ESwkgSO1V8ZWJcKoX13kbGa?=
 =?us-ascii?Q?+tUiAujG9P6kc7G7+nFoPt4AIHVaGQYzPc2t2H5FMKdPrNrUTrcO6Ydo4GcC?=
 =?us-ascii?Q?cAQLahn5jTUQgX+jXkDgylIFq0aG1m3vPKn90ZUahG0ozAn+NYRYoV/k9JdH?=
 =?us-ascii?Q?qHUJIMOOFtFyfeq+gRS96RXXm9oZzS3tX1+eYfPWmmXBd0ss7V2UmrK2LDas?=
 =?us-ascii?Q?Me73RdIqAsmXM3Wxg3Aj6SrwzB1F1xb+7IB8AAeEIbXLX/AXN64tqeUIvVAG?=
 =?us-ascii?Q?LPgmUi5VdOApuuDMGJIoEzxT8BD77mpZrPDCthv+TiwJrunplnZM3ohP+xju?=
 =?us-ascii?Q?m9UIkVTVdKOUlkXU+1FreGPFWs/QdobbU3wiKcglUow5asJPdZdlv5EOEJ7X?=
 =?us-ascii?Q?jy4UZB5l3i5xSnFN2yUB2piTUeTH70daGqLRB7r0/Zaang45omsMTxGpTnzm?=
 =?us-ascii?Q?5KsXU/+RvvauT0jwt3rvwwLe8vr8UfdHdar2najxOxOf509G4IBgROKT6dxa?=
 =?us-ascii?Q?sHulX8RynIIFpOm+WhDVQj9ZHpWaqNmnOJPsenNinB0VuMwIKPxT7xy2hwAU?=
 =?us-ascii?Q?yS8Bar4ZTyzalBHzrRUUKICmhw//PBS9ruQRSCwLowaNCq8LOl5xkJrJUoTu?=
 =?us-ascii?Q?VUaq+KUl9lHOZumFboWJZ9/wPMavBBQf48tYkhEnKu5Hi9zaRwgm57c/Gt03?=
 =?us-ascii?Q?miGDNc8bZjN3DMuIR2yWtqtSw39vM2UdvMZU4SLOLBr+tr66fvvJ+m7AqCu4?=
 =?us-ascii?Q?OXmvqZThW2VpShdIjMbp2aQA0lQ1In5V3O+YlprqMbBHv1wU3uCcLw6DXUQP?=
 =?us-ascii?Q?iWJy/8GVjZGrOnxUeybF79CxipzSTpIu9gzZ3EX7YHNR6nABY5r6hkLd07d1?=
 =?us-ascii?Q?iJnzEAdJBFwXnSK6+1RB5iMQxSWIVmfp9V7teoLmaxLDMccrhGZ6zHywXqYB?=
 =?us-ascii?Q?A2IqoQ1ug9Fe4ed1U53Grc5kYcAYfKRlkzCNXNmaitu9MXl42gO96GEhXCBv?=
 =?us-ascii?Q?wYdWRsgqGFZaxFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwxzxDN+ACKRsZ4+w+knt2/O6SGe4UlvW9NjX2a9EM+0rv2ibjuh4sw8NKHG?=
 =?us-ascii?Q?aBJIHWjCr41ADuSkyCgm8u1KrTZRBDTMvZ4a0Zx4Ajt2DYapCAz/4TByoAzf?=
 =?us-ascii?Q?q0jCp62wxTVfqVPi7SC02Hs0DljVYWzfyniFo5G1LxNIUhshd0OX71qb+FTh?=
 =?us-ascii?Q?WE8MRS9wdsxw27/r+X8zu7rvXyu2niXh7O3J5/tFYlBOGj0hB+BWje3xrx15?=
 =?us-ascii?Q?n3gNSieIUPWlIY+gfAfLa8VyY1TIGuY5JjfPU6QsYYs8ZlBmW2is6qmUHXM/?=
 =?us-ascii?Q?C/dXska2pZfPHuvyrmDqj5aFemFoyw7X3vWEBTWl/dM5QNj4zrNV9hzPe0JX?=
 =?us-ascii?Q?mlWhWIpZaPO5dROgdPZPb4l3Jw0fn9Xeu2IUxSXV2xCpRJ7/usJnFmcfseTR?=
 =?us-ascii?Q?SiBrV76txxMhXWDX4sL8wJ5/1fr9h3C0owQheGR0LynliVrppT75VxBZBgDL?=
 =?us-ascii?Q?rUzidSnObJTWwm3xF7ldleGxSZVRCFPIarC8z5RWteHZ0omoQHSghxoj5A9Q?=
 =?us-ascii?Q?SMWW5G+0hX43A9mHTtD7YZVXbnYKS7666Z9wgCMZ5duqJGPpiWDwFuBQOS5k?=
 =?us-ascii?Q?5C2wYshrd/p8m339URA+Yft+QBCwDV1NJOgk93FiRUl78F71jRHBn2I85tFA?=
 =?us-ascii?Q?hAMPJuNZz3Iz08/Ds9qIBuB+jCdR8wLG4N5v45nFiHwBTryiKmVrnk9s5MTR?=
 =?us-ascii?Q?+04jzIxFavHrxghe0lG4p8K1yFt+HOWvTG6R9uAtrwf2+R2HsqkO9A5Wsnbv?=
 =?us-ascii?Q?lUhmfeElgEBN8YYZEnR+jhRvzYLOdo/KTNeG6OhGJbMTCcva4jYhW0o40yv+?=
 =?us-ascii?Q?YBpq6kbdd73bME7xlG/1ATZjZGP7TzQB1W0wjukPGuMiLM5BGBqDnTSX8VSE?=
 =?us-ascii?Q?NSlI7ZXF8mQddseHoQ4W0CXIzAibSDKKEfsCdmQSKFER29Fx6jIK9dUFfiGx?=
 =?us-ascii?Q?KXZ5iDFbIRjtVx1TDGRuvVEoxELwwXWSXeVGsyhI6bP6lRa0UooL6BHPzrAZ?=
 =?us-ascii?Q?rPgvoQJRhXtdYIArQ4kS+Rg9VkDi5kIq9HZlvGjV/XnB/ZxfpPytYk0XURWV?=
 =?us-ascii?Q?kRt6n+sRY7qWUi2MKdvuMpn2se3aFhDbNB8lSC0bNjXqrbuNnn3RBM03uitp?=
 =?us-ascii?Q?G3ygjwJ9VLuwlhJpPha+Cl6kfEiCjzQHtgvMgXXuOsXSx59RKWRoAP69sYSb?=
 =?us-ascii?Q?sWJD4gXdMcLPu3amJcDtt1v5N/oCVqp+hfWRZFRMOcA9hdhypOS1C2BBTMGo?=
 =?us-ascii?Q?U3Kx6YbMIQRtsX/kZ3+Gb/GUSpm5bGctidV3KYvaTrkCCs+S+1Zu5B4PmLG3?=
 =?us-ascii?Q?jZc1qbTJLiNFNHFpvJgBfNCi7pzyXPUvxdcWadIvqMJzPT2V4xZBE9UPSiXj?=
 =?us-ascii?Q?HueZZBZNI0HZNrVXmYIeJKAzR7tZXudYszrrM227lsAK2WZmyCAwNwn9RTuq?=
 =?us-ascii?Q?KznyNDUekyWDh8T60PCnF5eKpmaS8GyX79KoNrEx+0p+rlIsrhQacHYCCXAx?=
 =?us-ascii?Q?G+rYmxxF0z2JYcVYfTJ2WhXW0PWf4dwDWNNICTZVOy/VgP2INcGMW0i6lV+K?=
 =?us-ascii?Q?yEgelk1PtwWVFmeU5QU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa5684d-2b1b-479a-cd74-08de1bd03355
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:16.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5WKGnrbFA/sPqL2DGXa1U/yNZFQlG8wZ9cQKyWEnQ2lEs+xkiHR1GC1h6e6ik7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

None of this is used anymore, delete it.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
index d90a285b44eb3a..4b4a37fad70ef2 100644
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
index 8a823c6f2b4a88..7a1516011ccf72 100644
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


