Return-Path: <linux-kselftest+bounces-18421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2898797E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A20FB216CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC4F13BACC;
	Thu, 26 Sep 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4MudGNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6551D5AC4
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377488; cv=fail; b=Clm+0WvdoNU95mulysdaiMvtwabEDna8UT3YqO625zt7FxdFws9hMhK5m2Lsd368dHHWQ+PX66uTcOi8NOr3F4dpFEeP0YXkw6tneVTDj6doPghzZlbrj6noXmPV2xcHkwhZ8/tc4h3bJaacZM/Y7+x6I3KP84rl8I8nSTbXlTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377488; c=relaxed/simple;
	bh=LjJK1wZI2C5voZvXPjgeGvdtSzijEqbiE1OKN10RnD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Coiv3FrW4QKdiJxQd37OiN0mkJVkkem+L5ToE8eIHOu2seRY6hiPnollNceK1TOvtTQbBxbmjq0kHbxAMGEoQJpTX0QArbjHt5sZd9VlvBSolzP/2dcrIx5iGEu+ahB8f+5axhOY5vOqrL561WxCxwhXamjZgn7DJbxxirXzvsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4MudGNR; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWKaN9/16DLSGQBbEPrPpo8MttlrHiFSnMiGV6X3L+POcthIGjE6VfUKupkQom+Pp3xpwF+X9yKTezP5HaBVlnFLRW7GPDPWu+qnuwqmlbPRolMTu3ED9ugfYDwyQ1JZACJWtReB8jacQPX0HsMxo7iud4psHi7fKQJz/h5tw7Ktd6XEp2KZ+BVqP0w5AUuHCbeRRMrQctsAqi5guNqFQet4QMmm0yVqYlKaB8kBBMTsYhgtvpsQQxKNPk06RNpjWAP1OCLr8Z6SQBHsU72NWEOmlXtThYr7ig+8gignsrleQEsbeRlvAke3yvciWlX+yfMxDE6iAdgsD3IMvfXg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0knxCq2e/ilsjXjK6ckeC/XzHXFz84/OMf8X85jyuw=;
 b=ahuvubBKIFknJuQrVFGvUeM1c5x+XWNBYIbDMUnwGFZFQ/od5WTscxONJI30nvpBLEplbHIP2c7C5D/av2sQ22N1Un9GryLhs8aA/o3p0soEYQ7zmJav9YKuw+r8tUnaQyB9di1btFx6gp9fOk7oIhrwVD+5/PFFUjKwbNZPpuK2iD1G2hjgWhjD8aFrvv04ZIcpHquWXVFylomkL6dLLYIOTVfWyKDBdFZm5Lee97C4mHrOQwZ7I9KxYaJRpGLqVYOlLrBOl6IdspVrTfNIlaO9zq4WZbp15UsdJZ+r0JoToWdvGTkvk8Uh9vVPOhVdvhaRqn4AUagadrrCshJdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0knxCq2e/ilsjXjK6ckeC/XzHXFz84/OMf8X85jyuw=;
 b=A4MudGNRe0M17JZBBUvO9V3C5gl8gPSQTKNjeQXofeQsvegCtHYjfe6hZZuOh7XUqeKrZlo0V4dNObnVzQ9CBwsNNwmT4GrRoMvw/+RpW7ILBD74hD6vgMPiXwoZ11/7QVdDDis1fvhJNLayYtrf8gCIwhRU2auUwG/U045wDF2fzWIThZCsCxlMXcA5vRx4viz+sho6Lvg+AsDQUO65m+3FkyVQDP4XYbWhFmqXY52eZLZ8W9yhggXB0qxTRRmUCHyYK4m7RosjtC3U1WY2uLO7LndsN+/e8owgfp0MT67/v00WtZlSxr/NxhS8plgECnvgYeK/gFEvnROXnf7Dug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:04:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:04:43 +0000
Date: Thu, 26 Sep 2024 16:04:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
	iommu@lists.linux.dev, zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 1/6] iommu: Pass old domain to set_dev_pasid op
