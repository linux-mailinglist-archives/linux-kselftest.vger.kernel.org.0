Return-Path: <linux-kselftest+bounces-16071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A295B8DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DFA1F26035
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A301CC888;
	Thu, 22 Aug 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqHqYE1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A11CC883
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337964; cv=fail; b=DXrjWXHGvh6adJ2BUs3T+591Tfatr+GpR/hSn+NH/2U375lJYiyOVUc1p3y/VqAh6CJ4ILkJK4nvv5RMaWzgDMOOLPAdHIBsyPA5SwbOyLIzqh6zws/3e1tB3UrwX9RoT8Dx5xcioO05I7LgCLj/fxQgvZkpBhyORk4k/Ud1JN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337964; c=relaxed/simple;
	bh=nL630AwvgUKg/rFHkWv2OtHuea7d8GSMkAk6aT1la0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwoLrSD4ZMBkAltKk+yS5Nhcuja8BgXUvJsCHW6QHX9eUiXefekkf7IvPqUmUj5FAZGOeUhywydgHR1AmT+0Dl8uZJF2DkQmcA4qqUspaiL5KPcZCGpTXFdH0029aHT79XUohGEvJ7gT1dqAt0aJ7UjhP30X1mFXDyPpAGuyUgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqHqYE1n; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7yEAflkMRbyl/guCb/Wf5Ru1C91lnScGdmF5by14oLQXt/mV3Idd/hV5RxSv3RtbTczDTzFjQF0wUO1hROmxddFlOLTVi+v21duLwr7wk6Cxz4KFhyeUqczzKvxqgD/cujgQlZ5cdVutobsV9VpJah3y6oHlhvxTY+hTzkkxboDQFkk4WE4DyDZQaPEnNUveEW8uehSzhICJcXrjHVVsmZ8QUVqjVJz0ASQbvxrQavpBn4tU9kkO66KF25ZMLG3GhASKr74RJRXmjNLu/zjnNXmusPFaSIlhnM0jRGYxSppowlfd+MzsndHfhl7+QjKOaCZOyQuoWQY0t3FRGBtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jb8sm1Xw1MO7W8qJf0xQFy1st66fKi4PEwSDmdhhRU=;
 b=vUlHiKOmCbqdrLDm+GlHs3C3SvnVZpomMz423Abb5GUOV9P3380ZX2youhvSzObvTpfKFeWiUmr+mN7OyXYpeDWvr5++FadFMXJwAbCia9yFahgrwoFWvU8SvDD4XUTKEPMpqv8i6DXFMQrzCS8R6mAJrz5nj8wC1/d15OULgMtobYEvs5QD/3BaeGJnkKOv4hrU2VNhNwm4wZRSBUxmfj/wfegathfns/FWMOwFuNYAEc2ERafQt6XF81aMPpUXN102zdpMiOUPlGXydE6F2cYsCKnWHPpRtKA76Q578gqxnmXd5PxlYuieXDJSWZ80ixZIxLsmEWKr3tM8vHSMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jb8sm1Xw1MO7W8qJf0xQFy1st66fKi4PEwSDmdhhRU=;
 b=ZqHqYE1nAyzJxm6uWyibCJmW61ng/rzrhePeo9TIAFDOd0qwsfDzAw16rot/+oebYFBcSXuhjbpFi9L1rGoBHJKMNeafEZYuj4WXNnUQtsz+wuNRaNjsueHYqKApNx8c7X7palBj95gnrHiPyQ5ZrWDDQ5Wb91XHuP+hqhJXS2HE/cgCEhIxdssttEcH6gAwJr7iwQvcUxT4YTPWpTY9H45urzV9n4AEP+rOF4VARHftg7BuU7Bl6XCZx65MaMkCD1kOUbAHerzqmWpduJiwGV42OgYPESxNtrUJWz/6ZAbfScbockfCorTAX2ntHZC+enMnbt3rKGqS/CbUDHvFcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 14:45:57 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 14:45:57 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Janne Grunau <j@jannau.net>,
	Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>,
	Will Deacon <will.deacon@arm.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH rc 2/2] iommu: Do not return 0 from map_pages if it doesn't do anything
