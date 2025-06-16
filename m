Return-Path: <linux-kselftest+bounces-35130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E903ADB869
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3471B188D271
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429E1A073F;
	Mon, 16 Jun 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TF+XY7bm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7F19D07A;
	Mon, 16 Jun 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097193; cv=fail; b=bDUd/kwfMHKwqV+xftvHBSJKoXxjmOaYngx09jtomWAV8AeWK2VR0YpJ+ZcrJk24N55c9pdsnEIy2LyGD0aPluk1sSdCqANPo6abijOiE4M3kYJI3Qxjod6jAOmrNEp2CTdQsly2HspmrQMiIdvCjOX9CHlisUSlvjwDgd4TAAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097193; c=relaxed/simple;
	bh=T1nYsqQkhuWIaDuwS3g577cxdjwA014VnHa5fvH8OVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLSOj+kiXeN/81LDMZKOKdvgV/nUXSJl70ClISPoH4cUscNCzXPLPIE/Xg/eg95zk2hq/d6kLL6G4jso+PXhuRrTgWFG5YzS0Auo5OfR19slwGKJCMg6MZjh5AjgvTd5HBLtWFDGo//3WmuqJJIOcyYfmwl3QcnEkIoprCdU8kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TF+XY7bm; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpJTO7K6hlkWdX500+KdCRHjxKy5YHRe5R0XDO3DPB4WIVj4ODjI0OfSgpnZuXwU3hhC6I0CTIDE1LUJqKB6bgus5MagAT8uE9F9lAV0bu56sf+W1nNoDkLyTg0T77n58m89M4XW0EBipeUxoriDQNfNdDyRBxn8lvii3HJRBHmqkjya7/hjxP4WuKFbaAR1lDFHwJQ3pJE5q7ipe0k1lVqmaOyK17xc6nnL7RnrLbXaK/9k5xGbdA+jtx+RGL4T/mWk4Jgioj7mxq2Z6P/h6aZBk99plycThutpoCCp2No95UEm9VUY9IXOc76cZgqxfeoyiEcnxUbc6G9VEf9HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGDqw59iK58jjiOAqr3xfLKXZDMZDIfyCKziPsfoslc=;
 b=XY7rc01h82s2yTlTKPp2NWxwZW/hg+1u6KPxezfSW2cc1z4C9dml28sxed9EhmCH3jwThYqI/iiMKjQ0X06uPwTvpy2gGMDKePLEe+sqVgONhPRpTC805T2BuZ2qSD7NiGUkvPRGPyB1yezK9VhbRwxDOD2Jz2s/VIftWGMudVVz4WfrqNJOWKAeeDe4cxqLNlGAAIUspTAT56rbkmSU21edK2pigBsNfh6G3nSBNc6iIdjEWs/cQQ7061imQFzUROJOJlRrkn7xt5m6yptO/dm22yLhmdwH61Is5n5u3GqicBYwkfigKHr/0kANIfXU6aLCm+oEhvbYHtMSzQ1ScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGDqw59iK58jjiOAqr3xfLKXZDMZDIfyCKziPsfoslc=;
 b=TF+XY7bmRx1Q4mWRvWYxKa3/GHRI4H7vphHlMQrjSOyHCcW2hcUAqNpaNBQYi/lPzwAHlKeyDrwnMOE2h1n8REBgPCYZW1uScNqIpx+QaNRl6pxH89JOrEtTK45HQy04lAZDEIegfdjpsPHgODx+eVBAeudlGcWRy+Iqm4yP6OkxXkGIEwcyAAoe9QWnL4AfZZagQ+zRkmF4gWhklPzUukNnNLrvIxIqBb26lI94YJHKPfP3LleNVNQNyX4/8mPtbWe8Daot0o3oc8FIeH2QktHfikO22CyBu2uKEKFonvRwGCZtazKOu57CEDyf0XHIUc2rpYbcuVhDlElUe7q9hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:26 +0000
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
Subject: [PATCH v3 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Mon, 16 Jun 2025 15:06:13 -0300
Message-ID: <10-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a132d6-2915-402e-bd80-08ddad008125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3FuyZx4yi/pjiJ+VeIm9nCwfgifMx+mhQnM+GLvd/Ir1gMs2/QF89N60Z0CE?=
 =?us-ascii?Q?REe14Yzfpa+Mxt3IvJZRDLZz6tLZwWKzZIHYB0IjUAZJliXTV/3v82oHBw0M?=
 =?us-ascii?Q?+ZD7+S4/Mef0OCLnPQDHL6xBgvPAE4aNs7wpb55sDq+Vdvw//3kKIC4cJcFR?=
 =?us-ascii?Q?yVaSfvniLyre9jPkj1gaIXmb1Q1dRGpODNzWWtu0+KOQHgFasw0TcA0IUbwf?=
 =?us-ascii?Q?0n4H0bc1LyTAwEftADIPU//cyVFXMp4yiBjXv9KOCRMV24elpBrt0NZJA0L+?=
 =?us-ascii?Q?IiQdLPsZPy2vXsOgrahUDL0xpKbxTsId1H7O7euNa6kHxxbTn4WdleQQEDzZ?=
 =?us-ascii?Q?PiwpQK6J73QGZF0ze2QeR6yt2QYuD86pJ9A+UI7ZTfKJONn7L/e9HcMWkgiq?=
 =?us-ascii?Q?HiTHS4BygOcuXejTLUjy54b6A8K48ZNHeEu2jlN8X35p+ZGcuzbehiEChJBi?=
 =?us-ascii?Q?pnyJ6NLPj2dNnxJOtFeR+hqH056S5vIcjiAfMIIbHb60LQAyX2KEwHn/SIAe?=
 =?us-ascii?Q?hno6GevJ9NaUliyjD0Zmnf/bCqDaVHzx++rJKLdJF/cJ7+BNb7e0DnP5mQkv?=
 =?us-ascii?Q?4SRrl9OYo2Glh87eD656aQU94IAw7HD6shf2rML+upsm+WYQOAev4qzdGzgC?=
 =?us-ascii?Q?VmLkHlyeLy/gg/f5gxZWBIgxoa94aa66iSFxnOKPzL9qNBtSBDJwEa5HuKC4?=
 =?us-ascii?Q?5SG/NBJlQdrQcjahX/DOMhQ64Xq9h25WO6uMp49nHktiMOX1+tmAPVAChl8o?=
 =?us-ascii?Q?MrNkEgOXRQrkuTIH6g3Z4cIq7+15sYxIRrX7ft4FXaceNFGz6eVL1BHYoGdA?=
 =?us-ascii?Q?U6/YdFNdkt939+9CF9mw5uXejKAcNFXW8QxBXbiJMTIoZjE/nndqUk8S4EnJ?=
 =?us-ascii?Q?xmelNRRpmzeKN5k9EdKzqBwnHSfcZSYIKJH9dGJ698JEqEDp88ZJuMIdRs6T?=
 =?us-ascii?Q?3UvR6GfHkbTdlhLEytbLwMokaPvbZztkj8gI0Ef7BAH/eQ6jqIEddPlazO+X?=
 =?us-ascii?Q?bUsSLd8jOFxf4raXuIWovTd658ip2+knAqjUg794CIWw38P/2I44cYfQecPc?=
 =?us-ascii?Q?vLxkkq5W3ChokNcD/qNCze1VZbtPGEelKcBVOlbWlEUHjTLW8+ZvBtju8mNA?=
 =?us-ascii?Q?gHbml4b+Z2Ye/Fd/Oy8jSMR1t1qRRVKw4IbKcLn96Y2q5iR/YPa6Wh5tL376?=
 =?us-ascii?Q?Y+2jv/a6Zd+PoP4dqsOwHHdAupYWtGY5piKT0EHw5Gq5JyN81PoDInxZpgQQ?=
 =?us-ascii?Q?3feA6rueTF/hmGgPkyxwu1ETtF7ARoL1SAHh/1MJg2yFJGMf90miWVEFFYpP?=
 =?us-ascii?Q?RjpMdf7hZn2lnRj0m7Y+mCxjKs73R7C93Ob5OqISLG/v7Zz3PRRwjEbTvFnP?=
 =?us-ascii?Q?69r0i7g9GEB7AVqfrTvVvLo+tT0aotPY4OHe3rWYBogBtSmjOwea9sGOxttl?=
 =?us-ascii?Q?db8O4akugRkjeayUc7w3B01zgZtYcu90C0VIhdHw8DoSCuyN/XTEKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y97SfW5a1+6EBF0JAZ70PhPXWUYFIs/DvjvkHj1QZl4hnCMj7XYIo2kEulA+?=
 =?us-ascii?Q?YQm+6FXzCXyfl4CwmID0n3UoqEnyNApRLzLjQvoFvQAy29PVABqG5CeZO9co?=
 =?us-ascii?Q?l4jAOY8z9yymnPwy3rDuJqFZLoPdloutB93ymOR6ivM9sbfkF0OBLjZO+5ZQ?=
 =?us-ascii?Q?fqQ9CRPcX/18O6mDDCIOZBPoj/KV9BEQ05BMV5/iAssZ/XCpVeuCu02zteYF?=
 =?us-ascii?Q?muRjWVr4pCtAeAPCIFSXQ80yz+oI1wBYEt1fy0QH3gmHl/lt22v325qVSV7Q?=
 =?us-ascii?Q?6VgU4KH8rQ8k1ZxRKUN2/ZjSVyzcP9Copgle6l6+7NrbF1qKGIjVaKrjPMa9?=
 =?us-ascii?Q?bdzAUVmyY+MhauYGmDpijV5vhSa4whOHlwp/XFxdYDV0yB21NwM2jnt7LyoA?=
 =?us-ascii?Q?uxd6/J9yFjAH1RtNdkZFM3wFN5sZzhnVlISZxeIK+sPM8lEgQkZntpT7aXPy?=
 =?us-ascii?Q?I7RAy9Kf/LzYwoOMNhFQrDavuv0q/1eatJQRgvEPE9GDUW9XR4Vog0PVBVrT?=
 =?us-ascii?Q?2is7bhB+AEHTAEWCp8ywV2EVpZGiQEUX9jvwGgKitWe6oLrqJPDiM6NJQGOM?=
 =?us-ascii?Q?xZOQxwkd2uNBwjT1Pgom6eNLf/yLYmvrS7aEuKfAOLemGiV2413V90brSqtp?=
 =?us-ascii?Q?1B7Mv4ppmLmuykOI8jyBcGIN793xFw+HW4mg7gzQBtt6tV2N8sYB4M5WoE1M?=
 =?us-ascii?Q?96hRy5J/EQa6/hsrDJsbuoACMkQlwJmmXgLbSlLODHlh+NC540gokwKmt7HC?=
 =?us-ascii?Q?nOMtwQNqcyGQyZJJjiS8LP2t7PBrK5rnJ4DJlRgqUmzUxwoXwEdM84x1kwfR?=
 =?us-ascii?Q?LSlOFuGcRjC+1Fs228DYrszM5k0YEfYvh6ZZxPtgfUePwWx4QGxAEqhO7nXg?=
 =?us-ascii?Q?3jUSaSdpKzpxIE+5Y+DMX51CXf7y0M5CwMF+6AHC7geQZtzR2stlI7Yp06RB?=
 =?us-ascii?Q?Iep5PSnWYt/WlNsHy2F+FUChcDRL3Ib8ypn8HYpp7vEXA35sRkqnWcORFRWy?=
 =?us-ascii?Q?4l3AqJju8rYzF3r27dNYtUINlotMj4DLehyNZxr3L291nt/VWp4ur70CcQzO?=
 =?us-ascii?Q?a2GeKK2DTgfOYgKxc9qYfiEu3ir2a1p9gs0rGPY0uSIKpc0iyC6TE7jE6qe8?=
 =?us-ascii?Q?Zpl5XU3/kAiBj8whq/u1KTMKUxzLhRpG4WaOPxVLt1stC7x2ct1LsOW5jkTN?=
 =?us-ascii?Q?Tk35m+tRSVlqanPdlj+E83yM3vZCSb+nkdZ3akHyOYzxhC+izvj1uHZWEpi7?=
 =?us-ascii?Q?E+RPQ2i0XjYpIVKDY+3xFcpiY1IlGeLNRCD4Wze+/965qS9KcrEgwIeMNjbI?=
 =?us-ascii?Q?mRAQgpXc3KRe7S7D6KFZ0d1Df6hBB94otT8nY/4/HAhpsBcmLIenog9gYdDi?=
 =?us-ascii?Q?yqKmgPrOBD60wCptM+4geI3sfNAz8VCoyLyfTr7MFTzqpvhayvMp6Ezn8oGm?=
 =?us-ascii?Q?6YIfDLkCuch4QkR4TqaDJ89lJKqluNsjFJUV3daxQWEPiAa/IvfFwgvkmRI5?=
 =?us-ascii?Q?GEK4rW5e9PHArZvGWFxY1cUSY6uosuVNd2zSO6HjbQm2UbIy8iXG1KvQpKDe?=
 =?us-ascii?Q?UXnProm8f81Hv6W7Xsw+B2PU0anF46GrOH9Gp12m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a132d6-2915-402e-bd80-08ddad008125
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:23.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mM6/yECzgkoYnburzF2RCU4WRXx4Toqsqq4jMd0zRuphDdwZuhGeIXFh1OEvsC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Slightly modify the amdv1 page table to create a
real page table that has similar properties:

 - 2k base granule to simulate something like a 4k page table on a 64K
   PAGE_SIZE ARM system
 - Contiguous page support for every PFN order
 - Dirty tracking

AMDv1 is the closest format, as it is the only one that already supports
every page size. Tweak it to have only 5 levels and an 11 bit base granule
and compile it separately as a format variant.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/Makefile     |  1 +
 drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
 drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h          |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 32f3956c7509f8..f0c22cf5f7bee6 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
 IOMMU_PT_KUNIT_TEST :=
 define create_format
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index cd72688322c6bd..c7442d85a919fa 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ITEM_WORD_SIZE = sizeof(u64),
+	/*
+	 * The IOMMUFD selftest uses the AMDv1 format with some alterations It
+	 * uses a 2k page size to test cases where the CPU page size is not the
+	 * same.
+	 */
+#ifdef AMDV1_IOMMUFD_SELFTEST
+	PT_MAX_VA_ADDRESS_LG2 = 56,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 51,
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 11,
+#else
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
 	PT_MAX_TOP_LEVEL = 5,
 	PT_GRANULE_LG2SZ = 12,
+#endif
 	PT_TABLEMEM_LG2SZ = 12,
 
 	/* The DTE only has these bits for the top phyiscal address */
@@ -372,6 +384,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -382,6 +395,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/generic_pt/fmt/iommu_mock.c
new file mode 100644
index 00000000000000..74e597cba9d9cd
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define AMDV1_IOMMUFD_SELFTEST 1
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT mock
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 658ef69156121f..cbe6433550f380 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -236,6 +236,12 @@ struct pt_iommu_amdv1_hw_info {
 
 IOMMU_FORMAT(amdv1, amdpt);
 
+/* amdv1_mock is used by the iommufd selftest */
+#define pt_iommu_amdv1_mock pt_iommu_amdv1
+#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_mock_hw_info;
+IOMMU_PROTOTYPES(amdv1_mock);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


