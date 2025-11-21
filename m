Return-Path: <linux-kselftest+bounces-46251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9CC7AA29
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F2D3A1872
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F634A3D8;
	Fri, 21 Nov 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzhokqfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5A34252C;
	Fri, 21 Nov 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740282; cv=fail; b=gvDvVwmPGSyZtIKQqpzUj42pSBQSmxDGsGJs3yC9zUlCJ+bl7k8UvKk38van3PFPhX21EXHrtEX5ncdIYrNKE8ooceo+REs6VN+W/G+qxSbjr+fjUaBYmWmHljGncdPtglxRI1DHRbbejruurh1MKn190jfUc+fK4Uc9FydAoh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740282; c=relaxed/simple;
	bh=UqrxR0LO1bli339dy59280zcbLVtC88UTvz3mmeeKg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvJeOM9DSl37Vaz1dGHmDJ3+SS9lqLnqaf2My1iteZjJeVg9KvFptXSc6zM0h0AN9123syM/wgXHvs7tOBNQcFrwqZKOet2bY/g7DwCMOBV+OeY72AXzjSkQOJwR+wpEVc5xhp83JUnRUNoV8vFbdLbGahtppa5D6ZnC60GBytM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzhokqfe; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOqjMBLvLaJk7KZZ+D/LxMi4YTiBPCQM99Gp4uBD1KWCydkc0Po8rO6bP/53rTnM52HogFrAzFxZlX+gV6Bcnvm/g5KTUtrP/lqG9csw2MwcoDI62ZNqA3giYX8tjxazC1YZKDbvYf7YK5i6uksafdW05VAXd/2rdljaeZ8YG9X44UT7wT5Fyzfo47OAu91TBMTkldUxIbrlFD665fayk0i9QVcKj2Wx3oPMkYRfYtZG57HsFoBIjlpXMZ/BUGrvWd4w5rdRTQjoLSunZA/5fInSdssGu8kYniZvZsdQHy6XaNfcFxjXy8cCK9B8wsy1yrfo22HlcxVY0ixwSA+lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwKkT1sEgtWjwoRJ2cfJAZdw7wPgNh+AEzscznfY3vM=;
 b=geHNBgEQ9Lmovw3DGhltE7Ej6V+9Gldjkuz8j1/uor3p6Sl8vuhbB5RiAMpENBCJgXBprOWHfQV8Nlib7/cIz9+J5Z5Tk3x9RdGlm5OWlk8x+cjT6DrN92pBQmSb6k1M8OJmVAGO+603TVDutzT6h/C/SU5WJBMuJu/ur9NcYOzQVYvJbBveRCo9eHeQPEmt51BC9ru3ZHQxLrpfj97OVJqyYahDtHAyO1NoQWNBZSIqIjPiy9ZhpdENSgTeM4y9JKRN1j+BVf0ahee0tdqCXHbA17xCiqci6sRJUnCzZvOIIsXztvzf0podrMib2Q3ODSLir9/Lh1PrCb4ONbdg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwKkT1sEgtWjwoRJ2cfJAZdw7wPgNh+AEzscznfY3vM=;
 b=pzhokqfeu/P9Br8f5oNCT9taZfd3za0xKJgW562AAMYiL2sDSjg1JIYveS3W3akpJrr0DW6FI3xfi7fMNWIYFw+mOT+5O431Lq6HZAWPVOoWBB5ZeFqiL+p2lWYJ9IyG8P+AQ5/GacDX9piCicwJJLqMski6xQKbOYHdwn1cA+1S+Ekg+d1AJRHUNxK8YDW7I7PU51E39WAD6nHbHeSs3bvrt2Mt1y/tn7Qyr0ezddceTAJ4ZEQ9N3RKSrXyVf+uED+DbV9qeQCl0zcbltg7d1vpq7EP37JTuxq1JnWoprMXMfjHEQFZSYj8tt+Hsanz1FMJCQgWwoVEM4WYA7kSFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:09 +0000
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
Subject: [PATCH v2 4/9] iommufd: Allow a DMABUF to be revoked
Date: Fri, 21 Nov 2025 11:51:01 -0400
Message-ID: <4-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DFF.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1e) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6670dc8b-0098-40da-ad1e-08de2915c956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIQwHA27gUTdaDt5p4h8j7tr4KL4e9eayCakb04BWQbWqFyEsXHSXtKoh68D?=
 =?us-ascii?Q?W1KYV3fDubatbfXEbp/QnI/ywsoEKJSSo89YBYwL/B/8Xhv6mh52dDOKuwvn?=
 =?us-ascii?Q?ZsH7KdhHGX8wqNJf97ehWP9YByMC4y7uTejjw0Vpc5reTly3d4jdQp0P7PeG?=
 =?us-ascii?Q?RiflSFO01w4mi9y7SEKFGrsbcA/DNCawOtZFpckvMPtMlB7ljx/sReLxOaUz?=
 =?us-ascii?Q?HVaZN6aezhbQ+MdagcsCF6weUFwPjzJEVdBvUqdi6W/8SiT6HkdVgMTTJYmx?=
 =?us-ascii?Q?X2bwoFDZblZyw8KmVCtYo59vj6c8+5RHrby22fN9A7yh00xDN/5+SSfv/vIL?=
 =?us-ascii?Q?as6HTZrGI/u4jDXZa/WEgiAa6Uduhq1eRL0Ig9a82WqaXtUWQQ/zoDD6h8cv?=
 =?us-ascii?Q?8KDGL5dT+iJdj5mpNq0qiuQl1PylF9MTOmZ6OX5IbFjIWEI5ltCDVZT8MnF0?=
 =?us-ascii?Q?A4M1Lpa0p1szlB3h4V7UrR5sacb3Gp+kAmy/wozdanxv/Kgf3WkG5IuSxI6P?=
 =?us-ascii?Q?mfTWh+PF7J7ZCVmASwkj940gky0QqUM7H1mlMG/AeKdPVy26lvCzywfad4Rz?=
 =?us-ascii?Q?y2AT3+dDysFHxZZLcwku4Eqj8B1QwIlz2XRAO26d72dnhaLBLxvN9ZCNWROm?=
 =?us-ascii?Q?eXNH77qJntHRNUL9Gs/DfAtVOoUPG/i9Brst4D3kVV+mOqL/itINOyaAGh1M?=
 =?us-ascii?Q?K4l9fLiCvBLdlQd71oG/9+xbWcy7dnn0mhdHfm6YnqUPabwIAtsQFUbsJrRT?=
 =?us-ascii?Q?8/QhKzcRPmEztTr/t8fm+SAi0pkjbJ2pN6zpfE7hknbf/CAB8vNoivHikY6U?=
 =?us-ascii?Q?KChb0HQg48C5eXqKXXrSj1rFAQeEWXFrEnAFMN/KGn5zBaKsLXZcF1Woo3ng?=
 =?us-ascii?Q?tIIYSTUge50/5CrLzk3ChDvSQ2lTzQbc5MsC1xD+U6CYu/jL+PL4qLfj9SFB?=
 =?us-ascii?Q?mw1B0u1bDpmbXXuBBLFtyFP4DdCeDyQ7Vdnpq0XGF3bVguvadClDJAGTiB2L?=
 =?us-ascii?Q?jIDyB4WaeIgNVLgtf9N7ISQOqEwE4DoSPUwWAFNJgg85mOrdVhoru6R4rW2l?=
 =?us-ascii?Q?26fxHf/62lPnDhNZQp/F0moZm95vhst8Qhr8ahZgT0ChqrC5R+ehFi914OjY?=
 =?us-ascii?Q?PpCvbJ3fiX1doIO033y3+YhOvQjHIPNWr0dqlgYvCF4tY5D1yKFUaqom9TnM?=
 =?us-ascii?Q?E0njStCb3QV527xgA9EAFV6IAw/xYqpjBzOhPLuuZu99qPWs19n3eAPP47G0?=
 =?us-ascii?Q?lXgsKbY+ewCaiQSJeRWueMfcXEI0NbA/C5NUn9EcUbX8/fhn+vFaHo0k/Ba9?=
 =?us-ascii?Q?/+zcGIq7iijeUhO7OHSRoCbfBfL3X8gm0LLfh7shk3IPw2caPHDJYPPiJrAk?=
 =?us-ascii?Q?mYWYsjWE/XjypuXDQc+hh1fqvZhcAu1rOPaWqSWujyQJ9EuUVhTO90vxAwcS?=
 =?us-ascii?Q?3cUP4kZTf3GC/IYWxpk980h9qIgRBUr9FuqdAZUMEpuj4YUDpPPpo3i+Z1Zo?=
 =?us-ascii?Q?+eVoq1v4x5CP1Fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Ndv0uDeTLjr7r58YLmZI9mSw9LTDbXmY1a4qRcoOgYAByDDGMjIA/MUIRZp?=
 =?us-ascii?Q?pdlt0Xoju23PYh5OHpxOAuwULhFW9wf7ej8h5XMhmCcCw/K8FvPyOfo8+0Cz?=
 =?us-ascii?Q?bSS9q/hCQh2i12NTd/oubYE3aakhqcbMxNlIFiM0rcMV6e7SD+99iy7X5kWZ?=
 =?us-ascii?Q?6dpJkFBwGcKG31W8rWxN1/cS474bdLOcDXppHAlSvjT5xYP1wn5XlyfI/6GC?=
 =?us-ascii?Q?/zIhMGNsFF2hMKHgu1SW02+dXZYcGGDLFEB/HafARdUyA1IBIWaDgPyNswWa?=
 =?us-ascii?Q?P8rmdkMGQwh1Yg6IVBEwTT4I22+pVSm1wAFBzDUkGppJ2cqKBEGxMq8hPmDH?=
 =?us-ascii?Q?0oVP9SQfKm9o+EpLYtQsAWavDwD/Pq+Zgt8bVg2UxNxW7iVqT1et60zYusiw?=
 =?us-ascii?Q?zquZlt28RPHoaTIEH9mwJYUyXwcJiSE3MDnaKM+j55Q6d3aqkn7esx2dmtv8?=
 =?us-ascii?Q?HEAvGJfYFo1g28SvFkMAzSSCm3s21YW/p0o0mVRNiDHje716C/BnIJlMDD3M?=
 =?us-ascii?Q?SS9RtnEhBcDToGbG6m90N8k+wR0DKB5/I48MH+jCUbVpeYEB4b2h6dVRmg1I?=
 =?us-ascii?Q?iROPceHvrBkrFshYoePPZfBoalP/y1VwIHVXM6/BdfZnYlK3ULCM8uXLawyW?=
 =?us-ascii?Q?Un6ygiDDmQD+z1ecHCQ/QieY2i25Fm1QAyPrp1lppebZlCPKt4p0BlpNhigG?=
 =?us-ascii?Q?JOzurXpt2wa5fT0U/Wky1pwORiIh3YXoQVjF/w3e++pPfe78lnFUcqd9t/Bq?=
 =?us-ascii?Q?LwNDvMaOsfm3wNU6Lzbcnn3h6SHsurFmNLE5ZdYdxaPDqA8zi6mnjbbget9s?=
 =?us-ascii?Q?qkcXWj3sqVBDe2RFvsOl9xBp59y+CHNwIVRkVIGYKUoGcNvo65ZAxebH9m1s?=
 =?us-ascii?Q?4IQYghnxdVsujc2sXn3mNXWQMXyynWCBRqAOTEXlDh9bb7uhJ73/45SfioSJ?=
 =?us-ascii?Q?oA0YcRrRm0ucB9I6gE/jQoh0WWFJ7/bXfSdb/P8bm0+QXRbCMK4fHVytVCnb?=
 =?us-ascii?Q?K/49Z8Rhe6c5B8GTuVyaqKtJYrpEsIIzNteuSJledhlsGpfP/uWLtQS+/rM0?=
 =?us-ascii?Q?okBDxvCe5Mw/ldxME9ywRet2NNq67gA+tPkXR3+Psgts759E+ZZahyibg51T?=
 =?us-ascii?Q?ZJw3vKeuHjBdDN/S89fWAI5dAoat/73/333mcdp8LXF2cX+uYAdnVkNWsBEX?=
 =?us-ascii?Q?GMP7qswXYJKkLI5b8qy2aFZIzuMHDMjAj++fI5qF0sQa1+gr/RI61tKBpjes?=
 =?us-ascii?Q?EjgSHkL69d5Q0c+1cZX+MEGIXhoTIZo0cchWQFOTm99hL2jpe2LqaVvILDqC?=
 =?us-ascii?Q?RTrAj4zYLBXAy6yQW6LTUfZzKLeFGZ/bAe39EcKHGUiuOXbG+lGl++KrUu2K?=
 =?us-ascii?Q?zAG6h4VJrNc/hxe1AEkazI5TBD/mNG1p2ctvRXYBvOP0hRTHvhuL5k9WDlkL?=
 =?us-ascii?Q?spFSGHSTqexbMzcKS5JF66NHH8gm+AiuU/w7TT+xGlWJDPoAum4dK8v4GD+k?=
 =?us-ascii?Q?88Cy+UNTvJyXzqyJvL9xPfjqsIuuOfoDCTFrR39PYv7xAsf8OQDEJ6USSEtM?=
 =?us-ascii?Q?peYk3Gpqy9ceU/0WiGo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6670dc8b-0098-40da-ad1e-08de2915c956
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:08.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Fjaao8HyCHdGP60WnEP3xKgzsXHUKYH7e1Dm+zveLexATT36LknXeeKtceN1FXP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

