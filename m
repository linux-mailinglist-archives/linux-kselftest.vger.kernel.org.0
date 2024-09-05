Return-Path: <linux-kselftest+bounces-17278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DC896DEFA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7E0281CC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537719DF82;
	Thu,  5 Sep 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZ3J/n8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B41195FCE;
	Thu,  5 Sep 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551779; cv=fail; b=YTzKhdRrlU+1DXPZA8jkBNx529iAHPffCyCmV9Bh6wD6mEP01PPwI826rMVj2ou+5+lTKIyzdqmrBUhPAq0qLfnQyjVEjkrFseML58WbrhiMAjuauaZH67VY24hVbSEhKr6ImKYStQl+bwpA66VYfyI82pBCA9fBSmke3tOBNGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551779; c=relaxed/simple;
	bh=6cnX9Q1CC5ZC0Re3wrNnMLg0JRdplmZ/C4eG5IqjsY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sK5uRwTQGvtiCLRu8alnICKe09rXXzFgV9Ez0tDUhu7LVB0Em0UuxkU9pJZGnysYxrH8lQhT8fHqvMg87NMdI2/UW/SAMcPqVJRZWWN7aDHzUnBv/i9kO3ojhKk3bUQy0iq9LwWwD3K7CTE6ahlrddfU0usAPJklhZva9Nw022Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZ3J/n8p; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THn9Vay9gvm1J560fDxR3TArzhxRJ/48IpIx8DPpzIQkDkXvW9O9q0xLJSfj1nCkusW1c1NANNDXQDReNIeeTesbeGisS86lb+7zOOZUnBdHhWlqRC3mGY7sHRlQNMqgKivvLWr161GTt0mPImcpU6CHbKZRqr6LJVeb3Ofsf5yiz3JuCNviEXX4BZe8vPNXvL8vA48/8mRVbNgiJ0rgDgQaoTMRkGftZG/e3ru3Gc/Fnb0/aypw+8wDvsTi5R4TnwJoOmkeXI+mNJvvG9czK8fokIm+l1YwfnR050vLYmDr0IgT5GDRAfsKXXSHP606GqrXBiTnKixQivkK6VG7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiN9WLrCI1bavDJHS0M4dPPFQUe5c0vt7Do1iBH2xqs=;
 b=rePVhR9GxSGdmiygPlw/uckODhSx0nfpQEct08tUvU6goCGnDqYfurmV2A9/dDNhOcN8k9bpHXkqmRE7p5JTPk3MdtP7Anx/msAyYMX9V6Wp+GGk1yqSA4ab7BR4hXucPdNKWKrITFr37wz5D+QOFWizTWZs5E+Ik5ehXqNSMxP/SGIvGAyxBFjOdEDw6OgJGp/TJptorE34QiJKp5QDWsDnmXCc432wJOnHxZ9M+CORmr5CEe93BMO+n5/sE1mjOuFteSRB1IdZbY8DTwKWtJ7k9T4Zh1T41tswFD0WI5nIrm0kqad1SeFOfBfXMlB2Z05yCfWYyXULOGvZexKorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiN9WLrCI1bavDJHS0M4dPPFQUe5c0vt7Do1iBH2xqs=;
 b=lZ3J/n8pjxF3VvQpnzyrj+o0q5gAonYHYSxuMp6SW89l0I2amKexUMgl8TxX5PnPJvRn8KdfOIHgc8HlIsDw3vlsacLHWvbHcn4fslIDc9QGb8JaQoAYwBHOE92T4ITTwUGJ+3/yBkuvuytJN2jXHCamThSg1jTGnzUohuFO8n/lTVD5tXaZ0gCW4EJUNNeWcm2Wbae/AW155w0zYKA7SVzRoFvBbKjWpIB03MY3oEKr8oR9BEPEA0qdylrheWkb6rpuNyzSUIebegYNp2mwHg7zD8yMaOnvHpqpTBfu6nM1hyMWFHnxMxKEQUbeThQ1g87QrXJMJADFltC6FRSMqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:56:14 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:56:14 +0000
