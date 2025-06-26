Return-Path: <linux-kselftest+bounces-35862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB6AEA226
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35A25A71AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F42E9751;
	Thu, 26 Jun 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sXA/h/wP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE12153C7;
	Thu, 26 Jun 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950281; cv=fail; b=VaYEkQVxrf7YBFcZeMlpIaTM7Af89m22kl7H+okegLsBxeAPi3/ZE/ethlyjaV8rVlE128qZEui9SA0cnqS2xnmjriKNUIvFGZj8JgLUmS0tRzODNLhtd0DOAgHIVYyjZb4o3uMzfnVIklFy+NpSJyl45/dqQtMvaq4QthyyYl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950281; c=relaxed/simple;
	bh=kyB7cNVGXzOYnHkRh+0TNIY7dqp0JzYgLMEsriTvd9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jpFJJbmnTHsx8v24tcyCAsPh8PUwg8tHksqdat2B10zsz6Yc33zKw58y6cTVKeq5dqiae0VmwmDJFOqlRL4f6Z27mSCuY3aPGVb444C1Lxs+Kz9mIVYrBG90UzYM8ykhJnNai3t7+6zQljcAdBc+aisV8hzspFtUXyGnz86dGnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sXA/h/wP; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pq3ZEbNfUIhhxLw0wtwYNeHPkBcT7W2KiIRqyfiZO29MyZpEkJha/ZqXDGCB1mUIPbsCzuYlNmIQBXptUOYLsGXaBJxeKDm+3P0zQiBsyulXfvgZ+f/AOgJAb/X8iayvdr++CwgQB5UlYRC5BFK/zULARo1BC8bTK4mbVnZ1L2tCOnByVHkfjBufFqf0drZS0AIPkC9qpfGrNIxK3LCZaV2BbKkZDFh2sDq1FbN2bJA17xL7PbKzKPCOaPLXQ4MDywwdHqNiEibatFNEKz5lWPFe0iJTjRfMMWloYliam6lJJo1kLK+gwLdZaAlbvC33+md0nOOJz1RP27/E+cbFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcl15vk1/lkqUE4jIC7djZXWxPkEiy9KqO92HXC0UU0=;
 b=jDOPOcrsEM0EQfgJotxDva3jLJIKi4AzdNU6EMvKayzQo0Kn6iVaB9fyfcyIs9yqxGiQW7DiD1F0JUMdiY4warL7A/drjfnP14g+gkYqrcgFExCVDcmP4Wfaevdej90iTa5UEP3mmwSnPAXNfGwi4g/9RjXebGWMzIwUEi8IMXmNmDidVzUzkPdyxLC2LN9M0gkWYxMMFUGqoT6TgdBTKYifQTdAgwu4MXidHaeh1LQ+brA5qq9go+mZLNiGf789X+uWxBX7uOBeR2yGNtA759+TYcFhwf7J0M71FyGqtVjC4/cbjnO22PR7UBW16pu8fQkRzeuTZdtanOphodVTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcl15vk1/lkqUE4jIC7djZXWxPkEiy9KqO92HXC0UU0=;
 b=sXA/h/wPtOgZapUiHsgn15rpT6hOgktip0WC5WitUmgHzpKgaWHdNKlpsEpLW/zZXothc8y1EgaDyyspjpp68C02hZkCm8hzTKom0OYj5lQf6NrvY9Y94l3QIRH2RB9vSTngYYwSBM94rABbUDn+UM49hSU4XU/p/x1bp5C1L9vZzTMGASFU61jmX2io/Mt3njDJds+TXia2e03CRn4sUR35wHSEWBUt3Ytmp0t24JL0mYxTQzOsCYWtgCCb4LkrKkqC0wWElO9/3Le3L6UzfcDNh+ecLf3zuRavaal91r0We6JjytjFmXNeOAohAjwo3HpEh2E93/tAVlbGMznWow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Thu, 26 Jun
 2025 15:04:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Thu, 26 Jun 2025
 15:04:36 +0000
Date: Thu, 26 Jun 2025 12:04:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc v2 0/4] Fix iommufd selftest FAIL and warnings with
 v6.16
