Return-Path: <linux-kselftest+bounces-45125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06FC40EAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01B81893EA4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365693328EA;
	Fri,  7 Nov 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cUM2S5aj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F302D8DCA;
	Fri,  7 Nov 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534188; cv=fail; b=HMqqAkHCMQu9RX7lZjtLipr65PJ3g2rO+8KR3VdXpzR8p1sjFtmBaxuzMNMJh4zYzxSvFs2t80J6lHVQPIgcBMl1tfEJT1FfsNKwhYlIBpyEFH3npLxM0REZDniwZU3kk16i6wYBFGH2iweVX77ureLXH3HSoAWuO4GUaRLtVzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534188; c=relaxed/simple;
	bh=dOk9ZdwKNxhdEtU+tppQAuNLhaHcHyPCv4npmP6Fed8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVgHgxbrFeasVMTi2I5VOTNzi5XCv4aaPlTW69Z5wnmGgWtqSZ2vgzCZEDAMJltTiAvKZ7L3I6JKvH81K8Y/3NqcC4RGcx94AE2Z5/WSlE+oZ2/k+9/C44kN0ekg169l/JjdCCCnmeMAQnZpVZDmeNElU+B5YFDtj0aJy7dlAWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cUM2S5aj; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9VidxLakHsXczs971TI17t8BN9hzOOYz9TiU00az3+ymevXmEajBuYiSPJ/hXqB9iKiAJn/8uK6QNKG63ZQu54TGzUtiIkI6pVjuBMgnHxDzU4bF/+6nzO4Vlh/ljj6c5qBg/orrrJ2W0qqtLQicGTLvIeLNs67ee5arbUqbr7jdHNZT1GNEv+7LNeD8U6TWIBTlB30wNZofoaSQ0ALZ/Gf19iBGzBJyxGSiWfyIqkuXgp0FcRjqTjk5dK4bFb5VhuUt9PBAVH5Tu5E7KrDapm1IQxGACZYUJtMWjdG7SoW2UAfZpZAbYcPQci1KAp/Jk+mpsGARh4KMC4x/CbkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCJScaiBCAbo2oGIwuBN9UHTdG/W3o5CmefDhOkbwN0=;
 b=VZenyy/MXvr2F8SS8St9A2OYyX1dWgJV97O1TkVsgmRl+DJA81Tvu3cNQuoMSG11egbGn7mrYOBYtTRvMyvWbXIce4DZVYtV1wm9HduT7mgpHvrNmlaFFt0txH7hWWOECoG3IoIqNgPW94BEcOFoJRmTguuKZPgPe3bEK1Zy78J9/B73xrtQDp0jPW5a5u6F2QRvi9Ft3zDgH6bw/9DkLB1lPKoT+EsUz2x+Rnfbr84+6DB3OO+rg3gat0174pCl/r0jL0rVwCNPGuzOZyN7jflFnD1feZFDs7rhSQXEqd155Qhw4TC127NsH1QLkfg/lgDNpMlffVtCisJzSZTw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCJScaiBCAbo2oGIwuBN9UHTdG/W3o5CmefDhOkbwN0=;
 b=cUM2S5ajdVEqVsZppxr7Tfu40PAoprRPwuCDiFvU/zukZAYZtJ3IqU52ykCPPxFzyrPO0Aw5tqI1OWpoxV2qi0/LRj5qWmzPhtFm8u+7lHguZq4BOJOinUH0Kz3zm29TRok0I2KUPGeMgVcKLnTmE9tiNC73C/WRyjeY2B73AF1H8JjPYBzIqHpeJzCpNfBVP0nwZi8vwgS7wEgfPgtljv+l+c6Xpg7U1b+A8pUPotmK2Ly6xkXQlAN2VxGWcq3teBKoHSxH6gOF/lJ7YXYUl0JTS0zp+6aK3/7ouuFOHSuaD1tet6I+ZHDCjMTbWqKByBI14DgpT3mI90lXYZKDNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:42 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 3/9] iommufd: Do not map/unmap revoked DMABUFs
