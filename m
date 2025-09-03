Return-Path: <linux-kselftest+bounces-40699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D312B4283A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44291B28363
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEC32ED4B;
	Wed,  3 Sep 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGt0lO2H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9F3314AC;
	Wed,  3 Sep 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921624; cv=fail; b=NF0n2cJO/oC97ezmo04tBEec91tcBpijjMP9UJjmO7u6dqR8JOsYLcQgBDa2+/a20pwOC5IbnDWLjeZLAbSvz6qqQQ+c6QpJxlDhqRVwvmA677udTBe4bZFXyrmMtP1F7UQjEz1bGi2SdoVeNQ2Jp1phZT+mfHIT6YsNq6EjUaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921624; c=relaxed/simple;
	bh=nXAgVFgUeZGKQVloKheBqE7hgDxhVnQusEk+R/KVnbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLb0kUVdTOScmUsMpnWyOeXrwMVy7FBuxdVADcu4S1WeHktgeCuhR284zMZcvKrgdw3WLj+6PP9n+Br8FGDSo9FJSJTYX1bna4e64rDw5FmKCL+LtDSBXptamrhJqYcPPKqE/x0ThETpCnEq+EkPvGJ/KLqH5+woVkXpRX9UxkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGt0lO2H; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl1kWvifiEFBfYOzBjV0gvt62TED/d71GsV1sjIHu2u6yu7LvUTxveVKM0Bn7BN7FESQbImsG4oFi+4JP67JYKbAOTSQm/xbbIIDqorvzYVoRxTqrdbKZSvBqnrPUxWwS6z7+VQI2DBeeMSUiPbhQy6zr989BE5yQoyherzoq8blO3HydRvNJOetIbyv+ICL4IGLW4J1jQGFYU+V4+cz7B7fKRb4/GJ0MQerez2Soy+E5AXAQQLt2S49YXmp0sV0TaZNOHIR5yM6BnWM8xV+gTOs4JPhLxFjrDcZzYGTiAVHtVkT+JD5SDk4+RC0PdIKxJscABoOxYxi1m7Q25VtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R66H2A7J4fu36z/HdsVL2YWKaHBBrHpLiiPHr7cYJNM=;
 b=VL1sIX+UKCdYewwGm56X8GY98K0Avdl0+3+XhRQXBM9Zo9M72kgYOI8EgJresJ8wnnbUUzZR483RIUUBwfeC3JZh+/kD+nM4oUbz+8ER9SA2vbUtCwp2Ci5f+5HLl9k7soHwS4QPKklGUjOzK4fT0Lu3fZ9epsqhHelV53KKjMnHu1GaeXuHYLr2sWYOx3APCdjorFpb/AXjifg6r2uLHF5xZYaitpIsQmPRCxiYxTH8uzBUw5O858pPreQ8my1ZyVZ0EhiT/5VRF2HChNZAlDb70azKQxk7RQkvbUfchrVlkw47cipJZ8GcqfEKIXBWHqAWmiXbSe0mmmjqs+EVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R66H2A7J4fu36z/HdsVL2YWKaHBBrHpLiiPHr7cYJNM=;
 b=jGt0lO2HanDw69yThAKVERf3XwhxL3qY3J0SeQAvdmiDVy6MpEEWrn4ygQllWnssqi2O2ddiYJhn/LzZGV+d6EC2tuZjMS84MNFr6FyFy+n/AkaG5twmGvvhbq39KdbmV/+dokTFuzZ1fPlHttAigYx836Uy5F6yOkFhFFXbTKNTVvxu1Ikea21UVFe2Z0VztqEMst0MkshTP5jb0F6MhraPOnZXTuz1OM34QnSQL+gRmtktvpR2nhK8e3u257vbpGUVMQxBplc9R+oh/wllSERCXNrx9X3K6D72mOk2+aHpqnAx7MgmEoE8ffdWZJXKCMcvPM0gUdDvGQ3jYRzjRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:50 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:50 +0000
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
Subject: [PATCH v5 06/15] iommupt: Add unmap_pages op
Date: Wed,  3 Sep 2025 14:46:33 -0300
Message-ID: <6-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0382.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a33c71-fdd0-41f7-8912-08ddeb11d9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lqzgXB6J2NhcRcap3vuSp6ZFxt2P4/LoFgzPQ69HX2uXAsb3eVYYCLwpw265?=
 =?us-ascii?Q?PSCuDQcXbSBr7s5VG1cG2OqGgtVt5zH/epuPrf98NGqmsz3jueOFdt6qh234?=
 =?us-ascii?Q?3xSnzu576qqCWC796aZx3x+8PnB21aWRC12DcsNLzgiyy3sljGMlb4igtuTJ?=
 =?us-ascii?Q?8hdoH28+aNK18eKpnnsNy0W+7eQHtUYjLZn8D8+sxCACBSafWc05/CGNQqrG?=
 =?us-ascii?Q?f3WNSvcLGtkMof0OGlTMPobWNVcAItPQ5DtsD5ac/bm5rMD92J6uOcTVgJ7D?=
 =?us-ascii?Q?ohF1yxuPIFA9w2i46m66diObGq3xsfpBJVXkSejpSKCWtOBv6YLs9RIzKvQS?=
 =?us-ascii?Q?t+pvW4NsxuWFM2r8Erl5J6nCGtmB/+LzXn3148ymM9o25aDMv8gzQ2VhqcjN?=
 =?us-ascii?Q?vZz/yiDKw/3xGuFTKcyyo2GZEmyyrciW51E61pman6wWPEfZ/K4xCVc9rGBj?=
 =?us-ascii?Q?ZE9eFFP+hPPQWbLxD902UGzdarKG6KBoqivY907g0LQCDO+pwf8816jXVuvG?=
 =?us-ascii?Q?2CJHZtGaLsfvJIE48vD2kXyaxiMX/NAgUUlQai/e/FUhMu0PwJSwuSx/+GJS?=
 =?us-ascii?Q?MU0BX2WA5RCWcELDPCevULB7N/Wio4SNvg+pJ1IlIXXqsy/rp0FHpYSFvh8X?=
 =?us-ascii?Q?8ncmcm72TCD13OqRHUaD4YUVPW5cPqAxWQQzJfVsuascBc/hOJhWkFNMBaXz?=
 =?us-ascii?Q?k3wwj3f3eu6tW2L+2eQGSbmrV9EcVsR1oPC76Wl5nE2mZmXej/wZAgOTk+aZ?=
 =?us-ascii?Q?uGkKTgSkNRM7xsnUCN5L4Bp1PZ9sPve2ZrWqEm88ZBKvtGza0o0cwUCYMyyu?=
 =?us-ascii?Q?I2X59rU3HzesZbDE677AV8KPloxIogduJ6/HYhZybwxFSBw+4AKVNTCj0dgu?=
 =?us-ascii?Q?hC17CE/EqbSVYm14cpu42XhsD6cnyk0AxNckrDArD+Fcy2gA2UicT84iZZ4w?=
 =?us-ascii?Q?PIK7ITQXu7UWlrm7oNoAR0xipN1sPWWF33pQmpQVY/DAUTzclMvydKU8kCoh?=
 =?us-ascii?Q?uj22ih1zOiOqAGFG/0VkaEtOlavaQ99zsK/HWXdVxAvq+gxWDduE8IvIi5Fn?=
 =?us-ascii?Q?6N+QzXVSHu9XmSYF0caU81AVcWD6JJOJtRPhSBUOwC0CKhO778XdINVUjGTA?=
 =?us-ascii?Q?oQJ+BmG0Z/cqqnCovdzR6TJvOJlX3u+MwnKLRWFe4ubjh461KMNCf4ohAni9?=
 =?us-ascii?Q?hLKCYx0gxCFggRWyIH9Z2P2pNulZYdo//EZEOaSQuz2elkMqTPySXqkPQcML?=
 =?us-ascii?Q?szmQ4NUKgqilRdHeXySO8TVcj2Ody2MhWWJIqiLMcN9tp/+ZNaePxchBoMmy?=
 =?us-ascii?Q?dzVSVrapNnIdlizSiLd0CmsGUikyo+6U0yQ7wq1Oz5jVgH1vyccvBqb6vP3f?=
 =?us-ascii?Q?k+a+HTUypi6xgaLJ49dC+T0ldnQOxgpvusJPMV7UuXk5Zr0wQOSx4Kxw3fVH?=
 =?us-ascii?Q?qIoD8P6RkK8nXJDpVMGq9GgrQc3894UXM0mETR+x1UJm+GbrpUwFXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xmuexVtOWGukMm5ZvoyxwJwD6f6w0QWA6gXSVgvEyc1SmR5NpVM1D/ML7ZY?=
 =?us-ascii?Q?KNyxOMYTMc2ip4x0Aqm9w0cGGJ6mmWGAWvZXzIKO8+7fkbGsZapPQgwsUHe2?=
 =?us-ascii?Q?rnHnY1+jTX+6AYc2YUBw0txETTvSgT+ROub4XZ3JqqU+A8EnFZDCkk/Z4YsJ?=
 =?us-ascii?Q?8/p6pq2AZ8g37TNBM2oXumSERVp/66HtYgQ9ysKp43uXi57kIoiXh+jJ/5mF?=
 =?us-ascii?Q?PADhewcSqf4U5lHfj39Feaw3MGL6tJ6L/LIMkBwWZ5gWLwesknjEHBHz5Vp1?=
 =?us-ascii?Q?JzyIYiz0DbE8X1yed4BxxmPMiF4bcCSk+48Lyd2hZzU4JAir+1HitiZJmmAd?=
 =?us-ascii?Q?gaPz52LcIg9FsWls3+1yO87UanBc0HonBWOocBm4wXJiZsduCcloSd5eO/Ti?=
 =?us-ascii?Q?Cp5qVfkctZOSc0osirBbrU2Ac8WtVVp2uqjWL54p68HgGfygXmPyk4ju+/Y8?=
 =?us-ascii?Q?e3DS6NQjBzSEwjsAkff3SjRPZ6eQNkjFDJI8VZz1pikX0Z/mS5KIrYJC831v?=
 =?us-ascii?Q?Ql5Vy8oeFzQt17y6UpJJk4Ay4YWxaL/F2ZwXnxoCB8F4NFM/8BOyXcD7RxRQ?=
 =?us-ascii?Q?KW2/yJm2Dwg9L+LpocNEwdk0f86+nlsNQPaG61PUU2rQj45vOk+ntrQQaUYz?=
 =?us-ascii?Q?GsdtxrdrA5WdAkOctfyZBLB8Ad3tNevYzQGq6LraPZF57NnZEnkHy+ykL49K?=
 =?us-ascii?Q?WQ7/FlXQcj4HlVlALZCtaM+oZIv9cKZJXRDe16o7ikjWj5yaDUhXlNrdimXj?=
 =?us-ascii?Q?Q3PNwxEjh5+KHFb+p0HlDX7Q8yloaAycZtX98WXhhE3QVtWfYa5UznpXmbio?=
 =?us-ascii?Q?AYRy2Ko2Divs66mIM5BTQ9NuY0z+ogl/inB81FWev0oMx94dKResX/EeR4Xz?=
 =?us-ascii?Q?RoyAnPEkt7lHuq8sFTA1x1e+jAnkjgmtQbJoH5JRSzNkxxNQ9JuKRvvueMIC?=
 =?us-ascii?Q?Scji4kXFFri6ehYksgjRlGdg8WlRjdTWXzkQoFI3qnozOysbfKdskqZXRFUC?=
 =?us-ascii?Q?XANZmaaoSQgwMGJY/n0PJVOeQZs1eW3FsiuAaw0gpjzkYyMI018jMwQHUH4h?=
 =?us-ascii?Q?h/4Qa4yUOv8f7smPpT8xKa3p3ety0g/Aj7KDPCygk4x70DcSR+BzaAoviMq7?=
 =?us-ascii?Q?gdcqgLsLxMQwAcSrkJaou0AORBReqltAu/jJ3SSNDbeKtFA//YnysnEA2zMx?=
 =?us-ascii?Q?qKrRemarrNIPSXju2PwuNJHJXufbn4vgruN51Gm1kmsMU0q9Xd3+jVcGBEMM?=
 =?us-ascii?Q?UKHCLUDR5H1XwV/poX3nP6GxHZE+Ct0gfQO1/65MO5HcMW5Kp0YV6kaUeJvU?=
 =?us-ascii?Q?fWnwx7KMzi6fC9jmkSvnPy7ZBc/x8Zu2FbtVf1azkLuTlAd7q+LrMCeB7p2E?=
 =?us-ascii?Q?IluwXbaxuWl3OcrDfVEe84XUfORyjoo9k8hv2ex7lHutkD8A1ZWia7/8SMiG?=
 =?us-ascii?Q?jPMya1k+qejUWHBbiHh4BZ8kDDUhFwPhgcwfZnYQYB1ioyzgWr1nvhr50/Vq?=
 =?us-ascii?Q?IjIF9a/NzIXNc5fQye/8ZzOuJMgBlW/AXXBTCus/Ezt5FkUVktCT3NXHOkBk?=
 =?us-ascii?Q?QIqjvaq0JOGqVRKACCE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a33c71-fdd0-41f7-8912-08ddeb11d9c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:46.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTdyjuqa5CjrXXXB/s8m9FfeGsf2yZ+iqnm9N7a+IiNyETJ/AM73E5WnuqUCTTaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