When connected to VFIO, the only DMABUF exporter that is accepted, the
move_notify callback will be made when VFIO wants to remove access to the
MMIO. This is being called revoke.

Wire up revoke to go through all the iommu_domain's that have mapped the
DMABUF and unmap them.

The locking here is unpleasant, since the existing locking scheme was
designed to come from the iopt through the area to the pages we cannot use
pages as starting point for the locking. There is no way to obtain the
domains_rwsem before obtaining the pages mutex to reliably use the
existing domains_itree.

Solve this problem by adding a new tracking structure just for DMABUF
revoke. Record a linked list of areas and domains inside the pages
mutex. Clean the entries on the list during revoke. The map/unmaps are now
all done under a pages mutex while updating the tracking linked list so
nothing can get out of sync. Only one lock is required for revoke
processing.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c |  16 +++-
 drivers/iommu/iommufd/io_pagetable.h |  17 +++++
 drivers/iommu/iommufd/pages.c        | 106 ++++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 38c5fdc6c82128..a120c2ae942a8b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -973,6 +973,7 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 			if (iopt_is_dmabuf(pages)) {
 				if (!iopt_dmabuf_revoked(pages))
 					iopt_area_unmap_domain(area, domain);
+				iopt_dmabuf_untrack_domain(pages, area, domain);
 			}
 			mutex_unlock(&pages->mutex);
 
