Return-Path: <linux-kselftest+bounces-27120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1764CA3E858
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 00:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464D917198E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CDD267384;
	Thu, 20 Feb 2025 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XN3iKY81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA563266F12;
	Thu, 20 Feb 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093859; cv=fail; b=aXemdLHWxYkaJkHGwE6RwcNHpPTCFj3KIkccSyblzqQDCbEJS06npwvrFqTr+mxFg1tFh/wIfcb1qgBf/W9zTKJgXbmkozmcRCf1svWX0+fKvheMaozy0G4ZRTNxJTn+kCO/RNfQqtZjImFfTjhIaIzSQcZg5A1yXm4rIMaSX0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093859; c=relaxed/simple;
	bh=Iwvwy6vDgzoyeQCsoRkZCPYJLYe5JV6FYRIBBOoOAaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qf9P51QW70eQMUjdmUCMGSaCUq0iWd+dKh+E3D6INMVjD44l7le5JumUanUSPK0XnINSrrw7wjU9bhHNrL6nI3NW9D/xsTWtAnWLe8dx6eKk00nDcdKOJu+QFunFI2PWtHyfi2XV8ZX3W6gCKt5/zLiqIy8vk3nvgFrOmedvWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XN3iKY81; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/N51II2PKWQvi0KSrjh+cfdSRWcPl7xjIBieUexbi3U95kKT1EF0alx3fTTA8uY1M2txXdr3mBN9ixNW+dTX3iFtOcyHAyBNUYoqvzIsfbaCUgZM3yDKT7VedMR0Yk7jMobsjhsS/BIy0KeYilc/xC+RO4QYU1lEY+zdqmO7AZt/n0Tyi6GDgcGLhReFs06CcwTBvpVBrCFYjww9IVjDgmF44/xlD4qKui5DbQg06XFd7kRHo1MMrPs0rp36xZanYqgC4NsEdJGvOJJO7SVYWYACKWfjOCo9fXSPTymMUs9Kog0WxzsIP4xke4ExuSUbb/6TX37RGY1B46zMfeDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYVRtHzTuL+qT6Uh87eqt0F35z7l2oXdWklim0cGQXY=;
 b=w4c2z9hvAF3VG4hik6Orj9y/JudDtVE4g5jD3TX+aikgmb05HTZt/5fO9D7vKcHBBPuNJ8LsAkKazara/uRCV8wViEF1yIz4/7H9BhUw/mzxXi30p4Z+QefMVZlWtpslncvg880+t0weFvcitjKyHb+osqgCt2DzyhyUJczypdC2W+91kq0adgsnPTrr9XtCC/JumEwiFvFovznOed3uB6znGDCuP5Jo910DOFatfGBMZtRz7ahy5g21JWYEh9PTto84HQEe3Lc0FDkHypm1eDtH+jodgVntjsCbJIx8zL9tCVtkHrE5xu8e9mJUDBBIEmgxT9Ur/y8Z2JcFANdv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYVRtHzTuL+qT6Uh87eqt0F35z7l2oXdWklim0cGQXY=;
 b=XN3iKY81JsMs8LMhVcyAFlz5D5ujObQoqfD2FqhDZdBfdqvnP/HBkEp2WD1DCau8IZQDLV6r8WT1Oe9QM6B8ITySlkIQVJT+ZxkyzPgoeqe7sICg67/+mLCBGhVV2b7ZGtiPy7GTvsFxpE5asHSft1WRNGDSkOFcpbe8iJXhfhBc+kbpqrozl1VvbYHkHB5czJpDPJtEZl9WeMur0YNn3udf/2c5rZcQNp/b2QzHoP6OBV1hvZLhZ8WUdzLY8NO8SL35NSmo8Tf/BrlCwWBfyWE8GJE0nqr9DHZzAqM/JA9thLRZWafkx2cnivv7AA4UfPXrV+i7cJDT+qIxFz1bVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 23:24:09 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 23:24:09 +0000
