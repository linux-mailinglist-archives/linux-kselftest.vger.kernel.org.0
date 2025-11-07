Return-Path: <linux-kselftest+bounces-45132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F2C40F10
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA571893FC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298B332EAE;
	Fri,  7 Nov 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eF/RGHgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66533556F;
	Fri,  7 Nov 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534196; cv=fail; b=ToH2R0/awC5aqtntId4cymsA5eDi5Mqm9r82+9i79pklsomMmL1dL92pespX0Q7TgpypoHBzNL+OUu2rS9kOdvZQzIyZrMJMj6m13zAPSyrGf4TOPjszEDTLkbk+CrVFenUCfJtWQttdTOURHrqGDAzaicKkG2wKiyUvPIjr5Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534196; c=relaxed/simple;
	bh=hX6kL7jZRwPGLp7/R+uIxVsLW+du9UEYRvTQMHdE9Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWvw/vIsMSoFu3jJZ4zhl62hYw5vGq39gnXlIh3tkeb+ggf+RQGf8Kjcf8LUP75R5PTEhCQQ7TX3xkdLiEl1QiZnxmycaIDNJj8p++GR6n1m1M/kLU1/+ucmA1EJR1ZbLzddiWsWH3zyXI4ijn58xTo+ZQYbQs8Pq21T0dqbckA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eF/RGHgm; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jkf9WAPCBHCyqzKyornRk42+JvJypwoetsWyQI8dVVyS610ze6opRVQTD4OvLcM8WB/3gXsqrvdJwuSsNNIEOx9SbUhvh4Avenn5Bru9ohmcql4kGOSx5LTaiKkHUCmCV2/Yux4N0n1ZnHTndRzviDh+TFwVqIJsIUK3NsabjSnC9OqvdTlkviBTMNnRv0ew3sJCSYkkG7KNy8hs0JEu4l3jYvT+X4D8MZZ2pI4tFcMM4S9By1V5Nnzb1mqE0omQnauW1rEsoltVEgD2Z3w6KhvmGK7zUpedKaLphKXz+DcCvp6Yruzi4U7n5l6mvMjQsd9zfucT0KB4ZhYbS98YCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6kHMhFZ64eoQJry/SBondQWArXNkmWIlJ7EMatsq4g=;
 b=NsG943TI5FaBIi5T7pXHWqjRSgFKBkP7va8+HXyXZiRHrwuevBek1BEnbjsrSLZp35++mTyHobU1hYhgobOmyA+ZnenIbIHRmZDw5iXRHwKIeo1Cf6t69feOt1x5YM6TpFs3ssNuw5RpWNthjFfxnpSLRzYJWCD/LyWnnZSpLEEdUqouMoaHdy56vmZRF1tuw06S2XwFzKLf+jNVAc/pM43e7svtbC8omt09h8k/20yFpkdbmtsjTSTwpvmvUMF5K3WR62oc8FMiSaK9/vzsxwuDV3cjW9LyZT1bRd02ZG5+qfo0UQL9xO656OHHGAyk3BfSrdHwyJ2DtP2l65OxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kHMhFZ64eoQJry/SBondQWArXNkmWIlJ7EMatsq4g=;
 b=eF/RGHgmusYZIi/7wyZ3htuZhLB4vLalKT8Kp5upQ2eQgnyEIlsPGz+ARPscJbt7kKTHfe5CiWaS/kBAEFzPUYIzRuEuBkWXmcGdanQZCOHvJz/ErKfFmMtEwLGX7jUJ7S2YDj0bOTzKGVE3ZM4R4gO8EA3ejfIWEoj+G9pRGSV4olejb7FsGi9FlZuffFPWpGisKoAD6nc/V+3DUX1qpUbrKemCNblLFhrpf0Yom+Bw8eU4ldNPADW1NE4mTZusueCJNPSm3u3wBviO/WY4QGT97uAZIT8FmySXxg0rM2ste8XKfvWeo+XCibAKmdAOsgu3QTSVR2rhEIdUhsT3CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:45 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:45 +0000
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
Subject: [PATCH 9/9] iommufd/selftest: Add some tests for the dmabuf flow
Date: Fri,  7 Nov 2025 12:49:41 -0400
Message-ID: <9-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:208:32e::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 591fe821-0644-4787-83b5-08de1e1da73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ap3l9p9xXAoLUvL0pi6FAtWQ+rb6U01qRKWiaIXO5iorUGKszNxr2TzefMT9?=
 =?us-ascii?Q?b+6tIsCaHfprcqSjD6sVPBf1GxJg0v62PY9GN1HBl0yIqXQ3xkePV6uXxNy4?=
 =?us-ascii?Q?QdGCl6YYO3kN5ybmpdug930dfU0vjlRaTus5HW7iUYSvo0Q2jgGx605An3YI?=
 =?us-ascii?Q?T36RVGz+QkRxj514N8Mf0HngeMHhdlB+uE0vowOpRuNDa1u4fOciNojgap2m?=
 =?us-ascii?Q?2eBiUbFYbCvwXBToxsT0J910koiz7NR8qGvkS3NwYLZ9cNsQdkjzDKdF5qwg?=
 =?us-ascii?Q?88d0gqNkdNcDyFO6InyH6F+DvEmkNzKP6OXg9TwQyZcXela4B11WPsfzJTtn?=
 =?us-ascii?Q?z1UJEAovy2DGPpAMHCtjES4a0FRfEw80cNHmc/o6hgTRxdNjbrNcZ9qfYnSb?=
 =?us-ascii?Q?G84ExHD/DO5jzfQ46S12yMr+BBPq5Hea0N1THd9qSFDm3ABC8ZL+sYnOEuML?=
 =?us-ascii?Q?0Mmv2hqZk9RATLe9yMJ/8HkojXarpN1B0DOqBG6Lr0+0tJ+prTUYblrzEbfW?=
 =?us-ascii?Q?gy9bkAfGfGds9Tr1BLpXrM4QyrTTuWl1ZaPrYV8R6vMeHvwFcRlrXRdgmH/D?=
 =?us-ascii?Q?F8GXn/1pC92BUhwUAFwyt79eljKsZN4NHq5pKM3hdvMkwE4lZBsVb+LfYQAg?=
 =?us-ascii?Q?1EExTMnoVAc/MXbIwhVKQKADXj1jICNZ1NHA7RYoyiPtMExEDOBw2XXtavfX?=
 =?us-ascii?Q?rhwLWXDYY6wervpdfV0V3fcoj8D5rg4qcR3Bo+Q5DxVwgTMOe+jPyuIUMUp1?=
 =?us-ascii?Q?LNC4elcvEG9cfEKfJ/Xe/O/8Jwtqv03FkjHmTMfvK/s2fVQHmpoWOoQe+Vfr?=
 =?us-ascii?Q?VdlcbbRtqM8LV7zUDHDL8EpQNesQSYIofXauRSCWdgCAoyWGKItWPT7eiQFm?=
 =?us-ascii?Q?p81a0bu5Fq1HG4bOYNiqg8SeCVntByvusNFTJbFovof7JCYUn8nXpAxB51rT?=
 =?us-ascii?Q?p5LdFuqn3WdwRHt80vdzWFiKsXvNDe3STV6FTLpqXQUie4Y+RGuNlusENYVD?=
 =?us-ascii?Q?61TW1EZwJOqHx1pPPV5gJMBo5mJVi3hXFgGsXe9FI/sgV7vaKBfnSatbP1G8?=
 =?us-ascii?Q?NvPcOaGC6NLLiwv6BKpe9IldgxFgV0yxQCwCDcV+R7ZLrFqLk+Wg/1JCHXje?=
 =?us-ascii?Q?sM7nnsbrN3o4N0lL/pGgNsFTmi7Vr3rdXbClkv1VyMCdaTgzUfjy1mY+gL2p?=
 =?us-ascii?Q?/1I5WVqRJH0XOmnaNKawKuuEyizteXHMY9LDmHAZRhWltRiuqHgJMpGxiaF9?=
 =?us-ascii?Q?FIHV0ZNH+vQbCoNjKKZyxIFp9znO3Ca6j/GS6JRdLWbQuYlX/hDdjdNlzyUx?=
 =?us-ascii?Q?JIYpSkyK4Of7lKCEdqfPB5Xwi82av3ONBmPLsDP0zRWA3n+2wsZnZ53eH2/X?=
 =?us-ascii?Q?ZYJkUS4zYXOdDHFsR6vGHaXq1hzOA+zw2hnft8atnOf/Wsixyo9bGwPNiUOA?=
 =?us-ascii?Q?C1KzcAbDZrLJlYhAp4k0pVsJYz/TNYURhpu2BJg15VqM2UK1wyxDLzCI2Vmn?=
 =?us-ascii?Q?+6JNGhuRSmxlKLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYyEW949PD0quStXSPqamf4MHnFJJ+MPWH1Gr49Y/kcNxVbX5cyOJZUmkYEH?=
 =?us-ascii?Q?yywV610wOo5IXSPsW7AurV/9xu5MUuqTSDfkmJpBRzbC15eb/c+fOboZjVB6?=
 =?us-ascii?Q?ZeqlUMx4PTIsC4WzSZktC5Q0aeXyMZv+QRZT7SbrcNID8dXXu+qF2+kYHwDD?=
 =?us-ascii?Q?1oOwE76NwUB2GsoJleJBdHpR58ry9mtM44//17YtebIky8iVili6nLBeB1l/?=
 =?us-ascii?Q?IZLyV0mAi8tWPri8Q6fEz0IiNhuZl2qPDzZaIyqGRA9XHCarwlah8Ng9mwIX?=
 =?us-ascii?Q?2x9xluDn+lI5FXuoVKmgzNnot82W4290eoXQahIunGXbBKml1pkIULcr1UxV?=
 =?us-ascii?Q?L1ESLEp7Akly5nOobIHTMi6iEloHeqbPQes+qoNZcFva52wpGGzBJNaHJTZI?=
 =?us-ascii?Q?rFZK7zy1dQJHvIFcCmtrx1plboDI2u5Y/ISxnBtvS+3SvcKwTUW7g9CqaNjx?=
 =?us-ascii?Q?hSG2PAED5RCZJ/olQkJzWt5SR6JutED6Yz+oNcWZrMjIDcEMi4fR3M5pUKam?=
 =?us-ascii?Q?ntgAdv6FNkkUw98seDU2SSNHBLoiTbyDQWmk6vK4I1Bv/DmVAfXZ8hQmOLJz?=
 =?us-ascii?Q?jnycczJkWikU+ThwvOq0m9xvzMQZqOJtT20k6QSyVvRpL4hxbZXOaBflb+cV?=
 =?us-ascii?Q?D6udgMEbetTVwHJEyJTxS3HaBaTlgvG/OSZ0U+itd4/3YNk8iXa2/N0elu29?=
 =?us-ascii?Q?Vjsd3lyAeVAyc6zpO1ECxRysfSPIQZ6s2qa/ZsTIPCBBN94uUeCiL81QRxzz?=
 =?us-ascii?Q?e/ELVPzCJDVvSNyBJ6yglkiVYEJQ4BzkdMIWIr18Jas6IV8uzQ+OgOGck1+b?=
 =?us-ascii?Q?4jWYOk77tnBjtWVINSdHbKmYUZ39pk+IOQM+fg6NX0RIjYVbo1yDh8nyw45f?=
 =?us-ascii?Q?UKho1jRUoGH7kKusJhQy8WO3rr93EN/faVA0MfvFjsr/kp3njRB36UHJBV+r?=
 =?us-ascii?Q?t/Bh9QA3D27dTEl/dBT0MdqldD+o2qx43RAybG+TyAjnTMX7EbLm5BSti8FD?=
 =?us-ascii?Q?IZiIkHVwTXjjl7JZcE7es0lNbrCmku0qFgjz4mLpyurwNCopodMOrNiDdXVt?=
 =?us-ascii?Q?ZHa1KyJhVVIGgdjzmx2RnjDDlmS/3g5nA8dCxUodLL5OLcuOLpjLZb0KQ6J0?=
 =?us-ascii?Q?UsVSskRydg1cdTBuF5qWCUE8HYr16uaGuRla1qgX5b5xsO5lpx2e32/gO37n?=
 =?us-ascii?Q?obDJc0UaZujRHYgiwEvIdtLutGIQxrGYl4gJHjMrvD+fKgSp/InVUPmgveaB?=
 =?us-ascii?Q?RszVyQoINVxV9M2RvkiDEqBj+n4ub14aL/YG6CQx95ldZ39hKuE5r44Hz0bl?=
 =?us-ascii?Q?T6QQTNar3xgpo03HoTCzpu9JR5lULOESAC2NBO9LYFjOOa+tfqRsESRn4Ogf?=
 =?us-ascii?Q?QTmmW6KWeEaVgoqADQieUPdVnP3LEdT0BSbAz/If86x1+nWPcH1pvjutvHe3?=
 =?us-ascii?Q?TsH0V4Kq9muORwweefOr1iZLveDL1bLphVZjcBVlRK5iihYoIzi2uRWzDcOh?=
 =?us-ascii?Q?4r80tLZKIalFgfxIUNiU8+Mv0mqs+SqReyONKyKxOD72m7nTAOg6KON/9xCR?=
 =?us-ascii?Q?74q8i3d4r7Mu7rJJLj0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591fe821-0644-4787-83b5-08de1e1da73a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:44.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53jLu9YZ3KAkeTGbxI4vPYEr+li6GDuyPKc2nUG8hz//AvJr7cLNxI+D7RXPNIGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Basic tests of establishing a dmabuf and revoking it. The selftest kernel