Message-ID: <20250626150434.GM167785@nvidia.com>
References: <cover.1750787928.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750787928.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SA1PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc4f2b1-34dc-4d46-8f19-08ddb4c2c416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5yeTKkaCe0DP94SnFqJzlT7Jd0zacWXZxj6Jbnh7R9fv6q5PgsWqOrqkLTl2?=
 =?us-ascii?Q?JbIr0yzcvnG1BbEDQSOdUiLBbMTtZIVolOc7ZVk7n2xvvre1+zaeuWTHIxEw?=
 =?us-ascii?Q?qcKEQ6a7/Ns9GbzzXQS+cVOVf5wHt4M/r1/eV0iCHgc600HDKRmq7GltTWlq?=
 =?us-ascii?Q?IkvUndKd85W1wy/8volPNIX69HPZvhBHBL87ca5wmdQYCiFwQBNMgbJTGZGR?=
 =?us-ascii?Q?oE0oZmPiYmtDOfsNZdodUib+2eGqFIoT0GISdQ3wYOe4zinJi7cFQ6senm+k?=
 =?us-ascii?Q?6u4pZ4giv/TCcO3K1rF3CBiXRP2KuLWfj4BLb9tzs6bXqwRj+nghFxV5hce1?=
 =?us-ascii?Q?hU8lRqw3AFNfpnaJkidBAgnRAVmtGPpJiEkXFFw9q1pKsTEmklWNN5O0Mf9N?=
 =?us-ascii?Q?tbB/WtsA+goAht12qITv2xQ8mEoNpkMzGZDgNsFGhyZb4FkRY+CzMvpj1xZq?=
 =?us-ascii?Q?MvcJ+d2Q3uRZCE6JFiKJiXREsNkE2PgqALAvVrI6b6hco8JzFSvGLbOJpR7Z?=
 =?us-ascii?Q?/Jovj7zALUODAUN7at0iJHXbLalUeNOlESvs7TTEAE7oPcUp+NiUY0q2MI7r?=
 =?us-ascii?Q?6Ww6sX7vMhui3mHLVLPaHhki35hgEXJupid6+xIMkPruo+JcAMz7unofGT0b?=
 =?us-ascii?Q?t7nzYrATncwf4frtYJTOLrxGQsqLs/Sw3T64tvcE1ZtDoMPVNWn9xoKsEeNn?=
 =?us-ascii?Q?cPSViwD2CaVRzhymP3d52fOrmWxfY1pD7bsB5pAZfulHSojQ7gCuvG4+3r42?=
 =?us-ascii?Q?x8cJylkOVuCXo5jeZ+zUt2LAh9DGg3q/s3nUV0t2PpFoZyXFFIM6AzSRrUAj?=
 =?us-ascii?Q?YPv0HGcUd3kiKtddHiRA7mdAKOfhgjGw6BEc2SuogL1bQxAkWUaCEcf8xyJX?=
 =?us-ascii?Q?JsvhhoyHRZ20a7BCZ+GUs53hZ+KrfGRYutPC9AUlIoKWd78AVntvx7CkLVil?=
 =?us-ascii?Q?UJAT7p86b+7plt6FZ0EgFLJtwRrkxHEGChKrezirqPPsA5uGtR+7GT3Pt3Ix?=
 =?us-ascii?Q?KHAM5UK3oGabyMz7+cAUfqXCloDxWrXQY0L6Fhab/Bhe4BcRGwTyEIMX2qUF?=
 =?us-ascii?Q?8ngy30iasLrAKs57kiYm4+CaVk4KZhHDrkfS7uAdMt9jqB6GfQ2Vkg6G1ruh?=
 =?us-ascii?Q?tta02HYOYLVldxAVxjFkgg/2qfz3hl6ApLegnpUSrdHUm9m6nozR9NLlhtqM?=
 =?us-ascii?Q?lAV/rkY+/aiXIejvCpsLPbPv37ZQf4NM9yRJbmIr6rQ/LLXCm9lBvB+IDkip?=
 =?us-ascii?Q?rrb4y7/9WPGa4M/GqnQyXMYQQ/DdEdfYyNClldpG2N2TXyEqLm55MBa0J/kV?=
 =?us-ascii?Q?hCVMKuLRa0QqaYmRi575EDMVkT1M/d//b3q1ieVEroKRnw7vR2UCb8uC6RTc?=
 =?us-ascii?Q?jY6L13Y40b1pFw2ifGb8zLmXKvovaOwYmWpUnktPoamlB/yn4YDDWa1p0JG9?=
 =?us-ascii?Q?vl/No42TgCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tARmX5k4fMabD4BBk8hPKju3sPE6IZRP6nSmRf6Mxl3SaaqzlBpMzJUX2/9S?=
 =?us-ascii?Q?IPjJmkcsSkZYE/E8cmYO3qO4mqNwbDjWt+YumDuzaVX6jzdBeTdiF6bkk26I?=
 =?us-ascii?Q?e4gijLgzFhjw5x4DxuUHK0n6zIcMGjEWdWwMp7JMCKU/jb7D5gFIV3X018w/?=
 =?us-ascii?Q?7LRRXbLvMNUi3efN8fKElJtgA0tC4/Mialpkkq3OIYRPXqU29flwzH0x+80b?=
 =?us-ascii?Q?h0rP449Ofw9WnrC5lofcf0Zi0ZY0GVRy8o3b306Ilf8GV5r56VwV6UzQ7+st?=
 =?us-ascii?Q?0R0tuXSI2j3EOAZ9spVGXGrpsYg0G2rInSsz+6jJSoazids1+HQe/DUV2vgK?=
 =?us-ascii?Q?Uh4fI9ZeYNFk/V4IDIAFGlOyJeQooRfiyoOu+vlomvXPPknmqzPVyET7YaPd?=
 =?us-ascii?Q?dmkdJtSBy8+WzXzM7Kpws+DJPh/pJS2o/+3iaK7QH2s2StaAy165sxBPVJ/2?=
 =?us-ascii?Q?L6g5sJWA8cL+mtUXd0HHGNw6DLpXjiPnrRhZye0nvandHAEPy079XfM2CWQ5?=
 =?us-ascii?Q?cEXw/+D8rhO70bh8mnPU9naCqicHuyiYl4dj8YCSypVG4fqu1VJf6xcgX2n4?=
 =?us-ascii?Q?vCrn8KLVPmoTpJ28qF+abtdZ+549lcKTxsMckJX+KwwTRfl+kUgTy5Y20agR?=
 =?us-ascii?Q?BO0wf7GTFWZQp/WgATSW9O7Xb8X5SKydM20Wcr3S3wa6Z3W9/KOsNpHOWjL2?=
 =?us-ascii?Q?WuYF8L4qpinsRIAuJjtP9OawR4ZdM/0/wFr72EcvL7sioenO/6m8GjA8G98F?=
 =?us-ascii?Q?gWoBGkmZG2kef4DTHFQZ8QqFXYx/Js52wtL/KP7TMzNv/fYDpl6Vz4Iy6e2k?=
 =?us-ascii?Q?Q5XRa+KybT0+0bPwpf3xbuS98MGH/PoWr03qnX1EzlEZPqYUsqX6duBBBmV+?=
 =?us-ascii?Q?b3SNXFdHAwl3+mkDsT8bBWLngnDdfVa1JOo8Ow90lghn3IEcTXeBprw+WUs1?=
 =?us-ascii?Q?wfFng2JMcqtVgT37X3C3yVMksGj+msV0duHommzZe3GGIyYH6ew1lUBQnzIh?=
 =?us-ascii?Q?JiEUUHIgCzuAQ7w/dVhfiXK8iw7Fd8B8vjeZVETGS0CRXhFH8SgFCoTU8U9S?=
 =?us-ascii?Q?R7Ojty2ZI+S9DoSHaK9kdAGGhGBRxs2Sui2AELUGZsbiEOvEZyN/5Qb5gYMP?=
 =?us-ascii?Q?8XVMrFPVwR97L5toAHgj8L1fXx9GmeqAbP6VNGwnufvVhSg+yH8gZTGElsnR?=
 =?us-ascii?Q?/wRzM2ybInnCHbWPHBe+zALNsWN9Hz+PLK9q4jWaUB6jS0C+TQEvYlXIaBCi?=
 =?us-ascii?Q?kQCkiL2lYwxH7GpeFk3lgt8ppeo4FUK3TM2m6Nj8Gwtk/V7BTrk2FQANp0OQ?=
 =?us-ascii?Q?JjPZ8ZecU2ZBW8PFF9PDlqprZk/y8Nwg0W7FYDiOuhmDIIJVrcCePY48Vaxf?=
 =?us-ascii?Q?+RUkhT/rToeKuaPF2NwCAxKTLWbibwuG3YneoTBnMtZdc0OahEbqsSmUTrMR?=
 =?us-ascii?Q?kil5HUcKuc9FKa0u3u0igr8dk6cdTkbsi4qi5dC73umgPQ9vBGCCxVnEZ3jd?=
 =?us-ascii?Q?HJEhi+CsxOBWrfPWTFtJgtQZQVPvKxoPAc6qBqcQJti5FOLUuv32iIBYqb7L?=
 =?us-ascii?Q?0n674zpgDKnrQdu+13bfpRaHhU3LqaSuGlmt4HsP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc4f2b1-34dc-4d46-8f19-08ddb4c2c416
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 15:04:36.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvQzrvW4/eaxNPdVq5q0HoUxzVndxl7Lfv/o+BpJNNUcMuLY/1t68AKhiQ7LkQpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF

On Tue, Jun 24, 2025 at 11:00:44AM -0700, Nicolin Chen wrote:
> A few selftest harness changes being merged to v6.16, which exposed some
> bugs and vulnerabilities in the iommufd selftest code. Fix them properly.
> 
> Note that the patch fixing the build warnings at mfd is not ideal, as it
> has possibly hit some corner case in the gcc:
> https://lore.kernel.org/all/aEi8DV+ReF3v3Rlf@nvidia.com/
> 
> This is on github:
> https://github.com/nicolinc/iommufd/commits/iommufd_selftest_fixes-v6.16
> 
> Changelog:
> v2
>  * Add "Reviewed-by" from Jason
>  * Only use kfree() in the teardown()
>  * Add an mmap_buffer_size for readability
> v1
>  https://lore.kernel.org/all/cover.1750049883.git.nicolinc@nvidia.com/
> 
> Thanks
> Nicolin
> 
> Nicolin Chen (4):
>   iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes
>   iommufd/selftest: Add missing close(mfd) in memfd_mmap()
>   iommufd/selftest: Add asserts testing global mfd
>   iommufd/selftest: Fix build warnings due to uninitialized mfd

Applied to for-rc, thanks

Jason