Date: Thu, 5 Sep 2024 12:56:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20240905155613.GO1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0097.namprd02.prod.outlook.com
 (2603:10b6:208:51::38) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f456c5-4422-42b2-901f-08dccdc3452c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOXwFfFQqFEjdo/UUcyI/BSr0lY/efKylHwSASZIKkMHzPaRsUZVZHrFIpZ5?=
 =?us-ascii?Q?4UElKV87Rk1FhH2FOBtthbi9e4yfm4G89U+b6pJYfnWJ6sI550qzmoO5K1XU?=
 =?us-ascii?Q?Y3zXImIklqNq+ao1/9bo3EgReAwPQ1REPioSPdq+5OL9qLDGwVzJNmUQmlaM?=
 =?us-ascii?Q?a975biGvtZKS2isbCn4wQDrLpK/K4Sg4j7HJawQmhZ4NNKRCyzaDyMEdLhro?=
 =?us-ascii?Q?a+cz03DN4UnWv3PwJUrWonwUAnpCUYyduJKYD0Hfg+gToHvfSItSDs84kO4Y?=
 =?us-ascii?Q?jc+6HAeXrzx5yK9SE8h79TRhN9Sax5Sxo4j9NO7fFyu0sxV3vniQ6R34T8CP?=
 =?us-ascii?Q?GuXsXJNsHgXrOXvdK20mmElXwdhZpRyV8ANIcrPznMOoaQ37BLpVDQQI8R1d?=
 =?us-ascii?Q?meCFpJJg92G+JXNakBTgQElKSWOKSIGfnK0Hxrj/3jlH8mBvAv9+r5p1Crba?=
 =?us-ascii?Q?IVN7UzcisjZ8AcDMpB0BFhn2697ujdAgqnx8pheKJ7yn1qwt9iv1ETmsKB0a?=
 =?us-ascii?Q?f/+gSJcpS3MD/kvdT29k+Y0GkiyUH/eByAexwwjeJdOQez/yFQBm56sSMgIJ?=
 =?us-ascii?Q?g2gjGXmMfH91zqNFADOVRi411oezPf7UMexIQGwWtWPv2SUKvxPiUgPo9RAn?=
 =?us-ascii?Q?JegXFnXpsFaG0W0V4VGAw+Av6VmxMoa7yRV12yttO9CH8SB8OGeDud1ZFo8S?=
 =?us-ascii?Q?CT1jBx2+NvmVTHo3YTNqhqYb8JxwneVINH2dsKwlsDiirevqQQgRKb7cGQsi?=
 =?us-ascii?Q?afEW1gfZNKKjlQ4Bmgl7H8UfjOsp77/7cMoo1p+z3VZM00mV1rkjoIdRs82F?=
 =?us-ascii?Q?asOoV+UMo4YZiAarPlGHgwAeONQTbhXD9CyAjRMmA0GvHKu5hwFw3WeAdx+q?=
 =?us-ascii?Q?zaBondGl7TL7EMDzv8jVgMZip0+DIeC/b9Wu7XtmbaY/BmCRDrqdLzShz3/Q?=
 =?us-ascii?Q?OsfUGxEMGool5R1+CvhfDxVe8JjPE3DQ38qZlrY5cO1kOpW5uqnbbLjf17jM?=
 =?us-ascii?Q?+wIV60cLkCOYTPmoHxBdK9dKZMVOj/0ATr0Ox16ogruywTBo3lAFDIdOUl7b?=
 =?us-ascii?Q?OzC7i0fWOnATUodFRQPDkRZjuT+4JDf+gLdjY77r1t8IbiPXLHS6nUvJh9QV?=
 =?us-ascii?Q?VlHzSZMJgYVDniWFgwULh5JLFwtrkF6td5VedfzHl81rQr4XUwZYvZkhJgtX?=
 =?us-ascii?Q?j8KAqIm/2dw9Nf4zMW9YdYs7glEDQRL7bOuyy0rUpBWsty58mP4ORQfS6yiv?=
 =?us-ascii?Q?eqOEZRa7Hr79dSVy25dc+ZU6jpunyv/ZVexFvhvgD8a49i5pQTsJTJuG4dDs?=
 =?us-ascii?Q?CEIdlV2Szy2O09MeVX9LTe1GVpb9NTsNGnVj15F3NM47Ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oj2iU2Qq4DRJ/a3rrvpdv7sXbb9O9KIsWTJDC+pK6co183tpW073h8VLXQTj?=
 =?us-ascii?Q?8n1j2wzp4xXRsoOCOk20QLR5f9WZKMCuUbw60Ac+dWo0gqnJ0FKUrlcz92mH?=
 =?us-ascii?Q?r1zs+jmKyFJb3cc0OrUImP5BRx+pmhXuD+5IRl5EUZb3ybF/kMP73IbN6ZXh?=
 =?us-ascii?Q?t7iDf6v43hPsaUyfpUQTgZ3vpRlewlfD7HN0gI7IPf+ZSpv76+eHXJHp6ntp?=
 =?us-ascii?Q?W36edxh9dpQik64XFNOWUcYGwr/JVglxpGcA0LZQc0OdoclPeNAg4vARxaZJ?=
 =?us-ascii?Q?8OfZZ6XPZe3iCrr658uytvnxP60Q5Fch6s+r2oj9y5hbCvuAV1/0H8o5NcSO?=
 =?us-ascii?Q?w21z9q11QhFD4t0qybRhziSvoi40dT47wFNDmbM8WaUvH9EnL30TKh9yyxcN?=
 =?us-ascii?Q?tqwvjciOHdWzh5lnQKUZFi/y6Pozg+uIRh90hKwhZhonv6fBYxlLTFrmLtah?=
 =?us-ascii?Q?wyWS3Y+vo6W9pDQJySp3fSxiK9QvWGikhuyJHVBBq3sB8o7mG0x1wau7EDr3?=
 =?us-ascii?Q?1maBpIZZmobU1IGMbUIo61LR/rC3pX0W7zNzqBca4jIJ5Z/YKURayD2mlVja?=
 =?us-ascii?Q?YZa6OYLtjB5F9fFodttz6U4OuoNUpnM+gIflHkL5tZtZSeF6fJfv0jyF1Q4t?=
 =?us-ascii?Q?e0iqeCMBCM+wF7MTHqPoeRjE0Ixl2TKSXnV0FEoNO67NYz6AnhROxXWU3laC?=
 =?us-ascii?Q?i2Os7+yO1diVuRKUYgKcBhbTt9fvHsb4l7hVsHZS4Kl5B13foq6AF+ujW8WJ?=
 =?us-ascii?Q?NgqD6KzSw3yrhFCneOWXMpKCBOyFRIhAKY68g7i81cglqO0vg4OMt6DKHkQ1?=
 =?us-ascii?Q?nfFVlPvjuBnjYnqWMKdmvR+8M6QsTLLm9CDdlYOkJxRZtHwGkwQY6lyhC9MJ?=
 =?us-ascii?Q?w99Cr1ETCSyP4aN+TE3/ofcE4f8hcnWNAEkITL2UAR4/6TpbXWyb7afixizW?=
 =?us-ascii?Q?qKU4QxkQ+CO8FuCQa5wa2J7+OEs8NDiQ8UPrOO1agfFXdfhrzrQTrW/0iymp?=
 =?us-ascii?Q?OhjtQlx7VtON0YNBTOtDICraYUk9xaLS2cpKo33kjoxlBdRC/iMdybivRSpk?=
 =?us-ascii?Q?ej8hKHwpblE5ydxt5JASOdNk0jUaanotw6cjwW02pKnmZnZ2CABRlC8sjLLX?=
 =?us-ascii?Q?LjZ4wI/7/X4mM/q5dKnysM/6L8vVgOFvEbOXTPIq95PR8O56XgtGZtbbZJcw?=
 =?us-ascii?Q?okUXuL9+lvyPsF3i5PVaOEq9Z2xAAsWbe3chQXT4YQ6YjtXHAk6O853W7LGb?=
 =?us-ascii?Q?fuGcd6LzNfZFJGjR5HTzP+oCEqXlNandaxOhkd/uNrqchrCTQb8wy2JF3e46?=
 =?us-ascii?Q?xDw9dmMpr569sIxRHjjX4KpLTzDm1fpswuVl9Ih0AFjB7t1RRZNzjnlG3qFK?=
 =?us-ascii?Q?QLL5JtsE3gCwXIoj6ixbeA9ExTlIV7hk9KcfTWRUI3v+rt5D5UezVdCrr2bJ?=
 =?us-ascii?Q?5w8308BTxdryS8gYiurTgDYyKXeEsC/6DZLwgs5f02XLl39hSeyXxm66XLek?=
 =?us-ascii?Q?ZcmItvsaHUCn0jw31xtr/Lzuy1CXueCU/E0IjQIA9T6J9jHSdg/xaos/fiFm?=
 =?us-ascii?Q?0cXsvGp3SJ8ucrXHMeIQOucSmm/yoUYUrsRIhSWw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f456c5-4422-42b2-901f-08dccdc3452c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:56:14.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbI1Xp8+uTJ6RMGv9h5i0ccLEtkYyTkdgkdb5d38uz56cR9NT4waLqE76otpkuMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

On Tue, Aug 27, 2024 at 09:59:41AM -0700, Nicolin Chen wrote:
> Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act like
> a nested parent HWPT to allocate a nested HWPT.
> 
> Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.
> 
> Also, associate a viommu to an allocating nested HWPT.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c    | 24 ++++++++++++++++++++++--
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  include/uapi/linux/iommufd.h            | 12 ++++++------
>  3 files changed, 29 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