@@ -994,6 +995,8 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 		WARN_ON(area->storage_domain != domain);
 		area->storage_domain = NULL;
 		iopt_area_unfill_domain(area, pages, domain);
+		if (iopt_is_dmabuf(pages))
+			iopt_dmabuf_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 }
@@ -1023,10 +1026,16 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 		if (!pages)
 			continue;
 
-		mutex_lock(&pages->mutex);
+		guard(mutex)(&pages->mutex);
+		if (iopt_is_dmabuf(pages)) {
+			rc = iopt_dmabuf_track_domain(pages, area, domain);
+			if (rc)
+				goto out_unfill;
+		}
 		rc = iopt_area_fill_domain(area, domain);
 		if (rc) {
-			mutex_unlock(&pages->mutex);
+			if (iopt_is_dmabuf(pages))
+				iopt_dmabuf_untrack_domain(pages, area, domain);
 			goto out_unfill;
 		}
 		if (!area->storage_domain) {
@@ -1035,7 +1044,6 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			interval_tree_insert(&area->pages_node,
 					     &pages->domains_itree);
 		}
-		mutex_unlock(&pages->mutex);
 	}
 	return 0;
 
@@ -1056,6 +1064,8 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			area->storage_domain = NULL;
 		}
 		iopt_area_unfill_domain(area, pages, domain);
