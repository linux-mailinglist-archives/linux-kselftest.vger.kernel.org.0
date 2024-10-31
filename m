Return-Path: <linux-kselftest+bounces-21224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C19B7E92
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DC51F21562
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6710199936;
	Thu, 31 Oct 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHhp5dZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92857483;
	Thu, 31 Oct 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388811; cv=fail; b=h/cF63qGgj5dhkF8/z1xebMBjSpF1cCSe9vDQwzZ4l6kwNGvx2IkOSyUv0nJk0l6kST7jkRiwWim+3/3aLw/4pz/HvzgDwR57AT33S78PhGrs75cgSk9DR/CoUDc8oeRJvUc4EDI+GH2KDdKg3XICWlsyIfuXQ2Vc6C/HTRyGV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388811; c=relaxed/simple;
	bh=yv7L8mfZmMI000JHzMcKOS8xu80p4doJ7y3N+ZkXcGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f4deSIimxA7Kvi7LXlEDWk/Oo8cw22tzDJTwkpiMg0aubOlieCMGBMqzEpX7+0J8i8MNvtr1zDIJjjUAUUirTmyIibSjSYcHvtpgZraRRvG/yHzn/8fpDuO/gWCQqA8ARCjehh72wnixzBkGHLcj3sggZolcERXgS3EHTgSo7H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHhp5dZP; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFCbn1RVua+80hvyJwPH6tQUzQgeN6wIfKmPWgssTkgj9v7j0TW7zT31z+4akFRs0u9V5vNyk/8ePg+pQ/sWmU8P5BXJSy6sdsTuPBfDAJpXs/Yvwr30M1tfxPHlmM4/g5FoXjpUSdvi08aeqECVdLDm03hHwNjIMYrQvPTjErbYluTUtGRqxwJsCBc9AzQRO0l/zeZYthrOj/EpDB7kAo9nPb5SAN0pTAcaT4PfnT1Li8ZM+DL+Cb1azqxaFVgxSth2uhjNkavaYtlNqnCCgo6Ika7B0CCck0+aQzsGiP55rhTdKN7HfHcjDQvKXEcLclYf+VzmLQ67I+W7JY+ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bAmi21m3MUT7cKp3zLercyJ4S8S+ejoQH39sh7iD2I=;
 b=On6aNDyg7FdXApdPycDx8gZng5LQZMDEM3r15XUETpCH/Wl5gN2sNKcglkfBEJucdBMQWPPAsQSA3gFA2O57imiULVbJEwNbg9OqJVIP2CFPIfuYQQZBxEJAQ2zF81VkVT0U+LXM6wgRpxDNH9/qt9+39h6I2IG+45ACr0GygrXcy7ZlJhlH6lVkGUxQRYy3YW53+YUGrz6jrnxWN7a4G7Ff9zao5kvGnIpvH4pKYsi4B1Ve88PL7/n57S9j+JDQFGLiNfupjBGQ3Aw00rPcTqW2VDiD2ajxiktx7ESTeJwVPB6g6wgylewAMLK6+uCIekIxvtYYRl7wuDzFIUKihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bAmi21m3MUT7cKp3zLercyJ4S8S+ejoQH39sh7iD2I=;
 b=AHhp5dZPjCW5dDL+0NtDhDezWeJxnv92xidWt7g4Kt4u5n+fjTLTfz+AyXzD8RAbwI5a0GTKtF42PPEIIIjxrOQvBVjzq81xhH2ajewy2M3BpYQiYC+ob4xJfmXrmlVPcIFfur67fUclZRyYMaVKNgSBpjEfegWy2EbhcsFbW7zxOmR2CB2IsuamRrEaXlDLkOKGhUNRIHpQaHyHRlWypvMCVHrVFzjjm/G0g/w9G6/ZaK1Lb1gOSSR7XBwYXxlvsFPCZnc6KhAQbnMBjhEx0aCDNPBE6Bs+VHzvI3DNLrAcaxkOR1/tKCbo51UvBFKPccg9bZXt1mHyItVbqIm3bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 15:33:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 15:33:20 +0000
Date: Thu, 31 Oct 2024 12:33:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 05/10] iommu: Add
 iommu_copy_struct_from_full_user_array helper
