Return-Path: <linux-kselftest+bounces-32355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E314AA956D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD983B8BA8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F225CC5E;
	Mon,  5 May 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f5oTYH77"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7425C831;
	Mon,  5 May 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454744; cv=fail; b=c6+Ku8jS5ljZIB79iUZ/C+bVsItMBhX2OWbmQmf+V7jRTUOBz9xjqBYG/kgGZyJziG8IO1vR+7A4k6oneh8Y7wPXJZgB0DvkV1Mqhkau9vJKbq1sUHWDXFeGGaubvANOCSriRPth0ZxuVWczVBy7YUMOkQ27WZr0Bzq+1XJNUXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454744; c=relaxed/simple;
	bh=XrP36S3VYax3r0y4KUf9tXAtXGtBKu6UsVN9qBmMEiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MC2zlMc9sSP1gj4PbHpODbgbW9S/zCVdLlRVvqfBiMx5FWgDIk4sO12gNxoSn4SlBOkx+sMJc1P60J7lCjDfkxQ/qfzLeZRaStaebChicTxbtt2rmZgGSBX9y86bJ/HSAUZN0qS8G9aebLLoy0XySZRLe3O5xvbMU4BBiY6Fs+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f5oTYH77; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Snw6TQ7E1oZZo7LWKpHqMJ0wCoB+/Unds49BfhUnJnMyykVh9vAnBPI/Cy/2MYeRyizNx1VdVxWVfS++7SG91lruOe9jAhxqTW6w37Wj3vejaFrt2Etf5Qjr4GFcGc+V/yCGDSjlXe7hLiBMJBfZJbke9ZRNvRYrdGoDG+pt7WmGAjRvrU8MHu9qXnmSLmQtKrEGTQqfEnNmS42PyLUVv0ZGOrzUgtoBqabW2xJ16pK/bZfIAX6ahEwDZsS+XGPRsKjtSENLzsJapUnfnmxBK+be0KU0i0Qu2nVmciW9UWgik6Lx685/mFHEOu6IQno38ffkRpYSgGMDzFWSstcxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeYa4sywaZMsPG3Gn0rvd9b7M9h5IRLCUNyf10zKl7Y=;
 b=g1nAbhCU2oyxF1Wx/1cp3QKGQYgMATBygcqrgnSs3xxIsNwK2dCYSHNlQ7NArkzLippdFWG0sJzVODl+R2nBeMr42BotWYg1cP9WO9JlpUopMbIEQPiEHTFWjgsM10KfRbX1bc13LCyLIX9kgRnnzVAPdNuUWNoUeiz7I4o8TSn8x9y13cxCd5uwzmMKe+vbhAkm2LQei99pfh0+Oc+HKMbHFPnJ+CVXEEJa1K6eTgxAphJoaRKIVK686yBcVYrWXlirxyK3NbL3wUiOL6VeqnjJsqkJMj5MqChOnpMgzPvNRrMOC/tomQeyqz0JnXU2uedsLmVpztYJEK3z1ZTAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeYa4sywaZMsPG3Gn0rvd9b7M9h5IRLCUNyf10zKl7Y=;
 b=f5oTYH77STGDiQpWYbwC1OxAuFGEazOiuJDRC4V9tqzaaMt1mt2HB8DSk3X2Al0JXR1hNmWdi7Zq8gVDRk6+35hIMuaBHiGiDK0z2cSmnTFvhcA9g0k7+0/7RCReuCQ5sfEl++z7QePfwQS2bdtibVdekaOarEK+BEmsD097i+qcSZ77X2ixSxkMJrctEWYaLhGz9iSqYiB8e8TZSRtqwSNZ2nqBcPv/LjWaSDFsLA0RNCJ1Nrntm2yXCpgn7LEluPfZRsmWexeWpI12jmBt08ns72ALXHRMkz556cQBzylvug7jiUPmnVCzDd1Jsaqf/96hKapMxzUyELlT8jI07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:18:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:51 +0000
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
Subject: [PATCH v2 11/15] iommufd: Change the selftest to use iommupt instead of xarray
Date: Mon,  5 May 2025 11:18:41 -0300
Message-ID: <11-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 940b005b-f99c-400e-1377-08dd8bdfc08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jY06K9Vfed0WXE7kx0DXAy33MU1pu/o6UMCaZzlf8eOMgQEfLGPHzg83mGz7?=
 =?us-ascii?Q?tgeLyaOc/yvyCjiUvwYBG7+W86+6+o1+4JPm1Y4kVs2OP9K+O8bUJO5mKTeQ?=
 =?us-ascii?Q?2eUY/7U6+0jM+DnLm3wnFH5AfRUHh3bTna7Xeg/BIppk+J2N2x7/ROa6DpwF?=
 =?us-ascii?Q?wee9gaL9Ulke5Nhn0uID/kn52Cohnp7CTWPTlAZD2FTlPdX4ZY5QzaGtn3Lx?=
 =?us-ascii?Q?XmiIVdOiRx9JTtAWYF4bJBh8ibL0Do8AuTYvyGklcchbYDTQ5I4Vgcnyp/kl?=
 =?us-ascii?Q?cpPf4FmFtpXaoJH/8pGGkd7kLvCVLEKXwgbZYBoXQlInZAlOAkd+ug1A5YK8?=
 =?us-ascii?Q?8j9Akd7rX+LnXvJqOJ428qmiheYiIuknNJUYhfqbnXaFcyeWglEnT2vceMcP?=
 =?us-ascii?Q?phroMakXqQ+vfiaZz8wNPjwqLkdNx2oGbqW238g/jpBt3UlJopCB+hZGI8gE?=
 =?us-ascii?Q?VjU3Qvja0ZJYnYkLbi6cyBwNFiQckXzJh0Wcw8SaOlg2OgOJhVoI1j/YdkMU?=
 =?us-ascii?Q?7zElNVem6AXejoy9JjoKHqXJU/HtK7Pk7CHfHQgbVNXK7A20LOZbOjibgurD?=
 =?us-ascii?Q?XBBFHuqhwSJDLuke0CJXCpFT2wk0hKslBNu7TgRkJfA9Pw9I+EfrVTsTNEYW?=
 =?us-ascii?Q?/xV3zy7og8+/FdugzxfYRtOdpn10qSAP2/J0awU64fzrg3gussgAGbcLq5uv?=
 =?us-ascii?Q?O1ZFXZ/xOSHYfdqPb07iAdCO+DjTgPVwGDxbyS1OQ5h22Lda+YmqL3SrDKI0?=
 =?us-ascii?Q?CTzkOtENXP0XFXOl3e8PRND96cqX+66Tt6ZxwHvEU9lHyW9SWDeeYDVkPDwf?=
 =?us-ascii?Q?G/amOFSQv2wl0RCbdeXmCGofJoFpYYbvG0Dwlp0rWHsFjEdcfKWh4yO3DDS2?=
 =?us-ascii?Q?x8VOEyhC0fFHl41wBwy5hfN5+YxTmCVwqWgJV6ntOrwF8mAGrrGeS5NEhn0v?=
 =?us-ascii?Q?8QOGLFR9pYsO9M9UU66CDTPbsuoHbq//KGgMAsbwVs/VPv0lLIJVaDcECigr?=
 =?us-ascii?Q?0paRrKW+FkC9Y7rs1KSdlAeECWtuZBFTRLNYXsmNUcHTIbU3BwHrLLLorSVk?=
 =?us-ascii?Q?Fwe3prOFMZgKwtwGvlXwAow2WAQ/EDnnCy06QgXcXaA3FLL5LmkfaUPB3elt?=
 =?us-ascii?Q?AuvCyyyzpCAcO+UHXleSDbUXMHMkA5rdO6YkITZ5rVaZYbBJ941MKb2wYAVK?=
 =?us-ascii?Q?Jp6/MNryWLz53PA87pUaU9nmcSrPyyP72YIe2/n0J9ToWPiUx5VECWVdj/rX?=
 =?us-ascii?Q?EYQVueZJaiPX88k4RwcQKfH6a5obT7hQz165wgK9aghmAnA7hGVMNxdAQS0f?=
 =?us-ascii?Q?tNqeMHeapP1v1ycZt34eQ4L9MwJbioU7fX/zVEoVLF/41tDfdJC0xOrJW+vR?=
 =?us-ascii?Q?5PPXafpWOoAb/CCsxsWEM7YCUas4x+LP+zPrBljSa8vV9Z10A72IrAuqyY7X?=
 =?us-ascii?Q?WpsvWUr9BZYxc5HPUZK9TwATIt603cqgDoeyvRNE8Wxmgdq5a7E+Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAiS8rmF0iF44UmZyHIyryMgeyGGOiTLdLoZE0Zv//+yue4ZPV2YV25doJX6?=
 =?us-ascii?Q?5mbcURfSEENdkDdRKD/NuSYHettKprnymL5uBfaYwtngZGTvbtImkLWYCRlV?=
 =?us-ascii?Q?fq9Um4J2aGBhor1ZizaFFtDnu4f5fK6daFcJILOXheGsgfeWEc9SLFbgk15g?=
 =?us-ascii?Q?4sA+2QQgNyarmEgQbcmB7DQdL/22CUAAKR/i7wwHFa5KrA3C3z6MbxxcZI0+?=
 =?us-ascii?Q?dk4bijsjWhLNQf8J703IQfU4WhUfAEfn9Dv17k1XDTthQ3Z9en6tbmOh9AbT?=
 =?us-ascii?Q?wz19BSSKdycFYhwUTk4RYOA7E4aYipDTGe++cvZfYCaCDKjmESVnm7vQEtGy?=
 =?us-ascii?Q?qrYhnZjQdSQX1pHPc4wdF2axLpRYrmJ+W2mAc1VY+QxRdils8ylNjFX2Z1zB?=
 =?us-ascii?Q?fp72wZ4J6uB91GZSrb8J7Tb0gCPCQI+FE93RxfLCyqgo9/fWess4at0dHx56?=
 =?us-ascii?Q?F+djgDadFLUd+O6IKTl0mogTD26h/cPKZVE3vKmddneoQjgZBQIFfkW6wDeL?=
 =?us-ascii?Q?Vdh16BYUNFYoPRSxDpvRj8JVtFbZQFHv4lRI70A+qQAGmwU4u2TfPQ/HtJRs?=
 =?us-ascii?Q?KHebxAyGwHGkj3cGTdHe83H4CEsJDS8mRy0g6L/UnAtCCMDzRoX0WJZEJFvW?=
 =?us-ascii?Q?T86PhsBEhLnY68YSsi2AZR+uLSbD26krmD+T1vYXptnYuby3VRH+KpoE97jB?=
 =?us-ascii?Q?wDu7zVY7nGccc5PgyyK0sgcsURbubthzDsxgEEqjqFMJLiviBHlxIOa4e04F?=
 =?us-ascii?Q?dJhIMbJTK+rV8zjolQCwlzU3fxh8MSnrz7rms07H0mtAjsVwH8CUoX1B9Fvx?=
 =?us-ascii?Q?iuOVE2tdv5GwY8ks999QJxL3JzPpwWGGOL7kt0jrKZCo08vRbo+LKapcgyUO?=
 =?us-ascii?Q?J0G/Gy539JKka/21H62Iyj3ihVSDXmztYcTHuIwh8wvVTiyVPVbEu40V3g9m?=
 =?us-ascii?Q?bxTGR/AvMBLHNJSGMU+0oSszeT8vInELpPXkQAe5f+Ka8WwIAL32FsRd5aB2?=
 =?us-ascii?Q?cRwx15GeGXKpzQCTEj1R+DtkeRDw/GcVyS1hlR4RK6WqjiuDhzDnw5FhP3zr?=
 =?us-ascii?Q?ErkOlkGqH+qeKuTPYpb5hngP0ZsigHXXobZg6Ori6N0P51usu1adVVVhsPib?=
 =?us-ascii?Q?80ppP1NZdUrOKl7sMv/VyP8y1LUWhLYI5nB3MP+EQex3glb9LnYlTt0+OdyI?=
 =?us-ascii?Q?vpUnSo3y0wcfVUsn4cYrJxaK6FMlZu+y6adXVFq/qTK8ztpVs6Uoxituznub?=
 =?us-ascii?Q?OQ+Fj/e7zsS7StGWO8vKk2bI9rqnwe9FOFODVXasbY0KSW429oJ2WS2shJui?=
 =?us-ascii?Q?wli+q5EsmKaYqYWb9/APhIzy1Um0jZxv1TaCwjiWwjcDig3a5mbxQHc8enpL?=
 =?us-ascii?Q?x09JKQAh6pLzQgPT/zDTdImIe88qoQhiacd5IcYGYxtBcIKhNgNjArzWYMEb?=
 =?us-ascii?Q?DaaN/53K9kSM2vXoYR2sQZngPT8HsEHLHe2TxXN1CNasshjVXkozWGzAedls?=
 =?us-ascii?Q?yqcFIf1lSmY97KjitM3xFoGYg327Z7pFpU8lbEZBJmQGJorbhWRfYW5fuLwM?=
 =?us-ascii?Q?vMirzwBQxp1sZ9egjK7mr3l/waFRr7P9CQc0OJaf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940b005b-f99c-400e-1377-08dd8bdfc08d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:48.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlyyLgdKRk/7eenjBZpTysa48/rkPsXKyaTFbWD4cPPiKp3uJKx063Yug6hAqmri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Make it act more like a real iommu driver by