+		if (iopt_is_dmabuf(pages))
+			iopt_dmabuf_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 	return rc;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 892daf4b1f1eea..8f8d583e024376 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -70,6 +70,16 @@ void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 void iopt_area_unmap_domain(struct iopt_area *area,
 			    struct iommu_domain *domain);
 
+int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			     struct iommu_domain *domain);
+void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
+				struct iopt_area *area,
+				struct iommu_domain *domain);
+int iopt_dmabuf_track_all_domains(struct iopt_area *area,
+				  struct iopt_pages *pages);
+void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
+				     struct iopt_pages *pages);
+
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
 	return area->pages_node.start;
@@ -184,11 +194,18 @@ enum iopt_address_type {
 	IOPT_ADDRESS_DMABUF,
 };
 
+struct iopt_pages_dmabuf_track {
+	struct iommu_domain *domain;
+	struct iopt_area *area;
+	struct list_head elm;
+};
+
 struct iopt_pages_dmabuf {
 	struct dma_buf_attachment *attach;
 	struct dma_buf_phys_vec phys;
 	/* Always PAGE_SIZE aligned */
 	unsigned long start;
+	struct list_head tracker;
 };
 
 /*
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index e8bfd734fb695b..a6c874d5eda8f4 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1366,8 +1366,19 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 static void iopt_revoke_notify(struct dma_buf_attachment *attach)
 {
 	struct iopt_pages *pages = attach->importer_priv;
+	struct iopt_pages_dmabuf_track *track;
 
 	guard(mutex)(&pages->mutex);
+	if (iopt_dmabuf_revoked(pages))
+		return;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+		struct iopt_area *area = track->area;
+
+		iopt_area_unmap_domain_range(area, track->domain,
+					     iopt_area_index(area),
+					     iopt_area_last_index(area));
+	}
 	pages->dmabuf.phys.len = 0;
 }
 
@@ -1468,6 +1479,7 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
 	pages->type = IOPT_ADDRESS_DMABUF;
 	pages->dmabuf.start = start - start_byte;
+	INIT_LIST_HEAD(&pages->dmabuf.tracker);
 
 	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
 	if (rc) {
@@ -1478,6 +1490,86 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	return pages;
 }
 
+int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			     struct iommu_domain *domain)
+{
+	struct iopt_pages_dmabuf_track *track;
+
+	lockdep_assert_held(&pages->mutex);
+	if (WARN_ON(!iopt_is_dmabuf(pages)))
+		return -EINVAL;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+		if (WARN_ON(track->domain == domain && track->area == area))
+			return -EINVAL;
+
+	track = kzalloc(sizeof(*track), GFP_KERNEL);
+	if (!track)
+		return -ENOMEM;
+	track->domain = domain;
+	track->area = area;
+	list_add_tail(&track->elm, &pages->dmabuf.tracker);
+
+	return 0;
+}
+
+void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
+				struct iopt_area *area,
+				struct iommu_domain *domain)
+{
+	struct iopt_pages_dmabuf_track *track;
+
+	lockdep_assert_held(&pages->mutex);
+	WARN_ON(!iopt_is_dmabuf(pages));
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+		if (track->domain == domain && track->area == area) {
+			list_del(&track->elm);
+			kfree(track);
+			return;
+		}
+	}
+	WARN_ON(true);
+}
+
+int iopt_dmabuf_track_all_domains(struct iopt_area *area,
+				  struct iopt_pages *pages)
+{
+	struct iopt_pages_dmabuf_track *track;
+	struct iommu_domain *domain;
+	unsigned long index;
+	int rc;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+		if (WARN_ON(track->area == area))
+			return -EINVAL;
+
+	xa_for_each(&area->iopt->domains, index, domain) {
+		rc = iopt_dmabuf_track_domain(pages, area, domain);
+		if (rc)
+			goto err_untrack;
+	}
+	return 0;
+err_untrack:
+	iopt_dmabuf_untrack_all_domains(area, pages);
+	return rc;
+}
+
+void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
+				     struct iopt_pages *pages)
+{
+	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_dmabuf_track *tmp;
+
+	list_for_each_entry_safe(track, tmp, &pages->dmabuf.tracker,
+				 elm) {
+		if (track->area == area) {
+			list_del(&track->elm);
+			kfree(track);
+		}
+	}
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1495,6 +1587,7 @@ void iopt_release_pages(struct kref *kref)
 
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
+		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
@@ -1735,11 +1828,17 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		return 0;
 
 	mutex_lock(&pages->mutex);
+	if (iopt_is_dmabuf(pages)) {
+		rc = iopt_dmabuf_track_all_domains(area, pages);
+		if (rc)
+			goto out_unlock;
+	}
+
 	if (!iopt_dmabuf_revoked(pages)) {
 		rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
 				      iopt_area_last_index(area));
 		if (rc)
-			goto out_unlock;
+			goto out_untrack;
 
 		while (!pfn_reader_done(&pfns)) {
 			done_first_end_index = pfns.batch_end_index;
@@ -1794,6 +1893,9 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		}
 	}
 	pfn_reader_destroy(&pfns);
+out_untrack:
+	if (iopt_is_dmabuf(pages))
+		iopt_dmabuf_untrack_all_domains(area, pages);
 out_unlock:
 	mutex_unlock(&pages->mutex);
 	return rc;
@@ -1833,6 +1935,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
 	interval_tree_remove(&area->pages_node, &pages->domains_itree);
 	iopt_area_unfill_domain(area, pages, area->storage_domain);
+	if (iopt_is_dmabuf(pages))
+		iopt_dmabuf_untrack_all_domains(area, pages);
 	area->storage_domain = NULL;
 out_unlock:
 	mutex_unlock(&pages->mutex);
-- 
2.43.0