Date: Fri,  7 Nov 2025 12:49:35 -0400
Message-ID: <3-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f91793-1574-4b88-d0c8-08de1e1da5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCE5yrYinmkQw9TOBv8NZwxoSsHxhEQQXUasHaSJAh5qoFb/dbacSj/fCKSG?=
 =?us-ascii?Q?G6BtdAB6mIf9fmwO5BRpeT7why3QjQYrLxHK12b6i9BwnyJbhtkl5P6J9rTZ?=
 =?us-ascii?Q?HKGt5/sRq0uSamCPxpiuueKstCEzF9+V/q2Na3wYOtgI1sJWvwMjaCCyj7fs?=
 =?us-ascii?Q?dFgBeqOHJIFURUvQQvLXu628e3xJZhovqBbOTwkD0fnyP6xt3LBW1/QCjUWv?=
 =?us-ascii?Q?+9qb041y6bIuygGvRE4YT9gbH++emsTWIAUhWKo0sQ40tyePS1gFHedffQUP?=
 =?us-ascii?Q?TH8afrGu51FmCq4+09aOUOFbo9S5JmH/UZ+ghjk8K7ZhrQE901YV/vjl1vv2?=
 =?us-ascii?Q?XKF54l3gLb/8VHcj4t0FvJCH4ssOk8UxG91uKnJE7HgwEXuCW7m49wLI5qja?=
 =?us-ascii?Q?GnVpaaQYbMk8aezOi2T151w2i8xYbACPVQaJlLqT5Wt6Qr0CzuSomLoNsMiq?=
 =?us-ascii?Q?Ewfckxwgc5WNr2KL3OkiMO701qmg73HYmYu2EjbeUP9QUpLWJGqIE64kj80Y?=
 =?us-ascii?Q?er5XcAfj33nlzXbVYobQdKAYdK6ExVTCS7KgE3+pM6oHpWLWj/DPcDF1E09g?=
 =?us-ascii?Q?KTxiF+OF3A9NaGurt2DUYwLd48PXgezRjOHcABfadDgkKiliAjOX8+zBzzmd?=
 =?us-ascii?Q?g7UfGrSo+TQPjHt3PEnyYQeolMZwCtsUyJCWnbM8cKcNtvTkc82uvnya+kw4?=
 =?us-ascii?Q?5Owl0JIK8UvvmFw+U5RcHQ2PLG2EUn+zA4bjdZ8WI2/YurE/53nh2r3z+sWT?=
 =?us-ascii?Q?yHDvqKlEjxy2KcehYgjlc15YP+kotbXCHakLDZgxJDCUSMVQ4v1KzKEWxnpj?=
 =?us-ascii?Q?V1SpqPy1dIrmg/TbG/VQkVJwttZSsjlQfV+2QKnaDffaIzVGc++OfTHKbR9k?=
 =?us-ascii?Q?qoO+yF/IQeRVRQAoNcwtZNWzHyweLaoNsAO4YgAzL/IjiLoedGUCgyIVPnAp?=
 =?us-ascii?Q?DWD1EIFieORywNN00f5ctoVXlEth24vOQkNSwYQwMxIL6DQXoY/hYfMt62tM?=
 =?us-ascii?Q?2ZC0Bbue8Z/orfguUe/G6fxpDYr5cxD0wjgkOg67YgyWHTAM3l5Nny90Vzac?=
 =?us-ascii?Q?Qlfx/ErbkPU2qEJ1nJ6rJTqg9k99cqn6HOlxJPbMAJkISTpxFXBYiW9gbmID?=
 =?us-ascii?Q?Xm3R1EGiTl7dlf0FXk8CYgHdFOdTF+zylJ0yDLRTvDdKQqgaAYlIRB0khq8h?=
 =?us-ascii?Q?Rfp9140jJCItuc6pZ+bgIZbp/8TRpoFdWUuakgM0OxMkHPxJ+Ml6AJULCk8D?=
 =?us-ascii?Q?OikU3hhyg+/fyekctr1mF6gXDY3/wRLUfHx8izpW12S2a4ybc64MdZMR2614?=
 =?us-ascii?Q?BB9wEmBaNe7ABRZyj3mL/CSPNbFU09HPo4ZsH9BfR46RG4Y4SQvfsIyc83re?=
 =?us-ascii?Q?nwN8+yEWC2v8uwGq/F3h6seW24/uCYyVSTr0dNx6AzATnQdZUhjfnYma2X9/?=
 =?us-ascii?Q?IsFCnguclDhLiliWYbzrDYij2/Uc28/UWkJUDcgckkJrL1IP1ELIe5uTOXI2?=
 =?us-ascii?Q?rp23uhk82Ln+4+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jI6onmHMJO957Y2O0+Vl7CaMFDyJL0y8ftIgQIki9IkpDmO2B1v2IuHlMDzb?=
 =?us-ascii?Q?x8BXHRSy+yhLqUFBwdzWn1UwxFEfUHSJKPVeK2dmF4HRGzvuzqpW2zJcA4Qk?=
 =?us-ascii?Q?fZQ1ZTPw4xwLJR4a3pdozkTZmtzNDmgn4NeepoM3m62AIuQ+QowvZ/3MvHCr?=
 =?us-ascii?Q?Wp2sgES2yamW+imZ3ixnQV0pjGHyuuZcS0BUpTh2Ay4PzeHgXBUcEk9SGWpe?=
 =?us-ascii?Q?IyU+hBpfBnP3cMn3O5jWOoCnDgQVZJBabCM5+dmp5sO+wYlQmpKOua85rSu0?=
 =?us-ascii?Q?QqTE0ca0K1Gvl/C7acoPfH4L72edV1+5uFoh/j3dMMIRH5x3X5efly9GC1dx?=
 =?us-ascii?Q?SnRawG80e8x6hAtyR+JgZTgX73Q+OoaBkkmbplMtXWmBv9wNBrysUwTHRJLC?=
 =?us-ascii?Q?LzPqES2NgWKjUj466XkFIGq2LzD3r8moWBuu/MwgLcCTUU+R7j6TDEiBaKEm?=
 =?us-ascii?Q?s7VL6XTzMlWbP9x5zFZeoQ+AlIlzIEGDSBpUVzjNBpQDNTEycZTeRskPhd5j?=
 =?us-ascii?Q?q0MEri3W4z6IYbxjwuozkXuX0X7bW37Fzv9MG6j4Xxc7KWC2+m+tikZGRoYJ?=
 =?us-ascii?Q?orio2x0GXsQypriqfeHStR4qUPtLcpVwhQWf1PJL3zLMOn3iQxUqT8uqQBTy?=
 =?us-ascii?Q?AUK04QaqpBgetTWcHoO59mxfFYGhyzzlEbEigphLBoBtxct/RmQttPzpcunW?=
 =?us-ascii?Q?3o1VkxClQ+R3ji9duWJo2FpqiX0rnKjt6+MFlv0LUXyvY3cPtyMjzc5mjuWE?=
 =?us-ascii?Q?i1ag048pw7xEsNld2xBuDAiPq5CVrkTnGiJw0vY8pR+nTSoSBdZL+trodzIP?=
 =?us-ascii?Q?s3C1+GDT/mZ96bpgTA9dvropDL/BKT1OfBebmj6y6CVoOmT//ywUDfB+fv8u?=
 =?us-ascii?Q?kz0Rwn9ezAkHWA+BxJiScerhLHRE/m1Dgi6ttYRmnuGC2cSXq2GwrbP/KvZe?=
 =?us-ascii?Q?9YrtZMY0miORHPmZTaEobucjgefg3+nz972b4XLD03R1u6A/ye2dMpYLQulF?=
 =?us-ascii?Q?8oZPRjT5LLrgScUwnricln7UzzKioduUH1/ErZV9jZ/U2KoISHCqukD713kY?=
 =?us-ascii?Q?DcE7H8ECjhYwcJFtxUTF4IGQqzEn3ZS5HPcXZX2/ijyRfT9XxyzvJj/rOlHU?=
 =?us-ascii?Q?716N7dd4kDVLSG2GwTpJcLUAx4MXy8R8aTpx9FlnkceeTQBpyitIqUomZrfm?=
 =?us-ascii?Q?UzL82l/3o5IUV7Pug+/4HALOuehhSzQE0StOW5cbwaHSyOt5VlCBcHdQimZ8?=
 =?us-ascii?Q?juiqkuR47YzJsvwIexpm/+yJr06ZOA586PkV7dpTXcPD4SBcFovgodlqOA9u?=
 =?us-ascii?Q?Ue3bOoKbEWJw7mc8Ep75/jXeKfgAsElGfmNO7YfrR7SyHc6di3tV1y0QFebg?=
 =?us-ascii?Q?vzOjnm96SS5p+Ry6hynjKdqVjf2QQrBORObiig8zw4yd2v4d3U43W0ApAKEE?=
 =?us-ascii?Q?ex+2aLCNWk1s5wctYOAzVxzAJfuxKEIpPGbjVR2KmhicMXYlqH2VC/RHZ0Yf?=
 =?us-ascii?Q?FmF0kQngMgLB36mG92bt1mmr3/6pHaNT1b98InzEu9PldMsurOymLqoooQyF?=
 =?us-ascii?Q?TcBwPkdEgTNROVmT3G0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f91793-1574-4b88-d0c8-08de1e1da5ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:41.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssUhZZjZM+sDBfPeFB2cbzozdqE4vFmdxqQamQPtOuraEEWj1S57hBCGbTFbixaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

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
index 389e3c3c80f335..00fe06bf533d62 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -237,6 +237,14 @@ static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
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
index 7bc4731501cc21..2c1a59ab1cc123 100644
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