replacing the xarray with an iommupt based page table. The new AMDv1 mock
format behaves similarly to the xarray.

Add set_dirty() as a iommu_pt operation to allow the test suite to
simulate HW dirty.

Userspace can select between several formats including the normal AMDv1
format and a special MOCK_IOMMUPT_HUGE variation for testing huge page
dirty tracking. To make the dirty tracking test work the page table must
only store exactly 2M huge pages otherwise the logic the test uses
fails. They cannot be broken up or combined.

Aside from aligning the selftest with a real page table implementation,
this helps test the iommupt code itself.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h           |  39 ++
 drivers/iommu/iommufd/Kconfig                 |   1 +
 drivers/iommu/iommufd/iommufd_test.h          |  11 +-
 drivers/iommu/iommufd/selftest.c              | 439 +++++++-----------
 include/linux/generic_pt/iommu.h              |  12 +
 tools/testing/selftests/iommu/iommufd.c       |  60 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  12 +
 7 files changed, 289 insertions(+), 285 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index c3ea0f7de0d190..f6ac6eaa0d341e 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -262,6 +262,41 @@ int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU");
 
+static inline int __set_dirty(struct pt_range *range, void *arg,
+			      unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, __set_dirty);
+	case PT_ENTRY_OA:
+		if (!pt_entry_make_write_dirty(&pts))
+			return -EAGAIN;
+		return 0;
+	}
+	return -ENOENT;
+}
+
+static int __maybe_unused NS(set_dirty)(struct pt_iommu *iommu_table,
+					dma_addr_t iova)
+{
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note: There is no locking here yet, if the test suite races this it
+	 * can crash. It should use RCU locking eventually.
+	 */
+	return pt_walk_range(&range, __set_dirty, NULL);
+}
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
@@ -939,6 +974,10 @@ static void NS(deinit)(struct pt_iommu *iommu_table)
 }
 
 static const struct pt_iommu_ops NS(ops) = {
+#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER) && defined(pt_entry_write_is_dirty) && \
+	IS_ENABLED(CONFIG_IOMMUFD_TEST) && defined(pt_entry_make_write_dirty)
+	.set_dirty = NS(set_dirty),
+#endif
 	.get_info = NS(get_info),
 	.deinit = NS(deinit),
 };
diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 2beeb4f60ee538..eae3f03629b0c1 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -41,6 +41,7 @@ config IOMMUFD_TEST
 	depends on DEBUG_KERNEL
 	depends on FAULT_INJECTION
 	depends on RUNTIME_TESTING_MENU
+	depends on IOMMU_PT_AMDV1
 	select IOMMUFD_DRIVER
 	default n
 	help
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1cd7e839412980..36d898498fcc99 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -31,9 +31,18 @@ enum {
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 };
 
+enum {
+	MOCK_IOMMUPT_DEFAULT = 0,
+	MOCK_IOMMUPT_HUGE,
+	MOCK_IOMMUPT_AMDV1,
+};
+
+/* These values are true for MOCK_IOMMUPT_DEFAULT */
 enum {
 	MOCK_APERTURE_START = 1UL << 24,
 	MOCK_APERTURE_LAST = (1UL << 31) - 1,
+	MOCK_PAGE_SIZE = 2048,
+	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_PAGE_SIZE,
 };
 
 enum {
@@ -52,7 +61,6 @@ enum {
 
 enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
-	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
 	MOCK_FLAGS_DEVICE_PASID = 1 << 2,
 };
 
@@ -205,6 +213,7 @@ struct iommu_test_hw_info {
  */
 struct iommu_hwpt_selftest {
 	__u32 iotlb;
+	__u32 pagetable_type;
 };
 
 /* Should not be equal to any defined value in enum iommu_hwpt_invalidate_data_type */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 18d9a216eb30d4..7b0ccce1df0415 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
+#include "../iommu-pages.h"
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -41,21 +43,6 @@ static DEFINE_IDA(mock_dev_ida);
 
 enum {
 	MOCK_DIRTY_TRACK = 1,
-	MOCK_IO_PAGE_SIZE = PAGE_SIZE / 2,
-	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_IO_PAGE_SIZE,
-
-	/*
-	 * Like a real page table alignment requires the low bits of the address
-	 * to be zero. xarray also requires the high bit to be zero, so we store
-	 * the pfns shifted. The upper bits are used for metadata.
-	 */
-	MOCK_PFN_MASK = ULONG_MAX / MOCK_IO_PAGE_SIZE,
-
-	_MOCK_PFN_START = MOCK_PFN_MASK + 1,
-	MOCK_PFN_START_IOVA = _MOCK_PFN_START,
-	MOCK_PFN_LAST_IOVA = _MOCK_PFN_START,
-	MOCK_PFN_DIRTY_IOVA = _MOCK_PFN_START << 1,
-	MOCK_PFN_HUGE_IOVA = _MOCK_PFN_START << 2,
 };
 
 /*
@@ -121,10 +108,15 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 }
 
 struct mock_iommu_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+	};
 	unsigned long flags;
-	struct iommu_domain domain;
-	struct xarray pfns;
 };
+PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
 
 static inline struct mock_iommu_domain *
 to_mock_domain(struct iommu_domain *domain)
@@ -303,74 +295,6 @@ static int mock_domain_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static bool mock_test_and_clear_dirty(struct mock_iommu_domain *mock,
-				      unsigned long iova, size_t page_size,
-				      unsigned long flags)
-{
-	unsigned long cur, end = iova + page_size - 1;
-	bool dirty = false;
-	void *ent, *old;
-
-	for (cur = iova; cur < end; cur += MOCK_IO_PAGE_SIZE) {
-		ent = xa_load(&mock->pfns, cur / MOCK_IO_PAGE_SIZE);
-		if (!ent || !(xa_to_value(ent) & MOCK_PFN_DIRTY_IOVA))
-			continue;
-
-		dirty = true;
-		/* Clear dirty */
-		if (!(flags & IOMMU_DIRTY_NO_CLEAR)) {
-			unsigned long val;
-
-			val = xa_to_value(ent) & ~MOCK_PFN_DIRTY_IOVA;
-			old = xa_store(&mock->pfns, cur / MOCK_IO_PAGE_SIZE,
-				       xa_mk_value(val), GFP_KERNEL);
-			WARN_ON_ONCE(ent != old);
-		}
-	}
-
-	return dirty;
-}
-
-static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
-					    unsigned long iova, size_t size,
-					    unsigned long flags,
-					    struct iommu_dirty_bitmap *dirty)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	unsigned long end = iova + size;
-	void *ent;
-
-	if (!(mock->flags & MOCK_DIRTY_TRACK) && dirty->bitmap)
-		return -EINVAL;
-
-	do {
-		unsigned long pgsize = MOCK_IO_PAGE_SIZE;
-		unsigned long head;
-
-		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-		if (!ent) {
-			iova += pgsize;
-			continue;
-		}
-
-		if (xa_to_value(ent) & MOCK_PFN_HUGE_IOVA)
-			pgsize = MOCK_HUGE_PAGE_SIZE;
-		head = iova & ~(pgsize - 1);
-
-		/* Clear dirty */
-		if (mock_test_and_clear_dirty(mock, head, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, iova, pgsize);
-		iova += pgsize;
-	} while (iova < end);
-
-	return 0;
-}
-
-static const struct iommu_dirty_ops dirty_ops = {
-	.set_dirty_tracking = mock_domain_set_dirty_tracking,
-	.read_and_clear_dirty = mock_domain_read_and_clear_dirty,
-};
-
 static struct mock_iommu_domain_nested *
 __mock_domain_alloc_nested(const struct iommu_user_data *user_data)
 {
@@ -405,7 +329,7 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 
 	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (!parent || parent->ops != mock_ops.default_domain_ops)
+	if (!parent || !(parent->type & __IOMMU_DOMAIN_PAGING))
 		return ERR_PTR(-EINVAL);
 
 	mock_parent = to_mock_domain(parent);
@@ -419,6 +343,138 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	return &mock_nested->domain;
 }
 
