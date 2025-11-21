Return-Path: <linux-kselftest+bounces-46253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B267EC7AA44
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A8B3A1DD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631F34D4DF;
	Fri, 21 Nov 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8q25+V7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299734A766;
	Fri, 21 Nov 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740285; cv=fail; b=OiHcDJVnyVGtZpXup/OA73C5mvRXfKbOMIAoqKs5driipt0tAgpZ6plqVIjgn2APh4NzM9kt+Q9hYkLaSsBCAYYOm+J0ykh4KxedXkiQrl2YXJ/rp+i7efTcXK0+r4Osxz5Yha4XSVv8pZET54gtmJYss7HzRG445jZV42vzph8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740285; c=relaxed/simple;
	bh=9Zel808vRXkJQq+WjGnbtKPp662Dnr6fninQZ5nFGzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFc7ee8+u6/hrY/pqlZos15IE93VEROl2nyoALOOEe2xQJ9R12eyzC44LsSpLU/H5n4J7H5P1d02+CEcg/WkDHfTlWpb/RQ2MhedXUqjL0qSN8EtvMQTySt4/MoBsDWCrwmM2NCTJOpeufKlSQS3hl0EnAW49QzdaxRw4wu5mAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8q25+V7; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzvoAz1NiKEcXL9ELVzsrq5m8Tg2ncPNzOHXD0u8xlPvnMM4qj8q1o1TIwlFznfx8i5n6EFQ1T9+I5mjy8SnHxrpkbe0XmGUaUwRRz1H+iGmfbvq/lLA0D9DGxzOH9PVZsW9cu/5qjp/gWhJGJAEacbOGskL8RTgxw2OJAXIPIUix7P6nYO/S1VWtFCdIGqGZYg/yTHJzOwmqUhe2RO9hLUPkEerihRsSFn65AY+ZAMqQrS3Vq+MYpGP6YxlnshguKWEeZFTjbrkDxeInQngVbypOpR/XZR9FXGpctb+sXgXVOmVlKFgLyNiiICz62Wvychaj4OaTt7KJJzUg8P/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfBUfyNJ7nSDpjBHUPr9BebiA67Y4PiPyDPubcgrMoo=;
 b=qZzChUVZronTxC2D3IzVRtvOmKG4sFijLvu8s3PCKqSwEbH1L/Hu22Zm+fKyrlEg6Stb/Xf78IdfcQ7DVZqlOohU5P6nslxFPcsnFuOfqgzcuRFg4cLuFbmxpPnIxGQUgudkVApyCd+GE/86sOEtq19mRgQVhEP375dtfWWA1Jc9LZvjIWgpNv2IFkdPAct7xDyrcoWlwsc1JUvhUaJCqFOzR7860op7+qggprHoyNg5+5cgShOshEBUerzx8v9HZEu4vl94dOyrq0+CUhcE1po8deb56dSo2NPfVgpv1DjjlAXVFAUDUfJCpq4TGqRfw80dladr6H2uwxY+i3vHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfBUfyNJ7nSDpjBHUPr9BebiA67Y4PiPyDPubcgrMoo=;
 b=r8q25+V7jp8pVlb+HjrmgM2ZWgWxMYFNl/ju4wj2Mn01bY84zRcadkh/NDBmOQs26NLqcg59aRDlk+eZ3XhBnAqYt9vJOUHKjYyfCqG08dLu+x966C/Kr5tq8rsVxUyKju6467RS5dQ4X/SR4tnCwo1URPDrdgeJKvrScPicMy8ClFbKhFXN9lAUOwu4/yxro0pXCJ7zEu6RSAN+8qOSv/dv29j7kMqIIpExUQhOGF+OnAbhUVBNS8C/3GRQCrq8idgquhgeWimG+8b3rqMqcyvizsheU+PDu1NELtYitk5i8BoXIFZKU1Sa5usPNgBwiVxS0p16kS6TOkMjOWPRUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 3/9] iommufd: Do not map/unmap revoked DMABUFs
