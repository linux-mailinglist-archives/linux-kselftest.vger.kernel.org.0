Return-Path: <linux-kselftest+bounces-17309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746796E151
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F28281A69
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13D1A38D8;
	Thu,  5 Sep 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EVrQkhhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C915350B;
	Thu,  5 Sep 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558214; cv=fail; b=FqprTqYJCIPV26A4bM1aTVkyEFW5wsWtxt4izi7Ngo8M67mVfcUAPeLzF3f6WZv4W/wxachDYfV4ndufQtKH62Rnm7onU7eONTZOwHTDSM5u9FjbxOrbSl1dLiqgrUqj/63dQw+6FYN64Dg7HfozJ9wQxkKWLwz8hLHUOTOoSp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558214; c=relaxed/simple;
	bh=ESNy2Q1hPK38fi/Vsca+YXTs4fF0SC6VRJExwN0Gkxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orXu0ZniivoX9Vfo11Qlz1lYATxhxYCptf5BlcaA9PIHeThvyYUEGRYboJfW0SNvAxwIS8riaZOsxTmMkMYayzUTwtKSBACEJWzkvYuUJzgTjlWhS1wIdsQ1XQhH8xq2lAQ8gb4kC+6S5U0o/dMJ/gYUgA7DwC+LPySBLXFl6hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EVrQkhhE; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIhi+wd8570AH3N329XKLDPzq4H1GMXXy8+TUSFS40WM2tnXR/G8JRNA1fNh2dlOIshgVlkPE/p0yPG9tFMdIRGK4LCT5blijgdGLs71vZKdkZwTFFGs1GBvFv56Jdqeuig/Y94Aggc4q9mOzLCn4/gTTotT3VrpvQy6d8+HANe9rNOaIOAl0E7+lSxXmBvIzAfvhK3x4V9ayfMHCsKzvoWJruuCSB0ZCpDM4duLvTADeTY7GL7C6Y6uWB0zQr2X0fxYcQPYixroa0dzzMg3GkoUD9B/GlcJqFt5GcN/TLRNtqx+tKCqovxY+qlCBjcri0WrtYZXQphPjpHpO2Wnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HEG1zLe5xmZNnINQ5GXsJlN9xnyDpMmt8rpYhJKJ2E=;
 b=aoDmYQdQrBFHxdAzyXzeb8Dkepv9TNOGmICszI6t6CFDlgkzZZCVvBUiR2RMG7AanZVOOxMNtcylnpZQqcbp9r5L90itd4c9cPxt/nMom0t/KCZpN+TX/xQ+RUHH+zw/KK6Wodp7yC0Poh0766B9fKj8taM+oa3T5i3c7kgc9Cbf8sdHkWM/sHIxDoFL+L2G6TU2zzuo7dpnPbec8jRhm2Cx/rgQ8OtfqGfU9eAzQOxC/yvxR4Jb+tzwcCR+7nhpef6NCjTvJjvMesVldZjQivD2+hR4vIL1z3/dpy/2WZlY+pXmfCeusTDSSJzzYEIpa+jnXUBPi0w9DNcC9mLDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HEG1zLe5xmZNnINQ5GXsJlN9xnyDpMmt8rpYhJKJ2E=;
 b=EVrQkhhERMpyKIv8ULLOAglgODZ6cUcs1BofeOMpVtx9u6Ua5lPZ9OrFqLH+5rIA91xI/YB7ZrQkgF4V46goR6UMl/g1ioQSqGSxDH3en4Pwi21e7EjySE4jVqzX+8y0Xbhyoe5CiMP4ZcCLo/I8fwmCssyHhA4xq+plALxc7sRTTnJoxaYZtPqbxduudVEATrKXBM82sH0xWAGzGeTxgOwn8qomxBClopcMLilPpPTje1jAXGi2nmeGVDg1sJOLvQii+jINK+0FS/0YPzB19aaSKnYelWu2CXMYqbwxRBf+A8F6mTrwd7XzWWObyS62fq38sMBcQ18lJ1VE/FjoEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 17:43:28 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 17:43:28 +0000
