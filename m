Return-Path: <linux-kselftest+bounces-19155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71499317D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B181C221F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F61D9321;
	Mon,  7 Oct 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sem0kUQb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699311D9323;
	Mon,  7 Oct 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315525; cv=fail; b=FmsKgbbrScy2pSthDc3htL3gKEr79parXiiLW4mFS71iqmyq0I2LyDE9E4PkzBoOMnLIaCimSA7P/b/6P+nZQtdIY66BtE3ulm107Dy7OjcMyJAcr/UJCkAkNlz2s/20WO31UlvbRD/cvIZ00MzzidM+H4//yeTqThYERuuzAMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315525; c=relaxed/simple;
	bh=4NCR7W8nTKiAeRwcblzvaFmYY/CTFmt/VdSsuLqtgwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LiAnefNCfz9rjZ2Qvv9E+2lafnnMf8tl1sY3nLs+rT+XLZ5/r2X42gA6+bbSJ7KwrjUcwDJVli6J/z+lAiAIsW/tPrQ/ftTPIt/bc4Ytb+wm+sfQ5w4XK/0d7oHNcgi/ARMDQeXpkfmiBGGbSqld/UQQW3CJy+G0NsvFKra+aQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sem0kUQb; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WETMoOORJHVCCxz+tV9IWGe8fZ3OhnM2lXGEQDt4F+hu0Ve5LFlq0xlRIKRg0jDJsTQ8v3T2AGOJsXt4EUmdu5OgZBoIokfaNiv30gELK+ueIe1veQ4kzlhg9kYLnUXHzyqIH6zjsAcxAw2bALM3+qKm1PtfFext48RTGZXOIBQC9aRIeR9k5Pl69ARKnTPlFOKNkV2HiesXPmOtHFKTL9B9KoOKt2eeF7e4ODR78Zj2RjSe4KfZdfhDnN1Pz+jNhyWPV1I9ETrqXIzqRaKNAHETlVExnyyMIztaJ1XWkmCJbxbpqN2zyYUg/DwAtRmZjnxF+0SgaSzj017G7aYTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rk9Iqon2WqDXbTlw91ntq5nmL5W6uPqk2exOD65fb8=;
 b=yRrwxoqUFicxexsDU84kEzqck2VeiQgATmlr0pdoXx7h1DzbHUq/N0J/W+zW4rfrc8+xJgdrlLbuTASirqJJ6uFRUqWINvfpSDYTh6zCnPOnruxArmo3obskpg55bBPGkre/r867jgFI3fdLipWuiQBA1s/rfNNF+MyeW1cAnFZ8vWciDIznZBVpQ1Zy+USZ8oo089zgEclDy6UVH0Oduh7aZEUz7xhTFWlbN2LVRafHd2P6Ff8cTdedmdWJ/iDCr2nExiW48o5Ipbl//7/8Q7r/wIErnSpqzLBBvHN2neXIPvWtz31gvR1PlxtudSJPPy2OQP4/67bTojQlgvWSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rk9Iqon2WqDXbTlw91ntq5nmL5W6uPqk2exOD65fb8=;
 b=Sem0kUQbO13WjDjkcqH6nqYXkWaWhqbu1ARBnU62OYoBie5ztLOx1wW/OGTfmrx6GLxKlCk/NYT5LI6QPzIt86oQiPk5OKhkWTodel8akJRXOSDWygxvCGexNb/K7IFVlKiteYYMnm1DvfV7+V7h1gDlf3RB4qHUCRaGpDfCXFV1qbK8JXTKHsp66LwFUEnbxE2TjVf450a/7MKbaPW55TJVD8dpyfcY0ycgwYeTqneU9pllGipxIKCFtiy5mPczLXq65oI7CKOYHfWBJ2k8WzKFvCTqHym6qxj65V7yIR1eIZiU2NKAyw9AJ7Er3P06PZWmBndWMFGX02ZPLpNj6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 15:38:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:38:39 +0000