Date: Fri, 21 Nov 2025 11:51:00 -0400
Message-ID: <3-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd4b761-85a5-446a-37da-08de2915c967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3w9FAfTmzx2y4oPnvpCyRnfBB7BKbdbp0SYxWPHMwlDu53j9ETET67aXb6Ap?=
 =?us-ascii?Q?WOiwHV1dXnxajr2wBQh5Gs3AXOsELU2duwseQF8A62SBRgaJt2opNFu0upoR?=
 =?us-ascii?Q?cii/RqbN1F2l0cmQZOwSFMEWJHh130QiIAs9ukLKP2SyHX2VJ4pHf/fcFbPJ?=
 =?us-ascii?Q?JOFpA+YXE6Hv60CYm0HYQ6dS9LSP4RndG/fy1dxHSUN7dIIaNSufABpGjPiy?=
 =?us-ascii?Q?gxqjJyzs2WvkfbAECiYeJLiNjGjU4rVgZyrn1+cOZGU4M88bQlyzRheS3U9R?=
 =?us-ascii?Q?sVPqTmZHJHe8AgjXrG8K2R5U6xLf2vW5LTpTWw4XVCcsEitwf5/X4LuiHY+C?=
 =?us-ascii?Q?B69saAyhErEEDJadsLp8IxNTTroqHavJb3zFRKrH4m1UOJItgzwokVcSFVI8?=
 =?us-ascii?Q?4kRqvVEEyC+xZ/v5dHGaf/Fr5CesSQC6ZkWcez/cnBQ+6Lo2DmI9QE+yvAWl?=
 =?us-ascii?Q?ky5TIovfF9jobDH5tn68RxFXQUsCvBvO+1Jw1SiWpkO2jpIjLTIsntYloK2q?=
 =?us-ascii?Q?4AJy6GkUowawGv1VSIYrDQHyiDuNOjYQN70bcW+aScjet2KCUe95CRsMSaXS?=
 =?us-ascii?Q?s/FYw4YoMtNoGxZknXrqpTrIEBt7eZcrKwpG0JI/XozUqpc7wTzuDdeVh4t3?=
 =?us-ascii?Q?+hPaJFBj0W1VwWFRNAjxGKuU2hlXbY1VP8KhpcZHJ+WtTb1xWfef9pQG0oUY?=
 =?us-ascii?Q?N6yz++c4zUwbdQFjjl8xKZ2rqwq4KDckti859B2n3Iz60hOchwbXYf86ggTm?=
 =?us-ascii?Q?6a+ip4MrjISymm/Svak0zrGO2nNarYO4rPC/b06eDg8efEE/OMWE/W4MmRRb?=
 =?us-ascii?Q?k/rJvj0OXETu/mHTwbycBQkm/BURGan50VcJeZBkkDzDZAgOIT1EwGsAMbed?=
 =?us-ascii?Q?BJxadRPpaHxMHAp6CKVpzi+9NZ0EcJhchSfploYUG0mIVojDKFK6w/Uamhxl?=
 =?us-ascii?Q?cHnk40J+UtrG1WPnHlIZUOI1MxDb89yocGastwPYoyKYA2lOpx2zGonjGYCn?=
 =?us-ascii?Q?6XVmUqXTmt9I9b2WTlDYBqdgnjr7CUcYotf3gcbYDwvzfpJ0QHUlYlV19+Q+?=
 =?us-ascii?Q?H7Lsqc/GTfXgxQnhbAnMO37+FjtoVd2Fc1pF5lFego+RmDjrO512lHkVoDi6?=
 =?us-ascii?Q?VBUDyA0eULtgg8pHoZRZ6Wx0i4YcRNSueoE/EtBiKroAdsV3s93/uZGUBYro?=
 =?us-ascii?Q?HSwllM9Tn+WIcKms+HmHmlUFnsGKjGxYTfBde5Fy48Kf8yVmTgpQ21R9m42U?=
 =?us-ascii?Q?gr7zjblt1qqOthA843E3SfOpbCnEFdGQlUDFfK/MSK+rLqjcB9/Nn7vr1oOa?=
 =?us-ascii?Q?pALx04jT46kyrKSDdSbGeTzNOIpx7qk9gm4+FamA0AyABZQnjhi7yLIce28e?=
 =?us-ascii?Q?xaRjB6jTL9JRII/x6A+Gsi1SGjsaWouGcPJZ8OJYrY9Au0vVeC9BdqfjARHg?=
 =?us-ascii?Q?0lXex5b+KM0SfXc2BJ4iBYRUkAWWL/NRuxH3C81rce5Cq80HsCh8RRuyk7Fn?=
 =?us-ascii?Q?aMwTP6rzKW006Zs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?306XJxtg03ZFaNhJdr/C590Cx/+B87nk/QDfulf9BY9fgeRAzaV46ZA+tWGx?=
 =?us-ascii?Q?eONzPajyY7h9h72AdFRtOfVaOZ62pFBljq1AtooYcj6PD/+DEtaUC9qqVMYL?=
 =?us-ascii?Q?uOpJNmIfde3n0V+uaq2CQjLyqVwbm+94Aku3luIw64CvKkQ98tW4jFKT1oiY?=
 =?us-ascii?Q?mcaY6w5m+U0Znn1svAcEfHG6iuXQJdsDBo2W/TNnPHJPhflWopBwaaX4j97T?=
 =?us-ascii?Q?6TNMdhag0pqRVVX10zZ7zNyQKxVRFLDlluWfaPjs2NyTkr0vptS3AH8f6y+K?=
 =?us-ascii?Q?aPl+BZrHT4qblpvcUYeRXFDUD8DcKSq+CK8r1q0MdltJL4C6DbPVg4PVaeNI?=
 =?us-ascii?Q?UMRdBimqjABcpyI4T+YHDAuxVQCKTJsHgrlx+/guPCioXmllDYgwMS1+oDOs?=
 =?us-ascii?Q?3QaG7+D6LAfwT1wksiwk9hHafqPZzrrjQUwqkcqVu0mYjXTc7nWlxdf65vE+?=
 =?us-ascii?Q?Im+lttIPIr38WORCD7L2AJZTeQgYim+DONfvyPnPPZI9RLdbagfLsInr2zT4?=
 =?us-ascii?Q?fhWI+GNvbMbnzThXLxWmch4xTqkM9zN/A1ZS0hTT3/dhXC3GUQdaq6i8P381?=
 =?us-ascii?Q?7OD5TchLunpOOnZJkTPwRke52js5CfdX9HqhUedLzRRqmfzDUbb63+uV9yhB?=
 =?us-ascii?Q?t2iKI1n0+bVhfxI86Yga/zJlD7it64Ff90yVDGeIxGEzjmoYEH8Qse7FF82U?=
 =?us-ascii?Q?LjZT4wgHMuzzDc3Ufwl5AIBZjhH+/0OMV/C3bkXuRyJO0GAhKt1J4HrepL8V?=
 =?us-ascii?Q?kX3F4+yRM7dPauLlY393FDq8/4pFw+EgJ1VpWXPMFoh8BSOXjlAPfvEjdDXz?=
 =?us-ascii?Q?12woDThg965S7bj2b8uz5UeqB0nHPnOCb6HeQCZK1/jwf6TkzdSa2T/ImDeT?=
 =?us-ascii?Q?zA1X03c5v82wAQ9ULu9p0LxAr7LAAD/NlPQqLYAOLdcGq/1xjtL1nzlpgOMX?=
 =?us-ascii?Q?D1TgRM9xzmCTWcVORA6zBQtELkKxt3JWO59MAmq/glHJQm6cPerXDENECSda?=
 =?us-ascii?Q?j6LBC5RDJrTkhZ5x1MAYN1fSPI4wLQ1pj+sJK6iux9x7706Dbi94RMV1lGQO?=
 =?us-ascii?Q?/1+khz7Joci0VeOQkdkIiduiKKe9S+0QC429EFDKEP/FZJ4awnZfAg6qSHJU?=
 =?us-ascii?Q?/78GeVLL6Kt4p9R38lkxB/uadHMW8A9hSP9o4u9d/q2jwVFCjN3doKdiNZPr?=
 =?us-ascii?Q?PNroINy3YVfZ2FBOuCK7UecCXa1tC6UsDe7jeEPiX+4RvMP+7BTgEDi7L7D5?=
 =?us-ascii?Q?8hpwIBWqVIfAcZr6PQ/vRxzwQaWcUYPB42b7rAs3GYlicFQbKuxEMIPxd1mE?=
 =?us-ascii?Q?m16zzqIihzJiFsYuTYX9EIYUHjOJsVZCERSrELfmPHPKGBruOi0GqOHZml8N?=
 =?us-ascii?Q?8K76WCjgIsQfx5WLlEOvfLxKwMrHv97UywM9+ThDA6t41w6KM8JIPCxcjuGi?=
 =?us-ascii?Q?QyeT5TYuNqGjn6NkakIAO8hnxjj1iskMhzv//H+guAQZINHx+E+P0UWcnYuf?=
 =?us-ascii?Q?mTHsQEWGxMjuMNj2OIw94WZaV6Wmpik5O3ja7FUNBSSQ85BSZPcIQLO2ojAH?=
 =?us-ascii?Q?/0uys+93cR7tj6AwpfY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd4b761-85a5-446a-37da-08de2915c967
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:08.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOO2uZqGOQhoOtCaOnd/oi4z374VOmODQWTPRf0vUP6wwTleh9rmLppRseMNRYDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Once a DMABUF is revoked the domain will be unmapped under the pages
mutex. Double unmapping will trigger a WARN, and mapping while revoked
will fail.