side provides a basic small dmabuf for this testing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h       |  10 ++
 drivers/iommu/iommufd/iommufd_test.h          |  10 ++
 drivers/iommu/iommufd/pages.c                 |   4 +
 drivers/iommu/iommufd/selftest.c              | 142 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  43 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  44 ++++++
 6 files changed, 253 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a2786fee7603f5..ef2db82e3d7bf5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,8 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct dma_buf_attachment;
+struct dma_buf_phys_vec;
 
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
@@ -713,6 +715,8 @@ bool iommufd_should_fail(void);
 int __init iommufd_test_init(void);
 void iommufd_test_exit(void);
 bool iommufd_selftest_is_mock_dev(struct device *dev);
+int iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				     struct dma_buf_phys_vec *phys);
 #else
 static inline void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 						 unsigned int ioas_id,
@@ -734,5 +738,11 @@ static inline bool iommufd_selftest_is_mock_dev(struct device *dev)
 {
 	return false;
 }
+static inline int
+iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 8fc618b2bcf967..9166c39eb0c8b2 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -29,6 +29,8 @@ enum {
 	IOMMU_TEST_OP_PASID_REPLACE,
 	IOMMU_TEST_OP_PASID_DETACH,
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
+	IOMMU_TEST_OP_DMABUF_GET,
+	IOMMU_TEST_OP_DMABUF_REVOKE,
 };
 
 enum {
@@ -176,6 +178,14 @@ struct iommu_test_cmd {
 			__u32 hwpt_id;
 			/* @id is stdev_id */
 		} pasid_check;
+		struct {
+			__u32 length;
+			__u32 open_flags;
+		} dmabuf_get;
+		struct {
+			__s32 dmabuf_fd;
+			__u32 revoked;
+		} dmabuf_revoke;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 410ddce4e99d8f..01c55e6519ee84 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1464,6 +1464,10 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
 	int rc;
 
+	rc = iommufd_test_dma_buf_iommufd_map(attachment, phys);
+	if (rc != -EOPNOTSUPP)
+		return rc;
+
 	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index de178827a078a9..ccd90cf73a73d6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -5,6 +5,8 @@
  */
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/fault-inject.h>
 #include <linux/file.h>
 #include <linux/iommu.h>
@@ -2031,6 +2033,139 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 	}
 }
 