Date: Thu, 20 Feb 2025 19:24:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, will@kernel.org, kevin.tian@intel.com,
	corbet@lwn.net, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250220232407.GH50639@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
 <Z7TRNL0u0YmN30ax@nvidia.com>
 <20250218185046.GK4099685@nvidia.com>
 <Z7eUeg/SmiJGTgbi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7eUeg/SmiJGTgbi@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:23a::14) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a7269b-6487-4dbf-42c2-08dd5205ad35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vlqesvg71vv4gmVeRaE1htgBBCdbx0jJoVNaI2gL4nDpHCcSMv3OFrL+c9YO?=
 =?us-ascii?Q?LWtFY8GAo+hTVA45ZndSZPg6QuslXvEhYqen6qvtvINj8DghATgynbRlmoz6?=
 =?us-ascii?Q?rYkqjy35pEgnuiDs/P3O/+FiV+uNUn8vjNMpvY/NVwoHF7LywqMVXTROGC9m?=
 =?us-ascii?Q?dMPYGSTAhT5WJRRDAsupuUMYCUcTwU7JBKTWCuIaDFzv+fx+901J3fI/vBM5?=
 =?us-ascii?Q?kHq/zUPVxMQY2gPEwHpWhDg8k+sIFMPTCTrK5hRqoklAXJhAg2gXjMNXl/M3?=
 =?us-ascii?Q?AAuw5G1/A6j7npwYFYnrE6A7j+WVk5D2AzdTqgfUMJHSs/wxO95Hg5UoIdNn?=
 =?us-ascii?Q?N42/fqQt2E65AUzLUoxB9F008EzdI/km2QF9ZUYM3XABn0X2csj5VmQ9jweZ?=
 =?us-ascii?Q?MYik3DMLSAoxrlK22kBS32DUJT0kfdBXmmW39GzeRcvbr7uGw5kBqbiIkZ22?=
 =?us-ascii?Q?V8N6Dq8/n5KfSGX4zrR6CjusBGcnQQLH1n5p+kzTAPg6PFu8ZU4rUbw7DnZS?=
 =?us-ascii?Q?4wfZuWuBabyW1XUmCfxzqtPxMa7lj5/l7yGySBo71GwVu6YdR8+Pdhx+wtfX?=
 =?us-ascii?Q?aSo0FMvLeo1XD1SF4XKy4Lf4v34+Cyb7RyA0V4jDl/iKP/y8dO9VD1/jPisW?=
 =?us-ascii?Q?DN1CJ8lLZKkSdw66kB620RtIDd9B9uJV9Z6x5hMxrixxC33Yx3rG5yHuvgZe?=
 =?us-ascii?Q?XbPoaQ7/fIileS1M1mlwqgw5CnRoc4JKGy1Z+rG7T4hmBHwDXdo+PMzEuXKx?=
 =?us-ascii?Q?XlmAxkfD7CUzz0L2gf4yTyUF9Vn0q/+2nXXW81FXUE9M4P2keH+W//r+ocvN?=
 =?us-ascii?Q?WHkyG2dDU2c0NU92WFzgOBkINAO8oVq6rVhYyFkEMxSUnWUsWWGRJVgs1jpq?=
 =?us-ascii?Q?SZBWv1fsi6g7rptlqLf2T0sIsYRflhypl/8i7KuenxX46EW6oZ64p38a6/Pf?=
 =?us-ascii?Q?kLRO0Xh5MabPLTW1nhtnvp04qNStSsycfRGf21niZJ6ss0vq7B493pdqr51P?=
 =?us-ascii?Q?Ts+tkqO6bjOAkypQkXu088Rd98rnaRW4jbSjd+qJlzT/nBBwBzaEcdL36ioS?=
 =?us-ascii?Q?UT4fxo68zLoa4aNL94nVOebj6Pb8fJDlcMMS/Z4cZPOYJH/+5mOHxiUxkIiZ?=
 =?us-ascii?Q?MTvr4WkGbBXkR/gHbvxCoCDPskds6b6Z4Q4+mmT/rIBTn4sVUVo0Y4pEqUQB?=
 =?us-ascii?Q?9/eSM2l0SrQQZH6GnBlXq5jsT/hesHbQxETtyQTQMJ7S5YsNscBQ9GYtk6vQ?=
 =?us-ascii?Q?jXwOcj0KuPRQbEkDclDaJKeiXpMhhYw2geILuNf1eD9jY5YznjbDz3QdZRaL?=
 =?us-ascii?Q?5F9iuu18Ar9Bha9BtdlFlPfiwGJxxcT0eYz7St5NcfM42+mWVJLvFOTW+I51?=
 =?us-ascii?Q?onDqYnPak5xJ36ysGxTxEwlUwW/n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LO45ylPG5gOxOXR1bgxADqdk5Ku+AjgTibcmEfNd/dE/b5MoaY3omb3v4hHW?=
 =?us-ascii?Q?V62Wn4uVfREJTkhg9zU4BKWDj85HXX7cQiEr0QzPZJgil2QR5geAruKTj5Jp?=
 =?us-ascii?Q?HT6OQjVPvzVG1MnF+S4s5XSWbt/xse/Tz4EfgKMcrvvM0Hf2hVmv1JvcAqIW?=
 =?us-ascii?Q?PZE4E41uGKkSo8phAnZGm0N3clNf5z1e+7NwapZ8dbsxdGLm45lKWkiZjLi5?=
 =?us-ascii?Q?ild3/ivFYsVif6PgKcBwatHNwxalRdihumDuIWt1Xsz03HjloO2MIFBGSO8q?=
 =?us-ascii?Q?k3W8i6QuF4BiwMDghexVEFFb5ht4hk5bG2TjRPclmBa4AhMDmFg1gtEhSoMi?=
 =?us-ascii?Q?JDpA3pZ5Tw8QNDUv38T2mZiab7Z63VZsm+4aDXsnl1Y9TEKq/6lxBzmdQKAx?=
 =?us-ascii?Q?L3KjIhhYbEl8cm0lANhJq4dGisuE6kA5nGMMId/Hz2Zu3/qKknvqFohCsyEM?=
 =?us-ascii?Q?8pc7VvQQP+feai3KhNH1EH6jbMo+Bx7OsG5CBe0mm3g4Rqxg8TAxJhBLG/AF?=
 =?us-ascii?Q?hlK77QroQJuwhLUDVu87X0UUeXUsnagAPc44D6I7IAyRlZkgp4LeMzA9T7O6?=
 =?us-ascii?Q?eF+FtqYX3Iz4Rh5dc5KtEygno+AQP/L3e9RnL1uMv3LqAgoChTzT/pJ2HOJl?=
 =?us-ascii?Q?5WHGBZG0PsVmcM0ZHrreF101AGL4SDmMzygDF3AlCj2Xxk/wi5LTlG8laTJg?=
 =?us-ascii?Q?iN9//M+JZe4UcgOTQXJw9fkfJcctLsibJxoWUeoTF/sOXp6UnHTQlqUytNbk?=
 =?us-ascii?Q?KpXkuZ/qGX8bwtnwZqkr2e+j3UUHGhd20ZlYNFrslv5efQxW8Cu/NRWdRbb6?=
 =?us-ascii?Q?HjNpuDmLLvTT5cNn8kmUMADlEPTm//Kz1A72TSSmOsJJvALdIFTdk2HOlwvh?=
 =?us-ascii?Q?CsYcp40yxra/MJx1spAq7enyD9oRUJxo+Rt1mTgMXJF1CefHNuGOQxHURl8w?=
 =?us-ascii?Q?728X3j/Oj11cZRd7T/ihNLU9l1UMXRwPT+eSYD7PbXWwCpWQkXTPIawbLnVG?=
 =?us-ascii?Q?HvjEaWah4isT9nWIPCY3KFd8Lj96G33B1IWT2e0ir/QuFKW9B2DQnI2iiVRr?=
 =?us-ascii?Q?/IuGGNyxJNEc76D+9Cs+uw3h+sqJ2oI/9WUN86ApDB/2jkytqclXBowloYTT?=
 =?us-ascii?Q?D/ZdqjxpxAvnsLiqw+h43t4enPJWKJkbGJb6GIh7OW7E3tK+soSRHcIlqVf2?=
 =?us-ascii?Q?JUm+eR0QbhkskBbK5zVe/uhDcXic1dJT9IAj/pTTnhSEmeP3rt2YPVS/2MMt?=
 =?us-ascii?Q?ZUdLTcjkqp+RHOfDKkBnEEw8R3DTgFAS/ReX53ndq4/Js8EpoT5dEvWWu1RO?=
 =?us-ascii?Q?B7Ou5CV2FFGCYBLwkpEVJNJjTpwwKFNSNFoBbSnjELN3CcW+DQMdR/ihXKpj?=
 =?us-ascii?Q?hr9yO4jkN8AJOKqqk6oiU3dha9arTiwgHNCIiPHlBNEyIlqAqveDJt4Q/clc?=
 =?us-ascii?Q?kCKuWUHjKkMyMBRKvEdPV+H/Oo7/RED0M/wXcc1drOXqUwmWquNy3ZGBY8cy?=
 =?us-ascii?Q?l+Oea5h3E7iiEYD9yQHOA2xfXeuK34ubFW5lQ6i0Wpq7GSS9eaJygyMT7npJ?=
 =?us-ascii?Q?WFNX8YRETQEbMOlYQ5s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a7269b-6487-4dbf-42c2-08dd5205ad35
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 23:24:09.2652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i8V5lIIqOXIwLet38/S/arEzRNQF9HcTCv41XKI+J+IsjU4ihb1djzyIj8AvBvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