Check for revoked DMABUFs along all the map and unmap paths to resolve
this. Ensure that map/unmap is always done under the pages mutex so it is
synchronized with the revoke notifier.

If a revoke happens between allocating the iopt_pages and the population
to a domain then the population will succeed, and leave things unmapped as
though revoke had happened immediately after.

Currently there is no way to repopulate the domains. Userspace is expected
to know if it is going to do something that would trigger revoke (eg if it
is about to do a FLR) then it should go and remove the DMABUF mappings
before and put the back after. The revoke is only to protect the kernel
from mis-behaving userspace.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 11 +++++-
 drivers/iommu/iommufd/io_pagetable.h |  8 +++++
 drivers/iommu/iommufd/pages.c        | 54 +++++++++++++++++-----------
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index b3cf3825a88c7f..38c5fdc6c82128 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -970,9 +970,14 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 				WARN_ON(!area->storage_domain);
 			if (area->storage_domain == domain)
 				area->storage_domain = storage_domain;
+			if (iopt_is_dmabuf(pages)) {
+				if (!iopt_dmabuf_revoked(pages))
+					iopt_area_unmap_domain(area, domain);
+			}
 			mutex_unlock(&pages->mutex);
 
-			iopt_area_unmap_domain(area, domain);
+			if (!iopt_is_dmabuf(pages))
+				iopt_area_unmap_domain(area, domain);
 		}
 		return;
 	}