+struct iommufd_test_dma_buf {
+	void *memory;
+	size_t length;
+	bool revoked;
+};
+
+static int iommufd_test_dma_buf_attach(struct dma_buf *dmabuf,
+				       struct dma_buf_attachment *attachment)
+{
+	return 0;
+}
+
+static void iommufd_test_dma_buf_detach(struct dma_buf *dmabuf,
+					struct dma_buf_attachment *attachment)
+{
+}
+
+static struct sg_table *
+iommufd_test_dma_buf_map(struct dma_buf_attachment *attachment,
+			 enum dma_data_direction dir)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void iommufd_test_dma_buf_unmap(struct dma_buf_attachment *attachment,
+				       struct sg_table *sgt,
+				       enum dma_data_direction dir)
+{
+}
+
+static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct iommufd_test_dma_buf *priv = dmabuf->priv;
+
+	kfree(priv);
+}
+
+static const struct dma_buf_ops iommufd_test_dmabuf_ops = {
+	.attach = iommufd_test_dma_buf_attach,
+	.detach = iommufd_test_dma_buf_detach,
+	.map_dma_buf = iommufd_test_dma_buf_map,
+	.release = iommufd_test_dma_buf_release,
+	.unmap_dma_buf = iommufd_test_dma_buf_unmap,
+};
+
+int iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				     struct dma_buf_phys_vec *phys)
+{
+	struct iommufd_test_dma_buf *priv = attachment->dmabuf->priv;
+
+	dma_resv_assert_held(attachment->dmabuf->resv);
+
+	if (attachment->dmabuf->ops != &iommufd_test_dmabuf_ops)
+		return -EOPNOTSUPP;
+
+	if (priv->revoked)
+		return -ENODEV;
+
+	phys->paddr = virt_to_phys(priv->memory);
+	phys->len = priv->length;
+	return 0;
+}
+
+static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
+				   unsigned int open_flags,
+				   size_t len)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct iommufd_test_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int rc;
+
+	len = ALIGN(len, PAGE_SIZE);
+	if (len == 0 || len > PAGE_SIZE * 512)
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->length = len;
+	priv->memory = kzalloc(len, GFP_KERNEL);
+	if (!priv->memory) {
+		rc = -ENOMEM;
+		goto err_free;
+	}
+
+	exp_info.ops = &iommufd_test_dmabuf_ops;
+	exp_info.size = len;
+	exp_info.flags = open_flags;
+	exp_info.priv = priv;
+
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		rc = PTR_ERR(dmabuf);
+		goto err_free;
+	}
+
+	return dma_buf_fd(dmabuf, open_flags);
+
+err_free:
+	kfree(priv->memory);
+	kfree(priv);
+	return rc;
+}
+
+static int iommufd_test_dmabuf_revoke(struct iommufd_ucmd *ucmd, int fd,
+				      bool revoked)
+{
+	struct iommufd_test_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int rc = 0;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops != &iommufd_test_dmabuf_ops) {
+		rc = -EOPNOTSUPP;
+		goto err_put;
+	}
+
+	priv = dmabuf->priv;
+	dma_resv_lock(dmabuf->resv, NULL);
+	priv->revoked = revoked;
+	dma_buf_move_notify(dmabuf);
+	dma_resv_unlock(dmabuf->resv);
+
+err_put:
+	dma_buf_put(dmabuf);
+	return rc;
+}
+
 int iommufd_test(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
@@ -2109,6 +2244,13 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_pasid_detach(ucmd, cmd);
 	case IOMMU_TEST_OP_PASID_CHECK_HWPT:
 		return iommufd_test_pasid_check_hwpt(ucmd, cmd);
+	case IOMMU_TEST_OP_DMABUF_GET:
+		return iommufd_test_dmabuf_get(ucmd, cmd->dmabuf_get.open_flags,
+					       cmd->dmabuf_get.length);
+	case IOMMU_TEST_OP_DMABUF_REVOKE:
+		return iommufd_test_dmabuf_revoke(ucmd,
+						  cmd->dmabuf_revoke.dmabuf_fd,
+						  cmd->dmabuf_revoke.revoked);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 3eebf5e3b974f4..de348d6412791b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1574,6 +1574,49 @@ TEST_F(iommufd_ioas, copy_sweep)
 	test_ioctl_destroy(dst_ioas_id);
 }
 