Date: Thu, 5 Sep 2024 14:43:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240905174326.GW1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtnsaWgeuuy7+cJG@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:208:23b::10) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: c9752be0-9fbd-4cf0-8f25-08dccdd23ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QE/3e3AsA0NYFe9AVCnAQRsNgGIs1V9KA4Tf4UNl46qrR4cTCQHWFj/ellGZ?=
 =?us-ascii?Q?uN3ZJpuw4D441Q30LeEjdIe+yX6iEqTswDRNadizcq1LXT3kq+rxDberErve?=
 =?us-ascii?Q?FlvO354KTrix/xhk+hiDp6iAG7cdEQRkmyL8o1K4m0P3zba5Fu0gz8/8G48P?=
 =?us-ascii?Q?1zY+B1zZbM+ovcf490pHOLF9QANheWkjctys5Qevu7jCa/29A2ODDvfaZ+OO?=
 =?us-ascii?Q?675SlQyCDyajuqsTtIDkla3ApHNTgAvhxpPCLU8l/EjONHKzWW8os7aH29Sd?=
 =?us-ascii?Q?llcXjONFFQb1GcwuPcbl/FZZvKEke/XswLyaCgRDiqQ1ReKnp8scrVxqmJ3w?=
 =?us-ascii?Q?fdJPEd7zTdOAHWCbFD3jbO8tqMckcX0QdPuUQ+ALezlprkeMwG3uWexWCtAv?=
 =?us-ascii?Q?U3GdCRGz1yM4F8ixCxGIHpRCnU2bLzhzd72BhBBseWq+ZxxkKd+ciWIfZIIq?=
 =?us-ascii?Q?hBpMW1p5KVDfVz3G6kUv0QP/VlbAnJROtt3cYleV8VfplXf9tK7d3JU9PgV5?=
 =?us-ascii?Q?VZpKLeeJwJCPWtPXWW1O4S9u4OTzBFr9Dddoft0JIQ1eqYvuQwcMavqUsoy4?=
 =?us-ascii?Q?NUPZG3mUdmynEL3f5kAOvQvJSqLnehw+7DKI/07AGF7VMJE939+AFuu2EV/9?=
 =?us-ascii?Q?ezzXrS7YpH+9MTWHs2jT1Wdc4Aff/CUS5rgLOgb4LfV81Ci7If+jGhJLZViz?=
 =?us-ascii?Q?R7NJCPBshbyFumwENs76Zg+tM+EvlRFaVo5XBKrVSTPKVgtZtCuueuWb4soe?=
 =?us-ascii?Q?AW1yfqAxc64P3GS/ds+jERbDogj2/Kzc3hiDQvQUzrhqUsPp05pCg0bNIC1D?=
 =?us-ascii?Q?Ff1M4UW5DJpIp2m2uZeD3UIzyb73IsF1rMU35UswluqkdVypEwm0XreOcbjg?=
 =?us-ascii?Q?UGGcuKJ3huPnNAv0lh6wwwl5Vi0/4mdcLXKBWWUeVqCA9lpK8WmiTb82WLXw?=
 =?us-ascii?Q?WKv6UjJhFyMLpxLOoskTqrwRifdyzn8Ftd20jTLL5ldx2aK402ohIzLQfkSx?=
 =?us-ascii?Q?iUJ8iBkoT17KnQuBKPjxqtjgoqBsrPS13Aa8hvw4msk/iqA7lM3KS4A01eDx?=
 =?us-ascii?Q?73/snA4CxJfdzZ/RZeZMkNpBp6MB+LRcbhskf7RbtrtpHBdtdqHxdB+Db89j?=
 =?us-ascii?Q?1371t0pnIkNOlFGa2b2UWDResp6We5oQOuVsqkMp8p3D+QPzHq7zc2g+pUUp?=
 =?us-ascii?Q?wbD9/DqmwJcav+LtltA7qB8pTe1KaVkPsawGb8bwfvbzLJTZ4u86EehzYcl7?=
 =?us-ascii?Q?yqSR6jWadc15sJYw56SCCi2PVQ+Q6bCVGGzXzqplPpXwe+bVOA2Ck2HH6U51?=
 =?us-ascii?Q?3SQMaIon5ga4GIgMHVXmCHPGtDQ/Ev/JWjdGQYDF3NXhrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?af/nTQPTvCBOGW3qtCOr5n3p6G/Hb1JxZCmbk641xeB6POq2hwvUfwP+bMx1?=
 =?us-ascii?Q?cVNhJatCdqdHuu1uohROV7NToGc/Wx8vU24/ofSLMyqTaxxvaoByKsaCKGWu?=
 =?us-ascii?Q?5ioHkwtAhFwrry7wddQ/54byVB7rDO9+XqvNvyq3TTu18wqPA4IRNVg5ZXii?=
 =?us-ascii?Q?2HttIrO/wZWTylB+O6dovpMqToIOKamA4frC5SKKLcKO+ORZdvTaQOYfr5Z3?=
 =?us-ascii?Q?6M2nMyBb65I/ae0OvY3z2pZDQmDIhQ5iHWfOceJXKBc5GaWJOq5vtyC7Qpxr?=
 =?us-ascii?Q?R7QgVE5ZL2mHQf/XOA75C0mu1GKVstnjC7Fd9Z5+VKkRfCk8xrRF9ta7f3l+?=
 =?us-ascii?Q?PaPTRrK5bCb2MNAYlD7YGj4tvT0Ix53xn9O9vhU80jxcgzO2DXP3HlOPI3gX?=
 =?us-ascii?Q?iSmxsvmWfH6Q6BhQ6kd9vEjkWjfZ46KsY6FEkMIgQYTR8YIgD1xcJF4a+LIQ?=
 =?us-ascii?Q?CmxErRWJjj1RY7c9QRs32v15zd9TTVtzxNHzo99ZXsEa2xgs3WlJXS8FZKfM?=
 =?us-ascii?Q?GR5TJabB4Uyqtex+3k/iHWoWP+PsnJF9cBFoeKXDA/uefmiprYQ5cwSgemoj?=
 =?us-ascii?Q?z4gQsmYZBFWmJ5PJPdTvHrSjYlUrlM5WvsZOKNFOKq1BupJUstumv8UJWz65?=
 =?us-ascii?Q?vsqem5BOflIUIpFX4pvndO5v1nOFpal8jPpbCxi3OY+vw2DRg9JcXQbU7c8k?=
 =?us-ascii?Q?tzenFPe8Fc1DCF+vJ6TBudX06XAI0nqSFd9n8SfJ1IVtUgRQCotbbjvf9SBd?=
 =?us-ascii?Q?9kUtE1KTMkL9Qyuw9lO5Zh+97Ys3IGI8qZ1xyKf2YN5DWmK80/nGFDy+OON/?=
 =?us-ascii?Q?Q8H/ZJyseEXnv6uriODpdP/h40GvI4IJ1XcNRha3e1zMGFhSSz5XBlqiI6Le?=
 =?us-ascii?Q?Q186E+CriuNANsVtS657q+9lSEdzHp8wviuA6nOCMC5ZRN8ifdqOW4KFqNmN?=
 =?us-ascii?Q?Dn8d60yp7dq+NRHTrIF7PC39htit5HUtGyRqx6ofNxRYMksyGthh1OZAkIK7?=
 =?us-ascii?Q?zujIPaT9+tUhqGdC3pGDSW4nGydD7vUxBI3Yn4NbD/4BzL5R05slf3HHQLzq?=
 =?us-ascii?Q?HmgIhwHtTje/Ir5Vy2zauU2jvHsTtSo8np5GO4l9srROH0ZQlKsk9gW5nHJT?=
 =?us-ascii?Q?LgBXQ3ZuETpBX7udIw+0LP+J87DBLgnst4UVrPaS+Lif/qG3aH8yJwHpEonr?=
 =?us-ascii?Q?Mm8LE3NuDC35fFWxzL1n//96uBm/UXH8E0MJ3ENTG4vFlRCqklTImWER+R3X?=
 =?us-ascii?Q?tRXjFCpMiHJVCG7k6jPHn05yR94r9G2xnliyUeSQufuqKp8mwqenJN7cDryj?=
 =?us-ascii?Q?vbjQpdNUk2ykaBYjeyShbKth6ocmumPrDt1IHKz9hcb4ewrAOko5HCdzyFmW?=
 =?us-ascii?Q?HJbhpyb8RM4tVfK8Y1Id+4AEblRUu93v5wbw9It5jdAV5+9/2xvBS6H5he8D?=
 =?us-ascii?Q?vdvPb23/DDOkzZUCd3p28KaikaFH59Jo0p0XtywGqk6YsdRRAdzxSmKlD8h1?=
 =?us-ascii?Q?2ssogkibH2CbIDQhrNIomAm10EaCXZmMZ4i3a49qUUvYqAUSLh09+gNrjlJU?=
 =?us-ascii?Q?DmSVXazmWFjRewaKhdnX/bDm78oZU+Lvb063D0TA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9752be0-9fbd-4cf0-8f25-08dccdd23ff0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:43:28.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWHJdx1DJ3Zr8oo/msyqyrKHRWeLlJKPbA23km6+U23HmYI0owb9bdD7ZLOsames
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

On Thu, Sep 05, 2024 at 10:37:45AM -0700, Nicolin Chen wrote:

> we only have virtual device ID in its data structure. Also, the
> virtual device sounds a bit confusing, given we already have idev.

idev is "iommufd device" which is the physical device

The virtual device is the host side handle of a device in a VM.

> That being said, if we have a clear picture that in the long term
> we would extend it to hold more information, I think it could be
> a smart move.
> 
> Perhaps virtual device can have its own "attach" to vIOMMU? Or
> would you still prefer attaching via proxy hwpt_nested?

I was thinking just creating it against a vIOMMU is an effective
"attach" and the virtual device is permanently tied to the vIOMMU at
creation time.

Is there more to attach?

I think some CC stuff had a few more verbs in the lifecycle though

Jason