@@ -1261,6 +1266,10 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
 	if (!pages || area->prevent_access)
 		return -EBUSY;
 
+	/* Maintaining the domains_itree below is a bit complicated */
+	if (iopt_is_dmabuf(pages))
+		return -EOPNOTSUPP;
+
 	if (new_start & (alignment - 1) ||
 	    iopt_area_start_byte(area, new_start) & (alignment - 1))
 		return -EINVAL;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 08b6bfb6b14489..892daf4b1f1eea 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -238,6 +238,14 @@ static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
 	return pages->type == IOPT_ADDRESS_DMABUF;
 }
 
+static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
+{
+	lockdep_assert_held(&pages->mutex);
+	if (iopt_is_dmabuf(pages))
+		return pages->dmabuf.phys.len == 0;
+	return false;
+}
+
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 89a5c999e3a2d4..e8bfd734fb695b 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1650,6 +1650,9 @@ void iopt_area_unmap_domain(struct iopt_area *area, struct iommu_domain *domain)
 void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 			     struct iommu_domain *domain)
 {
+	if (iopt_dmabuf_revoked(pages))
+		return;
+
 	__iopt_area_unfill_domain(area, pages, domain,
 				  iopt_area_last_index(area));
 }
@@ -1670,6 +1673,9 @@ int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
 
 	lockdep_assert_held(&area->pages->mutex);
 