Date: Thu, 22 Aug 2024 11:45:55 -0300
Message-ID: <2-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
In-Reply-To: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: d2623062-a322-4bd8-b32c-08dcc2b921a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ks0+DvlGmO0H1kFfWYe+5uK3XxJomMCnKQYr1/TqVl3WcTpK7/xUvRr+DIV6?=
 =?us-ascii?Q?qXsNfk9u9Wlfn0GYCwQidNd5VhF+n/n9Hz+EsqCrC5CZZu+hBQ7fI/hZbOtj?=
 =?us-ascii?Q?GekoPQVySfx8mJoSBtwQo2SUvlsSKUSwwx3gWsiyfJGyIndow+R16tx8bw2u?=
 =?us-ascii?Q?VEaz8MmiYV86dPIkPlQ7eG1nA39ayY0U6UEmqhHF3uB1wKO9j6QKc6B7bPMC?=
 =?us-ascii?Q?PuP6qyoXbAgBrA/q765QATSlj4BmBEEOztG5RuIcyFh/3xUIldyv0WecgmG6?=
 =?us-ascii?Q?h2VimMzt4nAFWainn71eCiu2U5vglQwOJuda5e95Q9Y+QQTTxQMPxXr0AEES?=
 =?us-ascii?Q?3LSnhX7UBmFb9ELiznz3/VCXfssqrerg5cHg3+BUHTOx/p84DN68hqhx79GK?=
 =?us-ascii?Q?wZ8WA4Fws7I9CoNE7dRRHVpCXZn7i+z1SC1noUSHhZlcSB3/5+crQ8VRhAzG?=
 =?us-ascii?Q?R/T2dKZAC1SH0qPb3sYFBnjjjaXlTpyJ07f/ObRIGWiFci9mwbZ7BZWimify?=
 =?us-ascii?Q?mfWLrQHuMGDFGQxIArzH9vWteKqg53ttRYwsl6aCIdkUKITm41bDrjqwmEgh?=
 =?us-ascii?Q?ULTzXj9Z1rCbWStfj+M3QU7Z5otgB8yV1d736xioI6TXML3bhWjaeeMUDvdE?=
 =?us-ascii?Q?maHT1FSZD9JV28x0hmevfbLSL9Vpdpt5ruBITI/guGB5RKqF4ALyOxfmhWkv?=
 =?us-ascii?Q?D+6sjENngn4MX9f/lO207ABDnB1EHUrrKU70aRDHI2xmKfXSfbWhWUjjSXxP?=
 =?us-ascii?Q?ElI53IKEiEjXKthuGmOG6mATIbwAuFkihAVZcx6lK5RCleWUXLgDoh0iiebC?=
 =?us-ascii?Q?nHeus9jjRMCyUGT43mkutv8Q0KSus6OMRa5QvMtlx8KsDPmuO5ym3l9mB2yI?=
 =?us-ascii?Q?NDCdGxH+sVEXOPXhMHM1SQRHDKLpPtkLacB0fA+3VLv8NIUUzysm9H674xOu?=
 =?us-ascii?Q?lvatn7PsbTPbuZbN1GHBeEwpuRB4r36C2a74+k1SUIf4hjXZ0NMAdbnssPEH?=
 =?us-ascii?Q?eK15A/GY8yV6hh7WUfUu29dHDeXJ/C1biYq+Mfi2l6Or3lB188FhlEXvm7O2?=
 =?us-ascii?Q?kAKGIVuJIcyS8cJCOJ6PFW/4TiF30Jat7vrGkNiR4Z9TGO0NhNtw8kWBqvZS?=
 =?us-ascii?Q?t2lUc/uBlIEx8CgT9jXFShFTyM6YTj60aqArNDH5pVhjlB5SbO0FIYnbPcYF?=
 =?us-ascii?Q?0aDD/dszcjgND1tyQumzSK+/tyq+yApiCZSWhYVIrBYabfrplM0BLCl4A2Rb?=
 =?us-ascii?Q?JmQOxO3zdvYXtTv9bW6i6lkPJNhDZR6AxkBqnI0HVhn7Jmsn6lfqjKqSX3OG?=
 =?us-ascii?Q?tzDcB32gMcrr6ljn48nJDVdqP+2zZj/ZF0xEb/S0cgSeOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdWlRwrvczGCtTHtX8nDWvfXAPOYiu5JYaEZw1egg4O2V++kG7AS9hIax3V2?=
 =?us-ascii?Q?ju3LgF+NV2V0uStweCg1HzikAq60ZdsNSeEHy0D73GBIRKb4xZGCbCJj2H7E?=
 =?us-ascii?Q?yUHjxyu22I7pKxi1YghZhiFz2xvGVb1bijQ+/q8HqUalqBeaRQD+zLLnto6h?=
 =?us-ascii?Q?phK9+SwUelIRUAiTiJn4MdlUs1uxMEj4UaivmBqQDnY/V4cZk9DfstGCA4G3?=
 =?us-ascii?Q?reGZOYwrhCv/MDsPOLqGKmPFpzfWo6++VtUkGD02BL9ZN+Z/t2gMkBdF69F/?=
 =?us-ascii?Q?yjH4HNYVHj8dBP3A1accXj2pwgf5TXCiiQ/QYRUeG/3TBSPMv30APUdsX7hz?=
 =?us-ascii?Q?aL+NIOnRZvVwyRzbb91vY4eUfjamerK548IHUGaEPMoA8NpZEwlkJ3fDinmJ?=
 =?us-ascii?Q?ZJ3M8fMAvQPIdffxTT75nMzWWd4i2VqlL/FUOQ8ZGeG6sXwgOuH3/8BqMD0V?=
 =?us-ascii?Q?ldQFLl/3ZB/qTSes8fwPMsXdQB39J/MlU76DIYUyYYgA4PcHknWib0NSp71X?=
 =?us-ascii?Q?AQbCwddVJz/4l+KgpixGdkWQKjkAJOroVkeBOHpCgqGIkGhWA8oM6CzrVtDo?=
 =?us-ascii?Q?c4PcKlFOHIiMuJKZ8FM0m/3vu9TuPprDMbbGzsgWZGgBRWSVx1bJHSfluWYl?=
 =?us-ascii?Q?Gi3sWzKWTazd1oUYqo86HQz3c/qQW5VzEfvZlTh7gbH9yUkV8xrn440BHQxb?=
 =?us-ascii?Q?UAZTPkNf207YSqgOd8CLLHwWnazCbU8vNJlGezswie8mKf603/AFp12zDiBg?=
 =?us-ascii?Q?LXLltqiyI4WJ3sbEkZ+nLfR8m3J41NjIA5d/TKe9Pd8Hg94NE3BZpFpC3t7w?=
 =?us-ascii?Q?ds3ZsSjxNuI2AO1Vc/2DLMvo2+O3eAHRZue9RzXszDtMqV5/qN/g0dfiwd6P?=
 =?us-ascii?Q?yR/JLPdN4Dbcyx44q/vSrbeCZILTGyJaX+3cIPBje9nnKfhwWU0rFF+HtU/h?=
 =?us-ascii?Q?D47Zy7YiJTlW3hSyJjye0zDSwHeHKeRil6BxPzFCRmzAkOLQp4USqrqaI1cX?=
 =?us-ascii?Q?ZqAHWsG854eUIUY8JY5yOz+6w3qHHR8p+76YXd3HbEzi7WFvx+1U2z7PKlFd?=
 =?us-ascii?Q?ZLXi466Qecf+mreB75kUYhfUq//07Oz45aZx7akR0ig2ZaJK4qr7BWza+g87?=
 =?us-ascii?Q?pkmm3hIhQBTTJ5fRXXLzkwxOBmJ6VPlJLgyCXYOZbq6OwvvlzHpm3w3rCsrm?=
 =?us-ascii?Q?KBqGNvBiRo3m8Y0eFhHoSI7ThUjY4oAjyTl0RM62W/RxvEEyTR3K7lg3fGkv?=
 =?us-ascii?Q?osIeZF3FrO2huHrI+pREQW72aZcCt/GbqhAcfaperW3NnAat3T8BbtvLdnKK?=
 =?us-ascii?Q?N1LOTzRDiFHYx4DwlmT9DI67zBWAsFjgCIzoa4R9B6/9bgnt54DsaDQHqY13?=
 =?us-ascii?Q?oki9PYHhXjXDJuoqRqu4lCZRUI2/YdXClGf4WEFHtqUAyPW98+ZfXOk3DldA?=
 =?us-ascii?Q?8OpynQ1fRLo2N1r1iTZVy2HLG8smyxP6QW2Sz+5sFHZek0xm/3pfnAIptTF8?=
 =?us-ascii?Q?O1lz6o/89B66gToet88hlPCvtmsxZ5LwYK94YY4ULNGHJSy2qs4WfZ1k3HuT?=
 =?us-ascii?Q?Cfe4aACqhAWhw6M3/5+rN38vlGNT/RMkdP3Rph6b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2623062-a322-4bd8-b32c-08dcc2b921a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:45:56.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvrgSAovCG1pHM7ci3uKPsTxA9j+eiH6ukIhmh6ZRjY3KfSqWpeozboCfHvD8FcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