unmap_pages removes mappings and any fully contained interior tables from
the given range. This follows the now-standard iommu_domain API definition
where it does not split up larger page sizes into smaller. The caller must
perform unmap only on ranges created by map or it must have somehow
otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
scan for them)

A future work will provide 'cut' which explicitly does the page size split
if the HW can support it.

unmap is implemented with a recursive descent of the tree. If the caller
provides a VA range that spans an entire table item then the table memory
can be freed as well.

If an entire table item can be freed then this version will also check the
leaf-only level of the tree to ensure that all entries are present to
generate -EINVAL. Many of the existing drivers don't do this extra check.

This version sits under the iommu_domain_ops as unmap_pages() but does not
require the external page size calculation. The implementation is actually
unmap_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize __iommu_unmap() to take advantage of this.

Freed page table memory is batched up in the gather and will be freed in
the driver's iotlb_sync() callback after the IOTLB flush completes.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 155 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 06e1c85340439e..614af5d1e17e50 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,29 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+
+static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
+			       struct pt_iommu *iommu_table, pt_vaddr_t iova,
+			       pt_vaddr_t len,
+			       struct iommu_pages_list *free_list)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+
+	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
+	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
+		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
+		/*
+		 * Note that the sync frees the gather's free list, so we must
+		 * not have any pages on that list that are covered by iova/len
+		 */
+	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
+		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
+	}
+
+	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
+}
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
@@ -167,6 +190,138 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+struct pt_unmap_args {
+	struct iommu_pages_list free_list;
+	pt_vaddr_t unmapped;
+};
+
+static __maybe_unused int __unmap_range(struct pt_range *range, void *arg,
+					unsigned int level,
+					struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_unmap_args *unmap = arg;
+	unsigned int num_oas = 0;
+	unsigned int start_index;
+	int ret = 0;
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	pts.type = pt_load_entry_raw(&pts);
+	/*
+	 * A starting index is in the middle of a contiguous entry
+	 *
+	 * The IOMMU API does not require drivers to support unmapping parts of
+	 * large pages. Long ago VFIO would try to split maps but the current
+	 * version never does.
+	 *
+	 * Instead when unmap reaches a partial unmap of the start of a large
+	 * IOPTE it should remove the entire IOPTE and return that size to the
+	 * caller.
+	 */
+	if (pts.type == PT_ENTRY_OA) {
+		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
+			return -EINVAL;
+		goto start_oa;
+	}
+
+	do {
+		if (pts.type != PT_ENTRY_OA) {
+			bool fully_covered;
+
+			if (pts.type != PT_ENTRY_TABLE) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			pts.table_lower = pt_table_ptr(&pts);
+
+			fully_covered = pt_item_fully_covered(
+				&pts, pt_table_item_lg2sz(&pts));
+
+			ret = pt_descend(&pts, arg, __unmap_range);
+			if (ret)
+				break;
+
+			/*
+			 * If the unmapping range fully covers the table then we
+			 * can free it as well. The clear is delayed until we
+			 * succeed in clearing the lower table levels.
+			 */
+			if (fully_covered) {
+				iommu_pages_list_add(&unmap->free_list,
+						     pts.table_lower);
+				pt_clear_entry(&pts, ilog2(1));
+			}
+			pts.index++;
+		} else {
+			unsigned int num_contig_lg2;
+start_oa:
+			/*
+			 * If the caller requested an last that falls within a
+			 * single entry then the entire entry is unmapped and
+			 * the length returned will be larger than requested.
+			 */
+			num_contig_lg2 = pt_entry_num_contig_lg2(&pts);
+			pt_clear_entry(&pts, num_contig_lg2);
+			num_oas += log2_to_int(num_contig_lg2);
+			pts.index += log2_to_int(num_contig_lg2);
+		}
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+
+	unmap->unmapped += log2_mul(num_oas, pt_table_item_lg2sz(&pts));
+	return ret;
+}
+
+/**
+ * unmap_pages() - Make a range of IOVA empty/not present
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @iotlb_gather: Gather struct that must be flushed on return
+ *
+ * unmap_pages() will remove a translation created by map_pages(). It cannot
+ * subdivide a mapping created by map_pages(), so it should be called with IOVA
+ * ranges that match those passed to map_pages(). The IOVA range can aggregate
+ * contiguous map_pages() calls so long as no individual range is split.
+ *
+ * Context: The caller must hold a write range lock that includes
+ * the whole range.
+ *
+ * Returns: Number of bytes of VA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */
+size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_unmap_args unmap = { .free_list = IOMMU_PAGES_LIST_INIT(
+					       unmap.free_list) };
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
+	if (ret)
+		return 0;
+
+	pt_walk_range(&range, __unmap_range, &unmap);
+
+	gather_range_pages(iotlb_gather, iommu_table, iova, len,
+			   &unmap.free_list);
+
+	return unmap.unmapped;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 5622856e199881..ceb6bc9cea37cd 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/mm_types.h>
 
+struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 
 /**
@@ -119,6 +120,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	size_t pt_iommu_##fmt##_unmap_pages(                                   \
+		struct iommu_domain *domain, unsigned long iova,               \
+		size_t pgsize, size_t pgcount,                                 \
+		struct iommu_iotlb_gather *iotlb_gather);                      \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -135,8 +140,9 @@ struct pt_iommu_cfg {
  * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
  * iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt) \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