+	if (iopt_dmabuf_revoked(area->pages))
+		return 0;
+
 	rc = pfn_reader_first(&pfns, area->pages, iopt_area_index(area),
 			      iopt_area_last_index(area));
 	if (rc)
@@ -1729,33 +1735,38 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		return 0;
 
 	mutex_lock(&pages->mutex);
-	rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
-			      iopt_area_last_index(area));
-	if (rc)
-		goto out_unlock;
+	if (!iopt_dmabuf_revoked(pages)) {
+		rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
+				      iopt_area_last_index(area));
+		if (rc)
+			goto out_unlock;
 
-	while (!pfn_reader_done(&pfns)) {
-		done_first_end_index = pfns.batch_end_index;
-		done_all_end_index = pfns.batch_start_index;
-		xa_for_each(&area->iopt->domains, index, domain) {
-			rc = batch_to_domain(&pfns.batch, domain, area,
-					     pfns.batch_start_index);
+		while (!pfn_reader_done(&pfns)) {
+			done_first_end_index = pfns.batch_end_index;
+			done_all_end_index = pfns.batch_start_index;
+			xa_for_each(&area->iopt->domains, index, domain) {
+				rc = batch_to_domain(&pfns.batch, domain, area,
+						     pfns.batch_start_index);
+				if (rc)
+					goto out_unmap;
+			}
+			done_all_end_index = done_first_end_index;
+
+			rc = pfn_reader_next(&pfns);
 			if (rc)
 				goto out_unmap;
 		}
-		done_all_end_index = done_first_end_index;
-
-		rc = pfn_reader_next(&pfns);
+		rc = pfn_reader_update_pinned(&pfns);
 		if (rc)
 			goto out_unmap;
+
+		pfn_reader_destroy(&pfns);
 	}
-	rc = pfn_reader_update_pinned(&pfns);
-	if (rc)
-		goto out_unmap;
 
 	area->storage_domain = xa_load(&area->iopt->domains, 0);
 	interval_tree_insert(&area->pages_node, &pages->domains_itree);
-	goto out_destroy;
+	mutex_unlock(&pages->mutex);
+	return 0;
 
 out_unmap:
 	pfn_reader_release_pins(&pfns);
@@ -1782,7 +1793,6 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 							end_index);
 		}
 	}
-out_destroy:
 	pfn_reader_destroy(&pfns);
 out_unlock:
 	mutex_unlock(&pages->mutex);
@@ -1809,11 +1819,15 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 	if (!area->storage_domain)
 		goto out_unlock;
 
-	xa_for_each(&iopt->domains, index, domain)
-		if (domain != area->storage_domain)
+	xa_for_each(&iopt->domains, index, domain) {
+		if (domain == area->storage_domain)
+			continue;
+
+		if (!iopt_dmabuf_revoked(pages))
 			iopt_area_unmap_domain_range(
 				area, domain, iopt_area_index(area),
 				iopt_area_last_index(area));
+	}
 
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
 		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
-- 
2.43.0