These three implementations of map_pages() all succeed if a mapping is
requested with no read or write. Since they return back to __iommu_map()
leaving the mapped output as 0 it triggers an infinite loop. Therefore
nothing is using no-access protection bits.

Further, VFIO and iommufd rely on iommu_iova_to_phys() to get back PFNs
stored by map, if iommu_map() succeeds but iommu_iova_to_phys() fails that
will create serious bugs.

Thus remove this never used "nothing to do" concept and just fail map
immediately.

Fixes: e5fc9753b1a8 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
Fixes: e1d3c0fd701d ("iommu: add ARM LPAE page table allocator")
Fixes: 745ef1092bcf ("iommu/io-pgtable: Move Apple DART support to its own file")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 3 +--
 drivers/iommu/io-pgtable-arm.c     | 3 +--
 drivers/iommu/io-pgtable-dart.c    | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 75f244a3e12df6..06ffc683b28fee 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -552,9 +552,8 @@ static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		    paddr >= (1ULL << data->iop.cfg.oas)))
 		return -ERANGE;
 
-	/* If no access, then nothing to do */
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
+		return -EINVAL;
 
 	while (pgcount--) {
 		ret = __arm_v7s_map(data, iova, paddr, pgsize, prot, 1, data->pgd,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf49..ff4149ae1751d4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -515,9 +515,8 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iaext || paddr >> cfg->oas))
 		return -ERANGE;
 
-	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
+		return -EINVAL;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
 	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index ad28031e1e93d6..c004640640ee50 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -245,9 +245,8 @@ static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(paddr >> cfg->oas))
 		return -ERANGE;
 
-	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
+		return -EINVAL;
 
 	tbl = dart_get_table(data, iova);
 
-- 
2.46.0