+static void mock_domain_free(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
+
+	pt_iommu_deinit(&mock->iommu);
+	kfree(mock);
+}
+
+static void mock_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *gather)
+{
+	iommu_put_pages_list(&gather->freelist);
+}
+
+static const struct iommu_domain_ops amdv1_mock_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1_mock),
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
+	.iotlb_sync = &mock_iotlb_sync,
+};
+
+static const struct iommu_domain_ops amdv1_mock_huge_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1_mock),
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
+	.iotlb_sync = &mock_iotlb_sync,
+};
+#undef pt_iommu_amdv1_mock_map_pages
+
+static const struct iommu_dirty_ops amdv1_mock_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1_mock),
+	.set_dirty_tracking = mock_domain_set_dirty_tracking,
+};
+
+static const struct iommu_domain_ops amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
+	.iotlb_sync = &mock_iotlb_sync,
+};
+
+static const struct iommu_dirty_ops amdv1_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1),
+	.set_dirty_tracking = mock_domain_set_dirty_tracking,
+};
+
+static struct mock_iommu_domain *
+mock_domain_alloc_pgtable(struct device *dev,
+			  const struct iommu_hwpt_selftest *user_cfg, u32 flags)
+{
+	struct mock_iommu_domain *mock;
+	int rc;
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return ERR_PTR(-ENOMEM);
+	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
+
+	mock->amdv1.iommu.nid = NUMA_NO_NODE;
+
+	switch (user_cfg->pagetable_type) {
+	case MOCK_IOMMUPT_DEFAULT:
+	case MOCK_IOMMUPT_HUGE: {
+		struct pt_iommu_amdv1_cfg cfg = {};
+
+		/* The mock version has a 2k page size */
+		cfg.common.hw_max_vasz_lg2 = 56;
+		cfg.common.hw_max_oasz_lg2 = 51;
+		cfg.starting_level = 2;
+		if (user_cfg->pagetable_type == MOCK_IOMMUPT_HUGE)
+			mock->domain.ops = &amdv1_mock_huge_ops;
+		else
+			mock->domain.ops = &amdv1_mock_ops;
+		rc = pt_iommu_amdv1_mock_init(&mock->amdv1, &cfg, GFP_KERNEL);
+		if (rc)
+			goto err_free;
+
+		/*
+		 * In huge mode userspace should only provide huge pages, we
+		 * have to include PAGE_SIZE for the domain to be accepted by
+		 * iommufd.
+		 */
+		if (user_cfg->pagetable_type == MOCK_IOMMUPT_HUGE)
+			mock->domain.pgsize_bitmap = MOCK_HUGE_PAGE_SIZE |
+						     PAGE_SIZE;
+		if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+			mock->domain.dirty_ops = &amdv1_mock_dirty_ops;
+		break;
+	}
+
+	case MOCK_IOMMUPT_AMDV1: {
+		struct pt_iommu_amdv1_cfg cfg = {};
+
+		cfg.common.hw_max_vasz_lg2 = 64;
+		cfg.common.hw_max_oasz_lg2 = 52;
+		cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+				      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+				      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+		cfg.starting_level = 2;
+		mock->domain.ops = &amdv1_ops;
+		rc = pt_iommu_amdv1_init(&mock->amdv1, &cfg, GFP_KERNEL);
+		if (rc)
+			goto err_free;
+		if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+			mock->domain.dirty_ops = &amdv1_dirty_ops;
+		break;
+	}
+	default:
+		rc = -EOPNOTSUPP;
+		goto err_free;
+	}
+
+	/*
+	 * Override the real aperture to the MOCK aperture for test purposes.
+	 */
+	if (user_cfg->pagetable_type == MOCK_IOMMUPT_DEFAULT) {
+		WARN_ON(mock->domain.geometry.aperture_start != 0);
+		WARN_ON(mock->domain.geometry.aperture_end < MOCK_APERTURE_LAST);
+
+		mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
+		mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	}
+
+	return mock;
+err_free:
+	kfree(mock);
+	return ERR_PTR(rc);
+}
+
 static struct iommu_domain *
 mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			       const struct iommu_user_data *user_data)
