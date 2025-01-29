Return-Path: <linux-kselftest+bounces-25398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51911A22506
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63BC167E38
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E01E22EF;
	Wed, 29 Jan 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6pf27Gc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416FB641;
	Wed, 29 Jan 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181763; cv=fail; b=eeD5BElGbM766/Rkj8Y8uQipijCmtcbF524fwq9fYc0a1NupENVPP3ozC5s7/J+1hvcD82Sb365KsDf0pamPV0crXEbpk+Davd50l3wwDfXWU4RADpXUT/Kf3pP3FhWmnlQsBaBa1wvFnzPOxKBEYAx9H8Dqt+RmAnExqir17G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181763; c=relaxed/simple;
	bh=IrAGjEmC+j/EufbrqE6lsZ0ncyjFlwRhEBDouiN9kW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HuCpbvIIufLXdV4NjrSf/vyOCKJcd+PAHq8ocamEJyStX7m87IgmQ4CblnP2/3hOPuhTOmyJy49H3G0BdBvS6UJRPof5VcPEeucUf8dtsAPqYTVc1uDIRlJJ8gM0A29rMBQTYARpUhyIwj84zul2Kg2PLwPc+AuxHYOooc6mMCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6pf27Gc; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cstfM74OVCZlpSovVQt2wQ+1DfroS9s8y8xOKEoouaHOn4HnQKvR/4IX1lumR4QQdfZI8lQ0EV8JhIFN2axTA++fBgz/T9P5EQLnxLk5fhrKamEFsmndCQAxtiFRQPa+gziUh82096y53ZmnoWeQE5quUnQh8jmOmC/94+dLMJxCWvZx0jk4D8X0acPY8KZaTQMt+LGdJWTl/onifKJt2hAhSlctjSueZYncrkAdiUFXzf0u4dVWGmMop+U4h5Z3TKMKVK5GHGquG0Pq377LcWvBdxWKFXr7DZZ+vMcmBu+8tmjcVlumt2+cMeuQ5+OrOH7KVoyHlL0X3i2cCPga4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2R8leLWx8ZHkLIBCyMsCcXhS2wKaRukmEZagptH4wE=;
 b=NunMYU7/nrvtbNtv4VOYINfLVN1wA1hUv0uDQeqMt7QCCSOjPn9/9DO8C20l9IHsBmzj0RTXLpFwgNTsawzMSh6LXkaW268WFKFbYIMCKCgbNSoAOJCwbL5w5jjrvc5TXPMXgg7Yrs2HOuYIzmIhVgAWmA0xyiIIjWSaezozpxnqBXQ0E8PJW/XVgpdhF5I6dOBubl7ALSihZPF5rxdnjwzJKgZfZlaylw/6GcRjeIAWbtVKRvIRfXM+BylVA6WCmuxOv66xPjyBsNQ84Z16dcVz/BMK2yzwBfXrG+KituSYSs8FXgvJS15itr1lv1rhNmCAv8pk0p2IGWLY824ifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2R8leLWx8ZHkLIBCyMsCcXhS2wKaRukmEZagptH4wE=;
 b=B6pf27GcZTry+7LtKPhEItrg6LyhOBquHKwJ9uHK7+D6ERym1su5r2YzZmpBhLYBIFa2u+LaKRVNLG+JMr+7UogIiX5FqXLrR71g6IK+kpaam6Ahz87QRjwgcVCK6hferlpe9uXkmUNHo9+zLf1lD3MOlx9UGeQO8gRYxex5U6nCXFZlS33MvumWO5D71BddXOu1Bvtaoa+tVVZkOP00g1UAA/YZgW+fMq5pm5EjpGBxVhrwXH74PU++TXXl30fx1H8yDHJ4yVPYTXEyT5++TnGF75vQ0E+RanniJebf3OES4CjHJzRVDUWww89PJLJNnnA2EwUKgJaLOWwQSJTB4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 20:15:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 20:15:57 +0000
Date: Wed, 29 Jan 2025 16:15:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
	apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
	bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
	nipun.gupta@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Message-ID: <20250129201556.GK5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <21ac88b0-fe93-4933-893c-7ffb09267e7b@redhat.com>
 <20250129173909.GI5556@nvidia.com>
 <6f630a23-e1b5-48de-81a6-43cbb1e6cabd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f630a23-e1b5-48de-81a6-43cbb1e6cabd@redhat.com>