Message-ID: <20241031153319.GN10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <1d7f468ff51f3cfb32e90cb29f5b8d4bb2cd2232.1730313494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7f468ff51f3cfb32e90cb29f5b8d4bb2cd2232.1730313494.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a25f070-2789-47fc-1fb3-08dcf9c1597c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tTtKKfrYA8WSQjN4x0NnbhxyweedvwZj0xy0Nq92NTcn3R3jnHw2Ift9qiZv?=
 =?us-ascii?Q?RtOrWrF+Y8/oX/nu/81Let08U7Oh9TQuXDErhWkKwcqXW7YwdWnAshM2+qWt?=
 =?us-ascii?Q?82Vl6ppiKlAnzf2xuK6hW6WLxpMo2K3YMMH1EQaKir4r7OCL/RTBFfD7ErGL?=
 =?us-ascii?Q?JBVcCuqk68NmqGzGgKJA6kXbDDQN5xX9ohTkzbiu7+rxT6Vr/o6Rg2CZhcIt?=
 =?us-ascii?Q?7lrATHZVyn/cso2EdFGlPg+XkNHKa7j/Tp02ng9Fv1WLJJQYFnzlehnPfwub?=
 =?us-ascii?Q?y61VRyoLR+k5XNbBwKXi0Vs1ztr6+CuDuTDHaB2W2PvNr9FW5QViBCBnbl3r?=
 =?us-ascii?Q?mAKSXEkyEe36NKdUE7BoG/Z5W8gLyx+F832vFJLdUdpihPtfWPEkFCrvox1L?=
 =?us-ascii?Q?EGKFWZPfMHqOm+I/tLyvsFiGobLmFUyTFZ4LD7U87wx2ImBxx6kWBIhJS9K6?=
 =?us-ascii?Q?qaK5OUsUFRFrPP2zH6TEEzog3c9g8YdYpevjiUZSDosFJVN0mMe8CnxLcZ8N?=
 =?us-ascii?Q?aEJaEgaRm5ZAhQOPnFxh854hlz5OrbbD4+alrVLJ/5Ebzjd1tqTL6c1FqiQ4?=
 =?us-ascii?Q?iTkOGh68ZTQ3dZqt1CD8w6RwQJ3AujpSg+FjPFEC6tQiCNtNxFGAOeLWHyID?=
 =?us-ascii?Q?x9YOWzAr5x/hSzLwOHaKV2G3z8gynSMzIX5k+S8dPyyMmIU8WtVovT25p17u?=
 =?us-ascii?Q?rHkhom0f/0ee92NURCezDHiKaeNh+Snchl2uqZln/6gWnnHeA0AjiAp0jtYL?=
 =?us-ascii?Q?1MQlRi1FR/l5uGWOidU4RFTFfHkuQiZrlZIk99ycSwGuNYnQxJDJz8WSxp+T?=
 =?us-ascii?Q?inqgP8Kiq0O93+LPx/1dRvM16lVurC7amvPeSO2OuBm3VjnCh0D+sjSUwID7?=
 =?us-ascii?Q?4uKkln2IOVt+kpAiIGXytn1gF5AbCn7rR4zY/UBe+m6jwz0RE0Y/vebpS827?=
 =?us-ascii?Q?xVA2IE7irn5endA4S5knEJxoIk34flDXtlEMABZIhewd2FnSksVHHXcoNQYa?=
 =?us-ascii?Q?TO+lqTKlV13URPyV9tCffvweM+hN5CTgIAHmsyY+yOtT38MwG0dBPsbQnYkt?=
 =?us-ascii?Q?NYKIHzi+Sz27BEL23xdnklQPLzUtX9BhubHB6wBmXKCeg4KVQez6nSC4pSqx?=
 =?us-ascii?Q?GB3VU/H8bQiAkFMTrKVuGx5MtV1EbEUEsleU24PvSflQVr2JOobaXhEB6PAl?=
 =?us-ascii?Q?NMgJKqqGvl1i/xfkiP2l69Mazxr/rwwqqiUinh0VF/3CVSnGEwz+am8SNxsL?=
 =?us-ascii?Q?RapEI0uezhNfvPH5ojOwxQpD/XxtFPHqfLhqD/yTb0H6MFcI3pTZbffNFwx1?=
 =?us-ascii?Q?dL9aTxOWs9A/v1sRPJIOtLdy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7daRPPieiiq73Pf3USHI8rpNOar4KxTS09J/0131J2DVqVMM+KtCt1OWfP8S?=
 =?us-ascii?Q?Sx4lmTBtuFagA+t7O1SaesfkCjHWuHRS6QGdTYKhXzWXDSMAMauBuJWSk+tK?=
 =?us-ascii?Q?PAV+ISRQeNwh22w4WkgUVSFOFMNz2s9iiS1FiBEXRwWmpXORpjG2juGFbrCg?=
 =?us-ascii?Q?65J4JlShy9BXxJWl4jI38EZpTNokEeebdEiIpOy5OaaD3tbr9UheMUDM/afW?=
 =?us-ascii?Q?9vGBXxPOFVr9FIr2Ue1oOmZPLsaFKxc7DoFMBIQAu0gVEB9IZbIjIiz+8CYi?=
 =?us-ascii?Q?y2oHptQGBNtdAwn9yS1zXkRAONxOlE8g1gq8gpekskFFZjiVdIMR71O32pEZ?=
 =?us-ascii?Q?xTYaeSa3oqSATSI7nZRMotLfEApgNdClvDS5vlxpsWXo1ja41FW+sozu0jLr?=
 =?us-ascii?Q?zCzlZSu3IBXo0mBH9baUdi/gupjuTCee+pLb9ayuoJhS5n/ez/OVkYnFMzRO?=
 =?us-ascii?Q?P1ydt/XO0p5yQDRY7ig/E8vtaFeRw4TdPZ8g+zPdobSm1lDBw7z9RyoeDZJ6?=
 =?us-ascii?Q?46iA/ltFCCQP2GKmFGabG+N9KqyQF/2FAh+tJXLSGwz4oX2mmiQLXTtFPeeQ?=
 =?us-ascii?Q?/qkq0m6sulD9rDe0cDCa6EbWNEZpxsJBi8F8Asai9DtlIIWTaoMPdt5/4hp+?=
 =?us-ascii?Q?eaEgbxAFH+H7cUg8/ZH9hslyFG241v4TrUUFvnblAytC66Gr2zhMXF0xpGeW?=
 =?us-ascii?Q?XPaoZ9zaY+xToMspXvF2lYdKfh0+PkS8VD9KdV7HcCkB8xDa/rPjEoGi0vYj?=
 =?us-ascii?Q?rRgVERdLaFp4PwuSEj5jC21YMG0ODHUnga9LXdreE+sxz6/OtR8JLloEhuqr?=
 =?us-ascii?Q?bh4kMU9BLZjfe3cgkMWWSp5khPDUHtcPcUYn2XESXwbRRTBMU+dHsUkCK4MR?=
 =?us-ascii?Q?sqfVX/jhULcPpweTcjXTAZd6UWHWUiUvKSuI6DIo9Yumz8NGNcsVRE/tuznU?=
 =?us-ascii?Q?InwE0TfdBGBkBDR7IgfTe0+SX5/Qd8pVNwcF3VsYrfuBTFF32HVRsxcQ17dR?=
 =?us-ascii?Q?rIEWUXnzXf9FJEh2tDHLVHdNcudfrqwDHdb/bEd7tY8vqfm+HO4XOnncn3sO?=
 =?us-ascii?Q?ZxKLG+lOckZogLi97/QuBiQmpeNziBZ7WO1u5BxcYQ8qWcpMmbuMTvexNlt3?=
 =?us-ascii?Q?b3HZpV5+WgaWsoD8m+wpcwAYztNWyiluYJzaEdHtUU4bXW+tHNBMmqFc5kw0?=
 =?us-ascii?Q?TpoJ9ks1xqhzfCabDMHthljiMVpzEi0l0of2Lrwj5fVqhUWulUcKwtYYSi7f?=
 =?us-ascii?Q?W7adz/wg9kw4lAXVRu+zB8tYZsx9wL+M+FXFUQ37fPjiRSJsvfUjrGZfac0/?=
 =?us-ascii?Q?6nqlryGVAEySB23t6XTyhBzPOPq8utrFW5j7euwOeUOPPRoZCtG3gxLZKd7l?=
 =?us-ascii?Q?It+4nrMUNcD1Xgt61DbSQtfxdHSwv8KQU4uYmXDQc09YeAA3mWkVvURFDZGq?=
 =?us-ascii?Q?ZX3CqrdEC3BWSW2Fn6IPSyH7SnmKdSvgRI/ibWxp/6GhQeo6GjcU/B5YvNDO?=
 =?us-ascii?Q?YV5rvbJEQar25q0Gsa4BOZBH9SLDuifax2FWh32EkfkyLvteu6Bng3nB6p9L?=
 =?us-ascii?Q?CmC2KkOe7/Nu8mO5Bww=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a25f070-2789-47fc-1fb3-08dcf9c1597c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:33:20.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nkfnzZvvbi3dAAeqU1VOnDoHtRifq7qeH3yZW5QsZs4ydfe830a9Wqzu+bQBmfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

On Wed, Oct 30, 2024 at 02:35:31PM -0700, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The iommu_copy_struct_from_user_array helper can be used to copy a single
> entry from a user array which might not be efficient if the array is big.
> 
> Add a new iommu_copy_struct_from_full_user_array to copy the entire user
> array at once. Update the existing iommu_copy_struct_from_user_array kdoc
> accordingly.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