@@ -429,151 +485,30 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				 IOMMU_HWPT_ALLOC_PASID;
 	struct mock_dev *mdev = to_mock_dev(dev);
 	bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
+	struct iommu_hwpt_selftest user_cfg = {};
 	struct mock_iommu_domain *mock;
+	int rc;
 
-	if (user_data)
-		return ERR_PTR(-EOPNOTSUPP);
 	if ((flags & ~PAGING_FLAGS) || (has_dirty_flag && no_dirty_ops))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
-	if (!mock)
-		return ERR_PTR(-ENOMEM);
-	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
-	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
-	if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
-		mock->domain.pgsize_bitmap |= MOCK_HUGE_PAGE_SIZE;
-	mock->domain.ops = mock_ops.default_domain_ops;
-	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	xa_init(&mock->pfns);
+	if (user_data && (user_data->type != IOMMU_HWPT_DATA_SELFTEST &&
+			  user_data->type != IOMMU_HWPT_DATA_NONE))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	if (has_dirty_flag)
-		mock->domain.dirty_ops = &dirty_ops;
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&user_cfg, user_data, IOMMU_HWPT_DATA_SELFTEST, iotlb);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	mock = mock_domain_alloc_pgtable(dev, &user_cfg, flags);
+	if (IS_ERR(mock))
+		return ERR_CAST(mock);
 	return &mock->domain;
 }
 