On Thu, Feb 20, 2025 at 12:45:46PM -0800, Nicolin Chen wrote:
> ------------------------------------------------------------
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index fd2f13a63f27..be9746ecdc65 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -1067,7 +1067,16 @@ enum iommu_veventq_type {
>   * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
>   *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
>   * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> - *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> + *       Reported event records: (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> + *       - 0x02 C_BAD_STREAMID

This is documented as 'Transaction StreamID out of range.' so it would
by a hypervisor kernel bug to hit it

> + *       - 0x04 C_BAD_STE

I'm not sure we do enough validation to reject all bad STE fragments
so it makes sense this could happen.

> + *       - 0x06 F_STREAM_DISABLED

This looked guest triggerable to me.. so it makes sense

> + *       - 0x08 C_BAD_SUBSTREAMID
> + *       - 0x0a C_BAD_STE

Typo, this is C_BAD_CD

> + *       - 0x10 F_TRANSLATION
> + *       - 0x11 F_ADDR_SIZE
> + *       - 0x12 F_ACCESS
> + *       - 0x13 F_PERMISSION

List makes sense to me otherwise

> But F_CD_FETCH and F_STE_FETCH seem to be complicated here, as both

F_STE_FETCH would indicate a hypervisor failure managing the stream
table so no need to forward it.

> report PA in their FetchAddr fields, although the spec does mention
> both might be injected to a guest VM:
>  - "Note: This event might be injected into a guest VM, as though
>     from a virtual SMMU, when a hypervisor receives a stage 2
>     Translation-related fault indicating CD fetch as a cause (with
>     CLASS == CD)."

That sounds like the VMM should be catching the
F_TRANSLATION and convert it for the CLASS=CD

> For F_CD_FETCH, at least the CD table pointer in the nested STE is
> an IPA, and all the entries in the CD table that can be 2-level are
> IPAs as well. So, we need some kinda reverse translation from a PA
> to IPA using its stage-2 mapping. I am not sure what's the best way
> to do that...

And if the F_TRANSLATION covers the case then maybe this just stays in
the hypervisor?

> Otherwise, perhaps not-supporting them in this series might be a
> safer bet?

Yeah, I would consider skipping F_CD_FETCH. May also just try it out
and see what events come out on a CD fetch failure..

Jason

