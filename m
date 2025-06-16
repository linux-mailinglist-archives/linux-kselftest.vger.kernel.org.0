Return-Path: <linux-kselftest+bounces-35125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31141ADB85F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50497188CE82
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BA1925AF;
	Mon, 16 Jun 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DsxP3uVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC62BEFE1;
	Mon, 16 Jun 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097187; cv=fail; b=ducTMnHKkh2O/6OgOVAu5qIczNoleTa3MgyyV4ECxjMBELURtFZDTjceVDLHmsabpH5Kvhf1pztI6FvYynKEecDENhBK+vfyH/4tL8Rbf4yoN9RHNS54sVtG61PVI4jaiimWNsDOda6rtnzOg0krVUw984c2b5B2UiPMvoroZDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097187; c=relaxed/simple;
	bh=sEForbCvSbZYOLPNwrv+2ZT5pNFPWK/ArVdpr5CecUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJyGcBcCBXw56KcZ3mNSj/WzeNvZb8hiGuLRuSyERVJHw7KGDx0ToG1w9gd0p5shTjQ9hVQWFPuMvg0PFa6+/lrFn890XthSOJNvz78Q+fyygqQeZF9X9CYHZfPDUcdQaVTlh9J8ZueD5eEWgvu1NfZPEv9xWmPRXMoVNPuSiXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DsxP3uVK; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaQlRm4fTW2/knWGLkCXAu+LllbJGMFrqphJekyH683CtVveenzFMkojCiMXL5SZD7CmQcUsT7B6eYhC7XNM2k8O/xKO/COklqOMIrPa1rOo5NG4la9kbAED1KLfggC7dqejmoOcXlodN9cIqGyu/7jMbYfOeE2tx3IeWDAvoqXBI1xoDTE/NGUksi8UnPWOnc5W5kmvAWQ0iwsYDiUyx+QPRQq+QqXPKbvpf4q89SueLIYXeWR1UB9qsRhx9eIyALh9SotWURIGxJ02kxHHYd2oXtnRmnYVq9DdN34GbuEwTvd2+mSacJbxpZ7J+D5oj5uqQtr5IdrNEDqHULIujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33KU/0f6LM2cz1xGD8H6FQ53sI9qfHArmGVPbAK1GCY=;
 b=fXaNrcLzmxNSdeuqaG/pyLT6B4PU32r1+WdSOom+xBQYR39OXcmmCDVkNXu3wXlhSA7ysncad/Hr3f3vj2KhPKze4S4zQ4+JdeqE7nHhuq8zfT1k77Z53fELPu8NMfXoOCgiBSH/z0UR0qVTbJUmEdd0oj8dw4Xo6Vge+IYzSTeZn+s4am1CC7IO70Qh9lRgqDi1FvsOJvYDgEpc+odGHDXhiG/rRsl7vwBHT70hNNbaiE8rUjfyc/N7p8YL0PEoVb6BmBxyyXdSr2T+ycqS4XMPeULtpHQ7NNCoF5CCkSbjhvO4yjQWMYfZaHbC8wlJiFg4m1m8spnTFkNTDtY3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33KU/0f6LM2cz1xGD8H6FQ53sI9qfHArmGVPbAK1GCY=;
 b=DsxP3uVKKWWUFi9v+whgyUTGs8nj7t6cgAyhEytrgUwFKNMpcf7Gousnj1TWENVXG1lSKmfFZpDO+MWeehXlkyt9IZYJ9VGMNWo9zGx8ni9zGC0VmlW5CA6ycokQpIVa1LVQrEC21lwTORy0G/9YZj0foVJ/IqD1UCSgCYjTtPOnNoDmha/qzE+w01aQwi1/CPsJZv8BnYTvPlDYkNliRIJyQTFpqpoC2rVHrUER3cJw9HqmoMnD+5hsPPIu5+gNy7O43d/17yczGrZQkEABQce8BDF6HvKLNnbk0qsIwn4ZXqm8Egxd50cdjY9PznL9ngqnxbCC3txxhx9b8jW06g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:20 +0000
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
Subject: [PATCH v3 02/15] genpt: Add Documentation/ files
Date: Mon, 16 Jun 2025 15:06:05 -0300
Message-ID: <2-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0464e5ec-1c6f-4b32-f914-08ddad007ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5oAoA6ajomY7yBDvwnqQBmtf+X8cGXwYH3Cop1+1RiaktRJG1fPsUfXpMuKN?=
 =?us-ascii?Q?7gNFaAUS+gVAfC8ux84gAybAH20iXEAe7NlmydjnIpYyHSX7tmzcyflqwrCh?=
 =?us-ascii?Q?vkfPbFaZP7ZT1nnGjKwRf//blrtULEo+Rw2C0tw9DP7iJnb4m+bBjNLlLvF5?=
 =?us-ascii?Q?7MlbSapS4YVTVUkFkGepqKt5tEth+aBc7//veXHyCWUsVteAfEHTg245oPt9?=
 =?us-ascii?Q?S/HCfkDAPB02FLlI8yE1d7yzXca2AEn/5/KxJ5PrLbmS3KfzefIn6bK759gi?=
 =?us-ascii?Q?x7IhzggLRI0bvjv7lpiVx+iR80ArLzD1prHbi+8EV9kt5hTjeGEoa4nLsf20?=
 =?us-ascii?Q?DfliyUg0YZSLj4/eP+3pBLdWas9zmgzAg9c4Wf7Qatb1QjfxInhcs8G28sNB?=
 =?us-ascii?Q?R13i5fWxdrEsJVdzsQOZrPU4M0UgxLhyZaFvcK3IAFFpm24zsWfwJzPYlXcu?=
 =?us-ascii?Q?FY0ZuPNcVrZI0BxqfXtV/ZphNnmvut5Y1SH/VVZeI9BOPVbL7B14qq1TOCip?=
 =?us-ascii?Q?PPRPK8D25/xVyDpJUKQXXyJY72hlfeUwaWqcjzOGQfJfxNdfJd/NjpGfDXtI?=
 =?us-ascii?Q?ewNRgSwBlQG3sS3yaJzBB1N3ZiBwf5uUcrq8L363aBpKPsj4q7LGdcOLVTUg?=
 =?us-ascii?Q?e0abVIC0KXzIr/QD1mACIgNohKBDYMHg0DnmRMbBPpOPRsSco5QvvhudPWLK?=
 =?us-ascii?Q?BiPFPOhv0Q94t0A7mWuO2x7sFSwmDw3WTyS8JzuiFqWl5MJd4LPa8w+5Vpgs?=
 =?us-ascii?Q?I8YNEmwNjJiJXVp/JO9P5P6vkqitQ33jMgv0u5eb9gOSTFu12/H/whwn3OA8?=
 =?us-ascii?Q?YE0T/OZLGs3zna3c7dN+uM6AjFgDkP7sgqpAbbLCxoKJa8zn38MVUvUuEgnB?=
 =?us-ascii?Q?AfTIRENLyXyCGvwsx+KmK6fjPoJeAOJD/E3amczHSqX0SvBGGhHGfRnmZXHx?=
 =?us-ascii?Q?IuP5f6EUAjcA9aecuJDG6XoFuK4RA0oNP+9YDT+GkZfVG0/579dq3pnYGKMt?=
 =?us-ascii?Q?Air5Rx0Z5u2+dBbU2qzXf4LBpYe4VkWGNnpXJ86Ubwv8ZdVZNcgAcWGcq7Gn?=
 =?us-ascii?Q?HP+OJZ7N8vAmvCEJ01LPlEXaZ4Iou2P/qXne6WbXGXKncllbzfPKYH9NmsKd?=
 =?us-ascii?Q?euRaQBLSivl5as3n4E4wUn1AKtuk83s/dMAkkbKFlixPRyrRPr2EzLJXDe6Z?=
 =?us-ascii?Q?E0+ncbP18qaVfXXiptxl2ZLv/CdnQ+OK5tRNKJEwCVGXK26mwcT9k84wtdGY?=
 =?us-ascii?Q?Gv3PaecMDZGuDqj9n4g+IjI6mQiyNwrPIujpqy/DAGTCZ0pltwPh5on5P2L+?=
 =?us-ascii?Q?e03r4UxTo9QOdLBHGTarMgHlBWzTeeayvc3xuoGJhNdYzAy+djetmM4K2XAr?=
 =?us-ascii?Q?00mAegB3C+V7JIj/FjRSJ03G1ZaMxlbsYFBf+H1wdXogg1QYUnvPs2gu5XC8?=
 =?us-ascii?Q?ogOV3rNswgyF5PDU2Bn2mMguvVvBIBfzwK15pABC7iAVtOLPDjfYPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UvfZN5PT7OnwAB5+lFKzMaS5WmAL6jMGuBF28mEDlkryNClXG3epU9WWAzdF?=
 =?us-ascii?Q?CPYM5j5TyYW9nW+4OEk7jp59k7pnRufZVWwA2avWxqXI3eVdb4IhdudgtFEG?=
 =?us-ascii?Q?0jHjjvRjIWr6lK3+2yYMq/VFFY+CQ168PTvOh5tjTtBqzar42G2rtSN/8AuR?=
 =?us-ascii?Q?FuLEDKOyvhs/UtP6GBjilHOqV2Ukv9uw0w3KJWFmNcUQXmPjlF2yVNssFgau?=
 =?us-ascii?Q?2HsWN4e9BUZu2q5oH0EwbGL6m/yeSEO9hvUV5Igokj3wTQipeivUydUjK9lN?=
 =?us-ascii?Q?+rnxhoI2C1C5VaYWk5Fcw/RerFwbP5GXl+AXU2jq/igUzlDPzDCQLig1Yog5?=
 =?us-ascii?Q?ZgSRMjhON2rw8NfR7leebm0X3K7f7uQRDxuuQFUtOBOynutC3LK9kdUh2Ue7?=
 =?us-ascii?Q?umrvDzleBMMtOn/EsBYGwzuDeA+M9kupc+fet5UpBC+voTHSw1o/PkJoYf7h?=
 =?us-ascii?Q?moPb9qz09bzdJwxOj/zEDmO41X0rWVDR/LadPbN9ejJV39zybNKGNCsEjmpv?=
 =?us-ascii?Q?UhibZ51q/7jVRtIXh1aIwXyPZX8sFDTGU3KIVQr/K5LpZbFYKHUHZmwcJJZp?=
 =?us-ascii?Q?LlSfuPXDPDOs0BNmfphxgjqHH9i7Emk9yq7SRHsEcjutAC1cGtqVEmc1VlMu?=
 =?us-ascii?Q?2Vsi7Grv/SbWqcF03uAQr+hURIq9me+0ZpKqibndB+9uIK2n0izM+IPonfzd?=
 =?us-ascii?Q?ieLzHfU+S9z2mQ27JOe+1gV1ZuK8jR2dolh//FdqQdEKA8Ax83+RUe3C0P2W?=
 =?us-ascii?Q?7/Um/lhv79/sYSv/XyhxmUwZVm2sgbftZo7eQF4OH8y+4x2we5q42XrgoeGc?=
 =?us-ascii?Q?7zcD4j9ZoX0Y5EI3xBZxdYbdPSoiBWKnu/Q7AVM5CWwMaz8UP3Bnp1vAsbRq?=
 =?us-ascii?Q?2OPvJJ4WoYsi7glLG+cM20P1GTowoLdBGPpmX3hVxX9DDSnF9wbGcPWrMhAs?=
 =?us-ascii?Q?4gfFyLmpC/ricEtuf9WY9Rg85T4mCMXZscIb3cXD6GRYUgYnNL8md8BaSgPH?=
 =?us-ascii?Q?cxW0hdCnMabpf0k2hqhfdpSbMbp8OnHVRdBMPsEYgZ8OuXd4aLmCnsjcdN/e?=
 =?us-ascii?Q?HJDifgqHySe1ySHsbiJVqiqtZEurPqbIEQwiV0ZpSa2MqLXU2rH1re1dVWm8?=
 =?us-ascii?Q?ue2lNsAivv6Z2eRkmy9fogk/1mfWvtsoHunzDrGRLcQChiUpyJUMl1M8CU8f?=
 =?us-ascii?Q?oqbqTLL3uqnGrVwu1NjFOQqTdrNEJeYOgjj4PIQb4pRMlPNtK4LIPot95xLX?=
 =?us-ascii?Q?i9pxkh2u3vev8JCslnrIwkFPU0YvSMnpI51Rz9jWHQH7W0KfOCmUjVr0+/Jh?=
 =?us-ascii?Q?QSS0/JYRZxjgc42BEXH44/jsZAQcVnWuuLnYvGpfg1aIL6v5Cxk8rGgWYm0D?=
 =?us-ascii?Q?jVBflTRbTCfAdYacHsSP1JcXwxccab3LYo3r03rp7q4rxSly+AukO66yO4BS?=
 =?us-ascii?Q?73rhdNg/g6OWyMw9sjyFdMEmpf7y9MuqkTRuo3QcNPQOSd2lTS+ZFvQu5367?=
 =?us-ascii?Q?93KMNFnLhmVnOcjolIQBVY26hSSXG/OjtgB09h0QqC65aCjT2/pwIvvN44oF?=
 =?us-ascii?Q?KGH7KZAcTO5ii8KQMIPImuWO7GhYTYoMvpKVe+xt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464e5ec-1c6f-4b32-f914-08ddad007ef2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:20.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPBW09L0+SNo1YhFOZLu0gG4AXEnPGvw5Yy5JyqhpskB0gzplTYFd/dgF375f36o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/driver-api/generic_pt.rst | 140 ++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/driver-api/generic_pt.rst

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
new file mode 100644
index 00000000000000..c0593f73318653
--- /dev/null
+++ b/Documentation/driver-api/generic_pt.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Generic Radix Page Table
+========================
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:doc: Generic Radix Page Table
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
+	:doc: Generic Page Table Language
+
+-----
+Usage
+-----
+
+Generic PT is structured as a multi-compilation system. Since each format
+provides an API using a common set of names there can be only one format active
+within a compilation unit. This design avoids function pointers around the low
+level API.
+
+Instead the function pointers can end up at the higher level API (ie map/unmap,
+etc) and the per-format code can be directly inlined into the per-format
+compilation unit. For something like iommu each format will be compiled into a
+per-format iommu operations kernel module.
+
+For this to work the .c file for each compilation unit will include both the
+format headers and the generic code for the implementation. For instance in an
+implementation compilation unit the headers would normally be included as
+follows::
+
+	#include <linux/generic_pt/common.h>
+	#include "fmt/defs_amdv1.h"
+	#include "pt_defs.h"
+	#include "fmt/amdv1.h"
+	#include "pt_common.h"
+	#include "pt_iter.h"
+	#include "iommut_pt.h"  /* The iommu implementation */
+
+iommu_pt.h includes definitions that will generate the operations functions for
+map/unmap/etc using the definitions provided by AMDv1. The resulting module
+will have exported symbols named like pt_iommu_amdv1_init().
+
+Refer to drivers/iommu/generic-pt/fmt/iommu_template.h for an example of how the
+iommu implementation uses multi-compilation to generate per-format ops structs
+pointers.
+
+The format code is written so that the common names arise from #defines to
+distinct format specific names. This is intended to aid debuggability by
+avoiding symbol clashes across all the different formats.
+
+Exported symbols and other global names are mangled using a per-format string
+via the NS() helper macro.
+
+The format uses struct pt_common as the top level struct for the table,
+and each format will have its own struct pt_xxx which embeds it to store
+format-specific information.
+
+The implementation will further wrapper this in its own top level struct, such
+as struct pt_iommu_amdv1.
+
+----------------------------------------------
+Format functions at the struct pt_common level
+----------------------------------------------
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:identifiers:
+.. kernel-doc:: drivers/iommu/generic_pt/pt_common.h
+
+-----------------
+Iteration Helpers
+-----------------
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_iter.h
+
+----------------
+Writing a Format
+----------------
+
+It is best to start from a simple format that is similar to the target. x86_64
+is usually a good reference for something simple, and AMDv1 is something fairly
+complete.
+
+The required inline functions need to be implemented in the format header.
+These should all follow the standard pattern of::
+
+ static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+ {
+	[..]
+ }
+ #define pt_entry_oa amdv1pt_entry_oa
+
+Where a uniquely named per-format inline function provides the implementation
+and a define maps it to the generic name. This is intended to make debug symbols
+work better. inline functions should always be used as the prototypes in
+pt_common.h will cause the compiler to validate the function signature to
+prevent errors.
+
+Review pt_fmt_defaults.h to understand some of the optional inlines.
+
+Once the format compiles then it should be run through the generic page table
+kunit test in kunit_generic_pt.h using kunit. For example::
+
+   $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig amdv1_fmt_test.*
+   [...]
+   [11:15:08] Testing complete. Ran 9 tests: passed: 9
+   [11:15:09] Elapsed time: 3.137s total, 0.001s configuring, 2.368s building, 0.311s running
+
+The generic tests are intended to prove out the format functions and give
+clearer failures to speed finding the problems. Once those pass then the entire
+kunit suite should be run.
+
+---------------------------
+IOMMU Invalidation Features
+---------------------------
+
+Invalidation is how the page table algorithms synchronize with a HW cache of the
+pagetable memory, typically called the TLB (or IOTLB for IOMMU cases).
+
+The TLB can store present PTEs, non-present PTEs and table pointers, depending
+on its design. Every HW has its own approach on how to describe what has changed
+to get changed items removed from the TLB.
+
+PT_FEAT_FLUSH_RANGE
+-------------------
+
+PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to generate a
+single range invalidation for each operation, over invalidating if there are
+gaps of VA that don't need invalidation. This trades off impacted VA for number
+of invalidation operations. It does not keep track of what is being invalidated,
+however if pages have to be freed then page table pointers have to be cleaned
+from the walk cache. The range can start/end at any page boundary.
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS
+---------------------------
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE however it tries
+to minimize the amount of impacted VA by issuing extra flush operations. This is
+useful if the cost of processing VA is very high, for instance because a
+hypervisor is processing the page table with a shadowing algorithm.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 3e2a270bd82826..baff96b5cf0ba4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,6 +93,7 @@ Subsystem-specific APIs
    frame-buffer
    aperture
    generic-counter
+   generic_pt
    gpio/index
    hsi
    hte/index
-- 
2.43.0