Message-ID: <20240926190442.GI9417@nvidia.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912130427.10119-2-yi.l.liu@intel.com>
X-ClientProxiedBy: BN0PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:408:ec::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a591af8-483b-49cf-b864-08dcde5e145c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQv/TLflEtDP5ZodoH0puq/fHzq4tv5jXsS8Hr+ujbrds4Y5wPfINvr93iMA?=
 =?us-ascii?Q?BEN5tg77z+tjjcolCoVpQIknKNPw54ENMvFhpl1tIpowVOx7FP2vgUOJsI75?=
 =?us-ascii?Q?RbpPeNjvgcN0BHSiaE80BZBs0wpiVOACRVX8dY6xXydmQFSCrDWhEbUzQKuI?=
 =?us-ascii?Q?C3UZFrFslcgsd9mJI9BtO4PgcWFg3v9DdlJCxUIxrRbEozrqqRRSrcz4g94d?=
 =?us-ascii?Q?EUss0uMDSRrXP1hTxy36ptHJ4wAgFMciuSBHs3jThnY4T3oi5VeO/c3XbNWo?=
 =?us-ascii?Q?y7z9R8GjIj9dIpmXos5WFFu6eeA89jezQBxpcNK6uOuVPnunLOdrvaHZz52U?=
 =?us-ascii?Q?eTliomkFADy0SbLwoow6FQWQW2KrdxjPbbNPVBojvFN3yQqi84aR+vaZY6T+?=
 =?us-ascii?Q?GrI4Rxc6LoU8shMiB/2aTudU4vSKcx4PygcJ5COAwJrDZmadFs6GKI51J6Wh?=
 =?us-ascii?Q?gdQqwQBkWGd3OAGRil8P5RdoT8yXRZBsHcREYQFStOBeDUytHBVNXczvYpoC?=
 =?us-ascii?Q?Rx1Yy46lpxKcHFbOEq8sxWh+ObUZPW+784C71MnVamFeG2AImC4uh/J/cG2l?=
 =?us-ascii?Q?uYGs5oslGMkwpiQJK36EZMUHgbl7PLmWB75l33kKlUmTqdkqrHrT52njI87L?=
 =?us-ascii?Q?WjAEVxurf5RKc8oq6nJj4JhR6o26/ljEqiyGS8NcGGTNPUsZp8cWTULCirro?=
 =?us-ascii?Q?b8yVhdss+C657qvWwaVsforrcc0Oskoyh6wmTNzzhBwDM1Ut4VQ1wVFeDA8k?=
 =?us-ascii?Q?tmyYkGBSz/I3YVOJEoNpdEM8BLlLI5MNjP28yoK4aMY9xHU0P6PdEgAap/Z3?=
 =?us-ascii?Q?7Xi/2xQBKIEGqfHvJvAnlRzUAUGnYhcQRkc1zXE8mVDArQd1beI9wtoEKLiF?=
 =?us-ascii?Q?UWgo3ShJquaSZeZSsQ8YBT8Ytop418fN40fCNqQCclEBHxiImRju5MYFHt2S?=
 =?us-ascii?Q?o7SK2AbBIHMn7xcp1Whvv4/9yKo6ZZMZiRWCeTmax4/Ua+/ad5kEaCak+ovp?=
 =?us-ascii?Q?uqmLzrAHg/UwG47ICL3pNlR2I50V+cqg1dcAFzv946P82LiOng5TVw9vO1sn?=
 =?us-ascii?Q?IJe4Rh28PxnK3pmBQNIaoxwtJLSD8d9+NE70ial3+KsQJyz+ke+o7hoQxUcp?=
 =?us-ascii?Q?l1yZLt5cqbhIlTOz/wO0b7QxLtSgPce8F7cXqcTb4RsAUjwnPW2G49iyR1HU?=
 =?us-ascii?Q?SRijFSKmm8GK8/FeItkbukV/c117jGu2I++Z7AdJF2hg++Krl6BXV9qJjah3?=
 =?us-ascii?Q?UeaKbLveqNofXYMiP3FDDlzfBYx6nEYc5+wtA7qEyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JaRFpCYrIittpwVvAxVsCDdUGUyVau5RQH3G0WhXdRhHHt7ipGoNrwHfK6g9?=
 =?us-ascii?Q?BS3214wQSX6TQtsSHJlt/KZM3fetLAuCP7EEVU2SpWP8iKfVmwfugw2RB28I?=
 =?us-ascii?Q?rxbE/UJLhWdnLlVXCX2fmGfp6GTTYWuL1R0zHRJoAafvxStSEOIe+axEmFH1?=
 =?us-ascii?Q?JJIeNuCxv+jDHWHQwhZSFHEmP9LWLwlmGdqR0qtEpKIh4WWj4V2tS8JuocUe?=
 =?us-ascii?Q?YNinUMzRX/sRFj/DVi8mVHDtK35XjKsIcXDH1qhIWSYSGwU7AZcS5TmNuzJe?=
 =?us-ascii?Q?Y7dRun8lP3XDi3PJnWocO2wGqzXcR6wRFeMSJj14JXE4qTCM6XJnc7Lxzgtb?=
 =?us-ascii?Q?/uLz+RAYa5LagP38HzeL+Hs6JThKHWkLNum+P5ObDF5Vfc4Q1T0qzn9AGxhy?=
 =?us-ascii?Q?liS3piQgQixT7HlPt1TEOrTFFoO5dT9dRQLZSB9LDev/gmuPSPmTK9rEPbZo?=
 =?us-ascii?Q?D2LxW4Dy08slYksXE8lzPsCGL2Yfkc9LV06lhB5UJymV0CderZhSmVgzKwqt?=
 =?us-ascii?Q?vlFuqlKfeYFmvDuDP/wMo2s22rAe/HWG7Qq0E9pgM2pYq+Y+qy6M1OgM1AHu?=
 =?us-ascii?Q?PwI7BLpqmoy+72GR2VHNOdY8744uY5EXJGG0ItEduwwL2gN5z+jtkMcsHrqM?=
 =?us-ascii?Q?QVaA/TpcuvelRVtWH6w5Z0hDjMtVq+CNmrGlAa+LaygqAvEZ8Gsg5KNHd/2x?=
 =?us-ascii?Q?DaT4AnX2cOpavxIVwjcveAFK96y5UChlh1Hgu31OZ1XpalyPY1J8uV7Nu3tE?=
 =?us-ascii?Q?CXjZAKUdz+1bR+jPH9CR/vmf4MJYJJ5jAHErCsoI3iMsVJP2QLW9Xka6tfuR?=
 =?us-ascii?Q?mEz0BDCQB0xsKHmLERpFe5lQuBkFpxF8mTvRWFPPaFuRgp4VhGoTP4/JazQg?=
 =?us-ascii?Q?29YYyxSV0p+cjEm8pc9XYIk7wjrIrh6LdQV180b0O0umeGSTAEqYOu558VHh?=
 =?us-ascii?Q?HQq9idyIUfCh8jIMq9QukwepisFtqzhKcstTe2dc3wyuZBINeloyrl9URIMW?=
 =?us-ascii?Q?raWd7O5kZzch50Kgc+X2VtLeRq7eLKLzufePOMI9iE9s6vGftuH/qSYH8H+w?=
 =?us-ascii?Q?B8LdcKwfegfPCcDvncixjCVLU8chNxykl5/tZg3MSA2VDVKB1Nhb1h8Mir9U?=
 =?us-ascii?Q?RYK45yRiqZGFLWsGu0eq1yi6RftpyCBzNyEVQYXU2i6Z/4JfyoKrX6r7PNJ+?=
 =?us-ascii?Q?pAzy8kMAiKaSFzCIr+U035AtmlGy9vwK9bTUoqpmGpBPTgojGF7OXd8w8QFc?=
 =?us-ascii?Q?dadk/9+3ZrVAes3GebAdiJLPcm2+N/UXJ9iThpA24xPxBFArsDfTjIBmYPD3?=
 =?us-ascii?Q?lI/uAByIKp2rSjimKAWLXQB2kEeajjxyiddzhnxU0yuqi1/MVEKgiRxiDd+h?=
 =?us-ascii?Q?FGU7r+cs6A75EemfyGGTj0DrTyPM5zNODYAo/GGzU1CrZWFR44ilh8MVkOeN?=
 =?us-ascii?Q?hekybVZMRCRmyBe5alpKb4OnSJeVuGo3Q+wd3ZWdpk0WQKRh2fMq9k7e1Fs8?=
 =?us-ascii?Q?i2NQ8Ek+2x8UQ/TL41swSgpej9Ys6O6laZ70kn/vfIWd2ApfSTlmi6cYkJzM?=
 =?us-ascii?Q?7vnfDzzxBQzcUlpzPUQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a591af8-483b-49cf-b864-08dcde5e145c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:04:43.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXBvhz/juiht9GqwzNFJ1NLUGBh6eJ319NMkC3+Rceg4d7MJTZU3RRPnhDNDdvqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

On Thu, Sep 12, 2024 at 06:04:22AM -0700, Yi Liu wrote:
> To support domain replacement for pasid, the underlying iommu driver needs
> to know the old domain hence be able to clean up the existing attachment.
> It would be much convenient for iommu layer to pass down the old domain.
> Otherwise, iommu drivers would need to track domain for pasids by themselves,
> this would duplicate code among the iommu drivers. Or iommu drivers would
> rely group->pasid_array to get domain, which may not always the correct
> one.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/amd/amd_iommu.h                   | 3 ++-
>  drivers/iommu/amd/pasid.c                       | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 ++-
>  drivers/iommu/intel/iommu.c                     | 6 ++++--
>  drivers/iommu/intel/svm.c                       | 3 ++-
>  drivers/iommu/iommu.c                           | 3 ++-
>  include/linux/iommu.h                           | 2 +-
>  7 files changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