Date: Mon, 7 Oct 2024 12:38:37 -0300
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
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <20241007153837.GT1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
 <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:408:fc::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cafbf74-2815-4b95-6709-08dce6e61dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UjVzSlnA4gTxPvGnd7Ax5Gn7oMe4o9w21tqKQ7udtxO9Q5XS/5nix2U7HUEX?=
 =?us-ascii?Q?JlJo5PLUv7KvI6uh0BNtx2Zdr4PYhPCQOJbc3OW3zIG2l43B5eC+44r1qxx/?=
 =?us-ascii?Q?oiE4eWgR6a41jDDuBneaOtHGlpzULkQFgizASZ/mva1FiDQdsxtuRFI/4No1?=
 =?us-ascii?Q?/KF2/Cadp92wo8RTBpfkpb/TZ3roDR5rcqu/SxQ08Reu3ItQHrZIknFsBQ7z?=
 =?us-ascii?Q?i69xXTo7vk/UKJjSgiSCxF8JXUfyG+BpWPv4eq6a5R1yYunmzihCPHm2Looa?=
 =?us-ascii?Q?UId8ITuPMLslQq4ZxYDO7VLkmEpX3QQyRIfY4NNMWKhOb1oPCbDmKyKVI2Ho?=
 =?us-ascii?Q?pBqj28APtTXffu1TLeCSHC4nga+fu6GhgD7TD+cUZ4zH75WfmTaNsA9/csm/?=
 =?us-ascii?Q?6rs/Em/NDIWagTCsT2wQpFfQ1OH+MDQpw/wWP7O2O8JAlQBvfy4ETxUjlIIv?=
 =?us-ascii?Q?4ERBhgrE+TsUfjzOx+su2hxZ1iW+waMS80pgaK55zjl7IVHexk3SYkCCYHy5?=
 =?us-ascii?Q?+DFKeQGEudMss9bWAKhYpj0VlTEHjiqaSyvDoiJ7ZmowjHZAIzV3acm1r7BF?=
 =?us-ascii?Q?MSgMXj9wE5SHej+Tr5ldPcy49BhI0V88n9UXQTYPf7bmlI2gZksK1AyNJ+uD?=
 =?us-ascii?Q?Xk68NNdXWkwDcA6fBGq9zCxpnwzbMH32F9mRZpz+vcrwUz6jdo93eat4NlWk?=
 =?us-ascii?Q?f+pjPqY8Cvtifv5z1N7V/cQnwbt2sro7EDIxphHgsGnhlEp/uFS9TIvSsc75?=
 =?us-ascii?Q?y5NLmuV4JaZz5qTc3FrNz238A+eyJxEOcvlsxFLr1TOipCEMhswg5NmGz6J6?=
 =?us-ascii?Q?7kgPUBKfdC+MUoKS3nR2NYnlHA93/N/alpnQfY9fFzi2p69GL3GDt9s9EXN0?=
 =?us-ascii?Q?mb3mmFQfif5Wu0FUKw51ZfRR+Dp8hU+swdZBNmBmI7pZR8hCDeagoxdQa/DL?=
 =?us-ascii?Q?HqcJ3WmAmu/BvFRSwhGU7sM1Vt5NNUQzH2hW8tK6v/EvKAifgUTuPcm6rmGm?=
 =?us-ascii?Q?fWYw2cs9UWQ2TUyRD8SNUzuXttC1q7OdCV/cidRVlkUCIyRFTLnxCcCru5rg?=
 =?us-ascii?Q?Y4aIOHsKhhcsdFaogQ0KHPhRaDgDtNtAm3sucqdiWpWZRf9jW3FK4eBQl21i?=
 =?us-ascii?Q?qx2XguJ93Z2MPmdyXVTu4nCwL108X6dapujky5gCMAJpZqhu4F2m8KkbwaLp?=
 =?us-ascii?Q?oxMNMTWDRc9Rv7trB2WqezyLsy7L/S9b+IrZcajkCxoDNwBIvGaV7D4jigNe?=
 =?us-ascii?Q?W7yYYD/q33QWnbdfeGyG6+qhm3tTI3MeWvN7H3612Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WHbeCfCfVQMRXvUBbvFuZrcpItS2f09UVcvCB9SgJb+QOjxGUDRh/GZCPLAI?=
 =?us-ascii?Q?R1PTj4UC8zCYNk/Zy9BwhU0ZoX93FOmrQibgEJ0M9UnJB2E7VVmxuKySDU+D?=
 =?us-ascii?Q?wKhaLY8mulgT1bYNfX8O/9/VsZazFsu7txc9r7ynMNfc8jBFwmJZy4JlB3Ci?=
 =?us-ascii?Q?D4tJP/wWf+3iew6Jd64IK7/hqS99MbKMXE5JWyHAdjz8f7y2c35DjTBEJQPR?=
 =?us-ascii?Q?mhGaDkff2g5gBI2oth2IRzNqVzJsENe7cQSISzCiryp7Ksar9t6RRWqupYuF?=
 =?us-ascii?Q?R8OkigEaVMSklWeTxO4/R5N1BMcRoUS0hJohOagwqTC+LtkVJPxy+YAUTYGg?=
 =?us-ascii?Q?f/0OVg1WylpjLqedN9PmehcFwCjngnZ2jf15QY3hSTh81gZcOCia7fQdHpwB?=
 =?us-ascii?Q?g3/eE/bWOxjc+X8ZHfsKW0BNEamMW45f0DulrdF9mOXwmHrUzbtmGNwQP0So?=
 =?us-ascii?Q?vkPFWX3WM6VSRBDxGHQjRL6wdVvLbRa8jwfIXvMvF+hcZDGWWHWUomq9O/Pc?=
 =?us-ascii?Q?iXDX+6CW61Kzh3VK/zBJbpj/zg94m46MbqfHUYZWXAcvT1WyjMn/hnlBdkO6?=
 =?us-ascii?Q?MKVlZZk9ycdNR5I7JTF0d4Pj2/O5Q+6ZjJpWnNfkyp8lN6m0RES+MoBmhN0g?=
 =?us-ascii?Q?L20oKV7nOX6SzKth3xRbdGFfagJbJNFJaMhC6uj39q7n0M34QgbdcuGJ4ola?=
 =?us-ascii?Q?LQM0EAXvFSAFnYRomlR6azOduFEiYN96V5cC5JlFOZa0g6mlYb8r1l8rVNOx?=
 =?us-ascii?Q?OUtnhU+TdC1a5+8xZHmCVaUD7/f2jSlMJKj6SE+hrDYXx8017HrEJRwk+tBW?=
 =?us-ascii?Q?TLalurEf0E6oR1xNb1jpBlUCL0EwrftBC9xED9b9dGWLV+WxVZmy/uD6EKCz?=
 =?us-ascii?Q?ezzAnHAu0tUPvRbV/UhnFWTYuX4GIWq/3f3hchX/bo3Jwax31t+QfbsWZEpZ?=
 =?us-ascii?Q?zcHOVBw7a82OShw/FN25QXRengZ25tUIz0JGOzMZjgPH9dqE2XGO+T2K7GeS?=
 =?us-ascii?Q?mBeZVxAVQgQLSFWoV18r4uWNwtYGb+IVGZSwOwi2wFclM0QneHClmb8EVpXK?=
 =?us-ascii?Q?/adP8W9Q+feHGZZcnYTM0neJnoNpjQgxidnfwE29i+Ai7AFDxeOsoEm9/Jwf?=
 =?us-ascii?Q?xIcvEmCJ1knG2XEhAji40L5PWv1eSvvrcjZ8jvoJyj0335+sf9cvjB47wMX8?=
 =?us-ascii?Q?58iPPUl79Q+621udmeg8RmP4ozNGPhmygObP62xb2Rdn4uMG/IgeXqjnbvlI?=
 =?us-ascii?Q?b5ttjlLEKjDlS9DTkDp2rZe1/rEyH+XX46mLj6fzYgeQuv0JYbJXcTqfwd5c?=
 =?us-ascii?Q?4ZJTMvuXuCWuWm1Now8bQeLKo0EGHrOT+01amqrizuQ5e+wMXz7V6P0XpYwg?=
 =?us-ascii?Q?7GaPSF4XIO+veMpEXSNKdwGOGsqCYtPprN//w6nkWeuad53ToaMK8l/N4jFa?=
 =?us-ascii?Q?44gVtLF2vBkRCLnRMyjlCdsbdi6K7h/ihuE6dJyH3EtuQVRKOL5GemICaQfI?=
 =?us-ascii?Q?fCdQfuFHzPQ6gkklF1v2D4skx/4kWInGS8kkgnZ5SRNHZLTPTh5bK81PwvUu?=
 =?us-ascii?Q?66iZAmQf/wke1SD7kRU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cafbf74-2815-4b95-6709-08dce6e61dbb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:38:39.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/kalu3z77l7McBMx2mNroggjNVQFwsYur/YqYKPvISkdHdYiEGltVW7aEn5mJwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

On Fri, Oct 04, 2024 at 10:19:43PM -0700, Nicolin Chen wrote:
> I tried exposing the struct iommufd_viommu to drivers, and was
> able to drop a couple of helpers, except these two:
> 
> struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
> {
> 	return vdev ? vdev->idev->dev : NULL;
> } // Without it, we need to expose struct iommufd_device.
> 
> struct iommu_domain *
> iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
> {
> 	if (!viommu || !viommu->hwpt)
> 		return NULL;
> 	return viommu->hwpt->common.domain;
> } // Without it, we need to expose struct iommufd_hwpt_page.

It seems OK, there isn't really locking entanglements or performance
path on this stuff?

Jason