-static void mock_domain_free(struct iommu_domain *domain)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-
-	WARN_ON(!xa_empty(&mock->pfns));
-	kfree(mock);
-}
-
-static int mock_domain_map_pages(struct iommu_domain *domain,
-				 unsigned long iova, phys_addr_t paddr,
-				 size_t pgsize, size_t pgcount, int prot,
-				 gfp_t gfp, size_t *mapped)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	unsigned long flags = MOCK_PFN_START_IOVA;
-	unsigned long start_iova = iova;
-
-	/*
-	 * xarray does not reliably work with fault injection because it does a
-	 * retry allocation, so put our own failure point.
-	 */
-	if (iommufd_should_fail())
-		return -ENOENT;
-
-	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
-	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
-	for (; pgcount; pgcount--) {
-		size_t cur;
-
-		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
-			void *old;
-
-			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
-				flags = MOCK_PFN_LAST_IOVA;
-			if (pgsize != MOCK_IO_PAGE_SIZE) {
-				flags |= MOCK_PFN_HUGE_IOVA;
-			}
-			old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
-				       xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
-						   flags),
-				       gfp);
-			if (xa_is_err(old)) {
-				for (; start_iova != iova;
-				     start_iova += MOCK_IO_PAGE_SIZE)
-					xa_erase(&mock->pfns,
-						 start_iova /
-							 MOCK_IO_PAGE_SIZE);
-				return xa_err(old);
-			}
-			WARN_ON(old);
-			iova += MOCK_IO_PAGE_SIZE;
-			paddr += MOCK_IO_PAGE_SIZE;
-			*mapped += MOCK_IO_PAGE_SIZE;
-			flags = 0;
-		}
-	}
-	return 0;
-}
-
-static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
-				      unsigned long iova, size_t pgsize,
-				      size_t pgcount,
-				      struct iommu_iotlb_gather *iotlb_gather)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	bool first = true;
-	size_t ret = 0;
-	void *ent;
-
-	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
-	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
-
-	for (; pgcount; pgcount--) {
-		size_t cur;
-
-		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
-			ent = xa_erase(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-
-			/*
-			 * iommufd generates unmaps that must be a strict
-			 * superset of the map's performend So every
-			 * starting/ending IOVA should have been an iova passed
-			 * to map.
-			 *
-			 * This simple logic doesn't work when the HUGE_PAGE is
-			 * turned on since the core code will automatically
-			 * switch between the two page sizes creating a break in
-			 * the unmap calls. The break can land in the middle of
-			 * contiguous IOVA.
-			 */
-			if (!(domain->pgsize_bitmap & MOCK_HUGE_PAGE_SIZE)) {
-				if (first) {
-					WARN_ON(ent && !(xa_to_value(ent) &
-							 MOCK_PFN_START_IOVA));
-					first = false;
-				}
-				if (pgcount == 1 &&
-				    cur + MOCK_IO_PAGE_SIZE == pgsize)
-					WARN_ON(ent && !(xa_to_value(ent) &
-							 MOCK_PFN_LAST_IOVA));
-			}
-
-			iova += MOCK_IO_PAGE_SIZE;
-			ret += MOCK_IO_PAGE_SIZE;
-		}
-	}
-	return ret;
-}
-
-static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
-					    dma_addr_t iova)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	void *ent;
-
-	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
-	ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-	WARN_ON(!ent);
-	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
-}
-
 static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