+TEST_F(iommufd_ioas, dmabuf_simple)
+{
+	size_t buf_size = PAGE_SIZE*4;
+	__u64 iova;
+	int dfd;
+
+	test_cmd_get_dmabuf(buf_size, &dfd);
+	test_err_ioctl_ioas_map_file(EINVAL, dfd, 0, 0, &iova);
+	test_err_ioctl_ioas_map_file(EINVAL, dfd, buf_size, buf_size, &iova);
+	test_err_ioctl_ioas_map_file(EINVAL, dfd, 0, buf_size + 1, &iova);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova);
+
+	close(dfd);
+}
+
+TEST_F(iommufd_ioas, dmabuf_revoke)
+{
+	size_t buf_size = PAGE_SIZE*4;
+	__u32 hwpt_id;
+	__u64 iova;
+	__u64 iova2;
+	int dfd;
+
+	test_cmd_get_dmabuf(buf_size, &dfd);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova);
+	test_cmd_revoke_dmabuf(dfd, true);
+
+	if (variant->mock_domains)
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
+				    &hwpt_id);
+
+	test_err_ioctl_ioas_map_file(ENODEV, dfd, 0, buf_size, &iova2);
+
+	test_cmd_revoke_dmabuf(dfd, false);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova2);
+
+	/* Restore the iova back */
+	test_ioctl_ioas_unmap(iova, buf_size);
+	test_ioctl_ioas_map_fixed_file(dfd, 0, buf_size, iova);
+
+	close(dfd);
+}
+
 FIXTURE(iommufd_mock_domain)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 772ca1db6e5971..f6d1678b310e1f 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -548,6 +548,39 @@ static int _test_cmd_destroy_access_pages(int fd, unsigned int access_id,
 	EXPECT_ERRNO(_errno, _test_cmd_destroy_access_pages(              \
 				     self->fd, access_id, access_pages_id))
 
+static int _test_cmd_get_dmabuf(int fd, size_t len, int *out_fd)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DMABUF_GET,
+		.dmabuf_get = { .length = len, .open_flags = O_CLOEXEC },
+	};
+
+	*out_fd = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (*out_fd < 0)
+		return -1;
+	return 0;
+}
+#define test_cmd_get_dmabuf(len, out_fd) \
+	ASSERT_EQ(0, _test_cmd_get_dmabuf(self->fd, len, out_fd))
+
+static int _test_cmd_revoke_dmabuf(int fd, int dmabuf_fd, bool revoked)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DMABUF_REVOKE,
+		.dmabuf_revoke = { .dmabuf_fd = dmabuf_fd, .revoked = revoked },
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret < 0)
+		return -1;
+	return 0;
+}
+#define test_cmd_revoke_dmabuf(dmabuf_fd, revoke) \
+	ASSERT_EQ(0, _test_cmd_revoke_dmabuf(self->fd, dmabuf_fd, revoke))
+
 static int _test_ioctl_destroy(int fd, unsigned int id)
 {
 	struct iommu_destroy cmd = {
@@ -718,6 +751,17 @@ static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
 			  self->fd, ioas_id, mfd, start, length, iova_p,     \
 			  IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
 
+#define test_ioctl_ioas_map_fixed_file(mfd, start, length, iova)          \
+	({                                                                \
+		__u64 __iova = iova;                                      \
+		ASSERT_EQ(0, _test_ioctl_ioas_map_file(                   \
+				     self->fd, self->ioas_id, mfd, start, \
+				     length, &__iova,                     \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |          \
+					     IOMMU_IOAS_MAP_WRITEABLE |   \
+					     IOMMU_IOAS_MAP_READABLE));   \
+	})
+
 static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
 {
 	struct iommu_test_cmd memlimit_cmd = {
-- 
2.43.0