X-ClientProxiedBy: BN1PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:408:e2::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d8ab8a-5291-4177-78bf-08dd40a1bdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7VXlKODMRJHvK+hpS+cFYEbk++9gXySN3SquoyZKlDg4d7q1W/D3PwsbwGC?=
 =?us-ascii?Q?3ap+10rubMBhNAM62gvlaiJ6Tsr/l3eD7B6sN4qK1BDKM3yd0KZdrfJARbKi?=
 =?us-ascii?Q?CoENpMi+JV1drC4+MIqMPScXUIkypDr5/d5+a5vMS0NY6AhL7pAkuoVY+pk7?=
 =?us-ascii?Q?y9NR5B8A5whid4uyHVmWrw94M1gyy8hrez/Cj5YSNkAGAa1DIP+/zzYRhbHu?=
 =?us-ascii?Q?MKKdxFp40KOcfvraQAnEcgFiOjq9iYzhYWx/CGPozsm+RBwDyXUL6kvpbT46?=
 =?us-ascii?Q?PHez8M+PnwxLwg27puMrxKdZ7VFGkX1p45mgOYcfvYmBIc1XZmlT6/I6J918?=
 =?us-ascii?Q?8n/4FHdEUMr9iwmzKhrGjw1v7SO1T4gvWHXXBaXdnrlsr5WUq3JvE5FsXLro?=
 =?us-ascii?Q?Crst2dH8W4Bj/P6K/EQbUnhN+S4F1JkJH8At+JWd+RWEdTkPiLWofCu0ir0i?=
 =?us-ascii?Q?1eD4VN2SG0M2cLwQGtoTT38MW5VwqDFwhJZ7oTtgmvQq32eEDX7eFALN1kW8?=
 =?us-ascii?Q?c2Utx2n/Qb/1bNoZehST7+aoxrYCVcMfJIiVNpd7KkIogWDyX1ahXLabTd3c?=
 =?us-ascii?Q?cbzrxMWfHx83XrP2VIqAvYMB09s1cG7VngPmTy2lA8REXqtM8Kc9MnnojgLP?=
 =?us-ascii?Q?nzY3+wi5vHRVtlCDphQgV8qlbaKQFtszkNESgBNLdQ+6GNoJFAK1dmD73P5O?=
 =?us-ascii?Q?2Iq6titO0JuGKEhgF4wuTUfOX5wPbK0w8D/qrJnzCdlUd4QhugbssAFLcIZA?=
 =?us-ascii?Q?y5oZDV5+FBQLmlggqibTHIH8qGtJPFaD3La55YgC2/qn8I5ayY8kyOgsYuW6?=
 =?us-ascii?Q?uUuDFIjHbJWRVTtP9n25DvHL3VtyD4M9Vd5oWhGC3C+ideWmtjrxB6uaLQds?=
 =?us-ascii?Q?U8QhHrwToP8guUZPEbI2DPT7TF2ics9UYvd8wSdZj1WlDfIJkv9q4sMbD9B2?=
 =?us-ascii?Q?WZYfIC791yL9sWYSOgumxeGrCYDEuivMk7F5P5AFy4onRF8BzuxwwkR0vGAi?=
 =?us-ascii?Q?WilvwW3Z6Xtz5rN4HXH8zgyQ3YpP/MHnW1XnRo1G4qfJ6QOhfAk2tWk0KjY4?=
 =?us-ascii?Q?/XzpzQLkV5qWYWTPl1w+5ct4371ekn1z81fDw+bQWdf/dKghTJC62mRF2ibI?=
 =?us-ascii?Q?pSAs+4HiSMpwHprAJ3MRDP0TKRAZ098wE/TDZAPrJqZ7+OOC48+KfrByCPfS?=
 =?us-ascii?Q?2rbJghvjppN4Ey1mbA5j86v5nNMIdixIL3TiqqlGduRdkgqRqpLacA0eLM8a?=
 =?us-ascii?Q?mqSzHqmi9moHTSYZL/BkbliJgvLLmDXS5xnR4DTTrPApml8FsRauKGq1CCb3?=
 =?us-ascii?Q?Zi5fRRVbcuqnkBpAc6rU40IeQEmxkbJ2KPLKO/d0lW9cFbrkxsrYh2kgujzL?=
 =?us-ascii?Q?pTYY7x7MQXAHtjCXUeDnDqxf9tj3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63mRtmSWUJnNsXAGNmbUNMQkiPKvEQn8VQZk6YCx2N1VqSRJIPUoGdigZfe1?=
 =?us-ascii?Q?MJu2XYyvqMXS9jBrm7hmbmOVfDd4hxiCpHnEch4OS4768Illy1lL/rcfrOTF?=
 =?us-ascii?Q?S6JV5imldCB9wFoRpdq+V3jOg33DhwnUYlbesIE9t/wMS5tOFmrCaQBF+XmN?=
 =?us-ascii?Q?B9IiqZJleWSRCloMEzPGBTB+nrRhIc7Fugokv+mfJ1nfMOKDfR3MDdMalCn4?=
 =?us-ascii?Q?PIXuISG2b9DvbuvFjWbTOhjudHwzqEHSUy2EOx3h+R6/AMvlQJbgJ4syMhQV?=
 =?us-ascii?Q?71dxCYcckrYN78kwk3zsQS69HXtBlCBxkZ8JHgVwee+m6b+BkMZoVhxAQFbk?=
 =?us-ascii?Q?pzfK8jzpp8N+Ix4rlS26eqzftkQ/u+6ihmtQfeTnuY0r63039DbNPj6nmk6X?=
 =?us-ascii?Q?DCF9JJH5ZJ19nOnu7ixxQQ7NJHwSvt3ReZHYTGem0DhpEyBP0clMsLdqW10a?=
 =?us-ascii?Q?g6RDSawX5wmMRWJ2b22ZoRWpCcN+EWBIlG8/GGumEbhxEStkuvQDtvrV0BTF?=
 =?us-ascii?Q?wpPiUTe3v7q3t+BHXtRUpBMcZ6qGV6/OBRqUbY7yO5xZuvPUxoBHZrAaGH0v?=
 =?us-ascii?Q?RzuZrQjMpCAMQushE4uaXeFDcKS5iGdCBDtmDBvstcHePAQET8mbb5MNYjp+?=
 =?us-ascii?Q?Swe8cN2mU+Hb9ZGZrSBGyYNGnosE8X0gzOJQKFTvrJwpALVo0ydv4RHV1GtB?=
 =?us-ascii?Q?oJtzJ+ifM58kJbpcjCzMf9CZCU4Qd5APFCoi9gh01woXvWOulJpuQMWvGkja?=
 =?us-ascii?Q?zTUdKx+zzGak0AbicGIWHSKxsOcd+8kIVdLM3whQ6E82XMD5CpRS+nJAm2ss?=
 =?us-ascii?Q?FV2aaLHDZFdwKxc+4OUIJFQkp2heuaN9i5T2JjormRED9K74jetAaxZzXI+s?=
 =?us-ascii?Q?J+oFn+oKWlS79QD+XGdTukTro/81GbNz8gmaveoyHhsPd3d629+6R9BnaE+C?=
 =?us-ascii?Q?yOQCurh0baI6PWj6xOvpQGhwNk9Zp2Z8b+7Ov4V66LIJEvp+bcp6dOhhPdxO?=
 =?us-ascii?Q?GBkt6YtMMNX5t6Y34mgoSxMQPWE6IQF9/KP3VMylxLDapHPLcCnQtSivixQZ?=
 =?us-ascii?Q?qQU6u/Xasmd7Vj3ptF6wcQgrgJzfJ+EULxn6DbaH9tEceQNocGjfl9NRb62H?=
 =?us-ascii?Q?+fLsoxPeD2zce2wnvRZ6188H/IV2qy0n692kGylZDhquvMl0EE/zfiAM1/a0?=
 =?us-ascii?Q?tAi8/OODNI6Hle7NXVbcxat2aqZovsZNG2sDnMh0S0tmLtHwN7Rl8VCMLL2z?=
 =?us-ascii?Q?V3CpIDb1/8McC3G3mI8OcbbTfLDgTe0Z6beVkboOsE5rtWVdU+pTugZs/zQs?=
 =?us-ascii?Q?Fp0piPi1zw+qxAWpCePIg+4k0ehyvM0C3mDJuns49/H6byroW8dInXbZqIiA?=
 =?us-ascii?Q?ndNqCr9yWtvkA/Htn4aqb+B5rVqeoTblvlgJDBvt1Q5QSNnqXnxyVG3YpYXc?=
 =?us-ascii?Q?uV/U/Z77h9OX6mpn7fcj0XI+0TPIry81bWCqbxymE0XEIxjSDB629e5EvQyQ?=
 =?us-ascii?Q?Gosa6ukyEFfUn/Wbr0WFMqaZfGvANjVOVphTq6aJhWfso6nxl8N8PIZZ8KGv?=
 =?us-ascii?Q?cthHPQ+6VUA7UtsXAlXy7B71Nvfqx7ba1sgKDQgr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d8ab8a-5291-4177-78bf-08dd40a1bdca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 20:15:57.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6SZYgv7HzHEn2NKEegL8PkdjwK0tvS2WMPalYTscPVc9U6UahVuMmmz2QvM/pzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184

On Wed, Jan 29, 2025 at 06:49:22PM +0100, Eric Auger wrote:
> > If it was overriden inside iommufd then the user told the kernel what
> > range to use to override it. I don't need to go back and report back
> > to userspace information that it already gave to the kernel..
> 
> Looks strange to me because info exposed in sysfs is wrong then. What if
> someone else relies on this info, either at kernel level through the
> get_resv_regions callback or from user space.

Nothing else should call get_resv_regions() because VFIO is bound to
the device and iommufd owns the domain. We expect some exclusivity
here :)

sysfs for sw_msi should be understood as reporting the driver
recommendation, not anything to do with the current MSI operation of
the device.

Jason