@@ -762,7 +697,6 @@ static const struct iommu_ops mock_ops = {
 	.default_domain = &mock_blocking_domain,
 	.blocked_domain = &mock_blocking_domain,
 	.owner = THIS_MODULE,
-	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc_paging_flags = mock_domain_alloc_paging_flags,
 	.domain_alloc_nested = mock_domain_alloc_nested,
@@ -774,15 +708,6 @@ static const struct iommu_ops mock_ops = {
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
 	.viommu_alloc = mock_viommu_alloc,
-	.default_domain_ops =
-		&(struct iommu_domain_ops){
-			.free = mock_domain_free,
-			.attach_dev = mock_domain_nop_attach,
-			.map_pages = mock_domain_map_pages,
-			.unmap_pages = mock_domain_unmap_pages,
-			.iova_to_phys = mock_domain_iova_to_phys,
-			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
-		},
 };
 
 static void mock_domain_free_nested(struct iommu_domain *domain)
@@ -866,7 +791,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	if (IS_ERR(hwpt))
 		return hwpt;
 	if (hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED ||
-	    hwpt->domain->ops != mock_ops.default_domain_ops) {
+	    hwpt->domain->owner != &mock_ops) {
 		iommufd_put_object(ucmd->ictx, &hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
@@ -907,7 +832,6 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		{},
 	};
 	const u32 valid_flags = MOCK_FLAGS_DEVICE_NO_DIRTY |
-				MOCK_FLAGS_DEVICE_HUGE_IOVA |
 				MOCK_FLAGS_DEVICE_PASID;
 	struct mock_dev *mdev;
 	int rc, i;
@@ -1096,23 +1020,25 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 {
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
+	unsigned int page_size;
 	uintptr_t end;
 	int rc;
 
-	if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
-	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE ||
-	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
-		return -EINVAL;
-
 	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
 	if (IS_ERR(hwpt))
 		return PTR_ERR(hwpt);
 
-	for (; length; length -= MOCK_IO_PAGE_SIZE) {
+	page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
+	if (iova % page_size || length % page_size ||
+	    (uintptr_t)uptr % page_size ||
+	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
+		return -EINVAL;
+
+	for (; length; length -= page_size) {
 		struct page *pages[1];
+		phys_addr_t io_phys;
 		unsigned long pfn;
 		long npages;
-		void *ent;
 
 		npages = get_user_pages_fast((uintptr_t)uptr & PAGE_MASK, 1, 0,
 					     pages);
@@ -1127,15 +1053,14 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 		pfn = page_to_pfn(pages[0]);
 		put_page(pages[0]);
 
-		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-		if (!ent ||
-		    (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE !=
-			    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
+		io_phys = mock->domain.ops->iova_to_phys(&mock->domain, iova);
+		if (io_phys !=
+		    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
 			rc = -EINVAL;
 			goto out_put;
 		}
-		iova += MOCK_IO_PAGE_SIZE;
-		uptr += MOCK_IO_PAGE_SIZE;
+		iova += page_size;
+		uptr += page_size;
 	}
 	rc = 0;
 
@@ -1615,7 +1540,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	if (IS_ERR(hwpt))
 		return PTR_ERR(hwpt);
 
-	if (!(mock->flags & MOCK_DIRTY_TRACK)) {
+	if (!(mock->flags & MOCK_DIRTY_TRACK) || !mock->iommu.ops->set_dirty) {
 		rc = -EINVAL;
 		goto out_put;
 	}
@@ -1634,22 +1559,10 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	}
 
 	for (i = 0; i < max; i++) {
-		unsigned long cur = iova + i * page_size;
-		void *ent, *old;
-
 		if (!test_bit(i, (unsigned long *)tmp))
 			continue;
-
-		ent = xa_load(&mock->pfns, cur / page_size);
-		if (ent) {
-			unsigned long val;
-
-			val = xa_to_value(ent) | MOCK_PFN_DIRTY_IOVA;
-			old = xa_store(&mock->pfns, cur / page_size,
-				       xa_mk_value(val), GFP_KERNEL);
-			WARN_ON_ONCE(ent != old);
-			count++;
-		}
+		mock->iommu.ops->set_dirty(&mock->iommu, iova + i * page_size);
+		count++;
 	}
 
 	cmd->dirty.out_nr_dirty = count;
@@ -2023,3 +1936,5 @@ void iommufd_test_exit(void)
 	platform_device_unregister(selftest_iommu_dev);
 	debugfs_remove_recursive(dbgfs_root);
 }
+
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 38a19b19cdc3dc..03a9b692f82531 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -73,6 +73,18 @@ struct pt_iommu_info {
 };
 
 struct pt_iommu_ops {
+	/**
+	 * set_dirty() - Make the iova write dirty
+	 * @iommu_table: Table to manipulate
+	 * @iova: IO virtual address to start
+	 *
+	 * This is only used by iommufd testing. It makes the iova dirty so that
+	 * read_and_clear_dirty() will see it as dirty. Unlike all the other ops
+	 * this one is safe to call without holding any locking. It may return
+	 * -EAGAIN if there is a race.
+	 */
+	int (*set_dirty)(struct pt_iommu *iommu_table, dma_addr_t iova);
+
 	/**
 	 * get_info() - Return the pt_iommu_info structure
 	 * @iommu_table: Table to query
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa51..4f7c64c992a4bf 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -13,9 +13,6 @@
 
 static unsigned long HUGEPAGE_SIZE;
 
-#define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
-#define MOCK_HUGE_PAGE_SIZE (512 * MOCK_PAGE_SIZE)
-
 static unsigned long get_huge_page_size(void)
 {
 	char buf[80];
@@ -2008,6 +2005,12 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_SET,
+		.val64 = 0,
+	};
 	unsigned long size;
 	int mmap_flags;
 	void *vrc;
@@ -2015,7 +2018,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 	if (variant->buffer_size < MOCK_PAGE_SIZE) {
 		SKIP(return,
-		     "Skipping buffer_size=%lu, less than MOCK_PAGE_SIZE=%lu",
+		     "Skipping buffer_size=%lu, less than MOCK_PAGE_SIZE=%u",
 		     variant->buffer_size, MOCK_PAGE_SIZE);
 	}
 
@@ -2052,16 +2055,18 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	assert((uintptr_t)self->bitmap % PAGE_SIZE == 0);
 
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	/* Enable 1M mock IOMMU hugepages */
-	if (variant->hugepages) {
-		test_cmd_mock_domain_flags(self->ioas_id,
-					   MOCK_FLAGS_DEVICE_HUGE_IOVA,
-					   &self->stdev_id, &self->hwpt_id,
-					   &self->idev_id);
-	} else {
-		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id, &self->idev_id);
-	}
+
+	/*
+	 * For dirty testing it is important that the page size fed into
+	 * the iommu page tables matches the size the dirty logic
+	 * expects, or set_dirty can touch too much stuff.
+	 */
+	cmd.object_id = self->ioas_id;
+	if (!variant->hugepages)
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	test_cmd_mock_domain(self->ioas_id, &self->stdev_id, &self->hwpt_id,
+			     &self->idev_id);
 }
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
@@ -2187,18 +2192,23 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capability)
 TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 {
 	uint32_t page_size = MOCK_PAGE_SIZE;
+	uint32_t ioas_id = self->ioas_id;
 	uint32_t hwpt_id;
-	uint32_t ioas_id;
 
 	if (variant->hugepages)
 		page_size = MOCK_HUGE_PAGE_SIZE;
 
-	test_ioctl_ioas_alloc(&ioas_id);
 	test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
 				     variant->buffer_size, MOCK_APERTURE_START);
 
-	test_cmd_hwpt_alloc(self->idev_id, ioas_id,
-			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
+	if (variant->hugepages)
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_HUGE, &hwpt_id);
+	else
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_DEFAULT, &hwpt_id);
 
 	test_cmd_set_dirty_tracking(hwpt_id, true);
 
@@ -2224,18 +2234,24 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 {
 	uint32_t page_size = MOCK_PAGE_SIZE;
+	uint32_t ioas_id = self->ioas_id;
 	uint32_t hwpt_id;
-	uint32_t ioas_id;
 
 	if (variant->hugepages)
 		page_size = MOCK_HUGE_PAGE_SIZE;
 
-	test_ioctl_ioas_alloc(&ioas_id);
 	test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
 				     variant->buffer_size, MOCK_APERTURE_START);
 
-	test_cmd_hwpt_alloc(self->idev_id, ioas_id,
-			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
+
+	if (variant->hugepages)
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_HUGE, &hwpt_id);
+	else
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_DEFAULT, &hwpt_id);
 
 	test_cmd_set_dirty_tracking(hwpt_id, true);
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 72f6636e5d9099..d0d9d788f478c3 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -206,6 +206,18 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_i
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 0, flags,   \
 					  hwpt_id, IOMMU_HWPT_DATA_NONE, NULL, \
 					  0))
+#define test_cmd_hwpt_alloc_iommupt(device_id, pt_id, flags, iommupt_type, \
+				    hwpt_id)                               \
+	({                                                                 \
+		struct iommu_hwpt_selftest user_cfg = {                    \
+			.pagetable_type = iommupt_type                     \
+		};                                                         \
+                                                                           \
+		ASSERT_EQ(0, _test_cmd_hwpt_alloc(                         \
+				     self->fd, device_id, pt_id, 0, flags, \
+				     hwpt_id, IOMMU_HWPT_DATA_SELFTEST,    \
+				     &user_cfg, sizeof(user_cfg)));        \
+	})
 #define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)   \
 	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(                      \
 				     self->fd, device_id, pt_id, 0, flags, \
-- 
2.43.0


