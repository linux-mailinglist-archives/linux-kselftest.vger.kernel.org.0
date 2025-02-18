Return-Path: <linux-kselftest+bounces-26862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4F6A3A146
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3113A2A05
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE4267384;
	Tue, 18 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1KdCUg9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3A13AD26;
	Tue, 18 Feb 2025 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892720; cv=fail; b=Bhn5jQvQNZm2fwSHN5cuqNqpp3COuktBztm8JALBueOLLgWNA11j1C4Z0eEjltIEC83V4pXUAmM0XcMrin02fsemhoGgQVH/cCnK6u2eVTY0wbSopNqKa+NIyOjb60a6P2zq2D1QC7XKpdIm3ac67Erc18+3G67parFi0PgFDKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892720; c=relaxed/simple;
	bh=0JOtPrK8gpgIu4dFatfE7N5yUggMZXAi6U2fHewcQ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tX3XZQzXa0nbPuny+n5eynw2uJtq0O8W2D2vAUQnpvEaFeuVj2zEwRJHh9/+xiTk+cDz2+aj553EqEPPzAs7F8sDGtpS10TDFJwqg1Vbpy8KVvZwpdRLpov1/q5ET7sJpM5BPMCX6RAyrRnCDsnfLz2f1YwdA+yYpyb6Rtx8zRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1KdCUg9; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA6c/K0piB/WFk7/QFDEXSivex4D39CO7dNFj57PObaTbiaizUM+/yJKmFWaTX9QRYk8/dpjRhWOLojJ01Og7Ub1qVx0K9Lu5D/GY6nAwuV2/4boCgGroNGayFKTGwcghA6qhMNnzwNeLJpdRN6pQIkjCBlJdpHTyQVs3bfDIXfz2BDoQaCYloXNjYMrCFwrBbUquUTLqqMr433A9HpZz4t8uW5xLrH75sCE/UfXTzwJ8MI8njVUEpQdLYKs5Z4JzY9SDY3ZdyO6bLoBwo9NVysjph5ePxdxxlPLmzyvlWViaQKGEy1IBO4toZ/PI54BW87YEEGqUepf6FTj8SdC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTY6s4v8VaW+C22LjSRAYAl4baU/xHxYCgj8X5H7kXw=;
 b=LZqsfeLAwF2UWop45NXtVAO9t6YgK1AlhdNOryhCJGvPGaXDC/93ikXbGxoh5Qjb/6AR9yRwtJp0foAj/U5D4ZFAtTqdnYqZbNHyg+LPK+a9I69q/ClCZIQNfITJcz884nhXQqK1mRoyNXzeqqDavC97i1EMyI6NiKrosmbSrCAwRismzElDZ98e3N6VpOvUSqpC42sP7eC3UppL43tJKpojrbwF4HahW8qzOAI1Nwgifk9fi2nR7wB7vVWs10c32iVJvBIVWtABES8w2/TM7R7ZRdsJ5KMvzjHWR1N+CUEuwEP6y9H1p+qKgo8XDwGDkU00ODfhdJw35wcW98qVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTY6s4v8VaW+C22LjSRAYAl4baU/xHxYCgj8X5H7kXw=;
 b=X1KdCUg9I4rT5JpJJodta5MqjRR313H9ESIrE9H/futENUUPyFW4vgudRdQbu0L99+UevY+cu3WD6xa3ujCeKcBOqh3NsKMcF5b+iSdefs4k30LnWnhtKJwYv2K3MyaY7w4YqaJAlIEkQHYmWw2fC9Rbjbq91ZY0V9fjtx4tqGZOIBnlGIADlj+Pdo5Uo5psfEQ4ma6jfEcSvv4ZE0fK3WzcQ3mKd8CLVqy+XTS04GX8o0AFqMgGyiuoeMy0InscVI2SMVp8T5fu0aqgC7JfqIEzkY8NTGM7iE9VOCgpQCYcwJPQG+fzrk17ZMPZdP+sS3jhVnTA99EyniVpJ8fr4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 15:31:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 15:31:55 +0000
Date: Tue, 18 Feb 2025 11:31:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 06/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <20250218153154.GC4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <313a27d92bd63e9571bf0f053eabfc3bfe4bfbae.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313a27d92bd63e9571bf0f053eabfc3bfe4bfbae.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bd709b-ba41-43dc-ca15-08dd5031605a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6PINmSqhcmQMzkBXN2G7rLgGraNrCXj17FlqVxxvFD4SgMv1CfGfhffoKaw?=
 =?us-ascii?Q?04WP9HszIOO3BQmTI28IfpnHQW8zb7eCJPV8wwt8UYhagURCwQyXe3jVs5Ws?=
 =?us-ascii?Q?tEvcYmoiXK4z+avNxcPdzc0n6w3Hft3Ca9B31RGPXDWimK00zU0S+7SSd0Lf?=
 =?us-ascii?Q?lvk2189yKUo5J5rzS3TPsqjuZ5k6lg+oyAbonDIRniR1ZJvFxAKECdvq9kXe?=
 =?us-ascii?Q?WZSyaMjJSDRIsR+tOfzET1DJ8P5F/1JKcogmmiIKXiHz00AvlnkC1jDxVR8H?=
 =?us-ascii?Q?bMXJNJ5fF7alysNa0v/8XUsGoM3YJPoIoea9UkhSD7yHu5jjogS/TUP2FyYf?=
 =?us-ascii?Q?l/2LNmhRHbvQufiVLw7wFyfVbfYi6CfQLQPbaCpDwONq+G+JX2s9Y4DGe4Wa?=
 =?us-ascii?Q?pFgDMwr4nSoTP5IqzzsD9roOuycZfnizrkF1OpOth3yPcsD/hWhKEQJSjMzO?=
 =?us-ascii?Q?Ih7FsHOSX2CXQgPgvpNs1Jk31VHLdeK+HWM81X2WjbVWdPVUhPXvFJOrmirn?=
 =?us-ascii?Q?cGgF5AmDd6AeFEMv2XPCu+bkuY9mkgdM6FV09X8BvZeZnt/r/A6MGvCLhIMY?=
 =?us-ascii?Q?Eo4U9mXq+RrH41z6R2lJmnNU61AMOgENmfDeR67/+esfPPmIKAy047hQ9CDo?=
 =?us-ascii?Q?3KzWFwvKNGM7NcI/QgeXTfJ4N7TV2nZ3wBPqwtsMUFb0CCsxL1sjUdp7/wyg?=
 =?us-ascii?Q?nYfuTW3tXMymkf3ymLkr1ydJevd3rUAoYcszapfrEZqIc4pptbFEnIDzMxfE?=
 =?us-ascii?Q?XROwjN7OgU+TdcwFJgA4ylyNea+/Nhhce6cOcqCqzKpapYqs3dAgA1/FsSqX?=
 =?us-ascii?Q?J0s5z2QsKeV2VW+OvquLum8hgbTauJSfJoxQ4STmyjSeoOEPibSIHgITz7Ua?=
 =?us-ascii?Q?JSIX5TVww8xFhK5T68BuPRhk5j6arHoumsDlKBE/QOc4BOefy5Xnu03aV6Gf?=
 =?us-ascii?Q?tu3iybBJrxhJMfxZcvfINXX9/CKrbauLWybqCyWKuVrc7tIRbI3Gh+/Aeh0W?=
 =?us-ascii?Q?dZX7xJkf9GN7fI0/YWijd7kcwJgPHzUuVTy7qGq7PgS+7LjGARe+aw5tXi/v?=
 =?us-ascii?Q?75Tl4V9RMWiwpqpMbd2pO/chKIUyswsNgr0ffbSoA9/nVEBJ4T/RCwoazg3b?=
 =?us-ascii?Q?7s5k8/AvXEJpv3RM2isueg0t4iEWWUzCeMD4EUzIfb37QgC1waQh5xJWuIh/?=
 =?us-ascii?Q?NYWFnKgggOKyeLZwcwAYRMbR2tJLwg/u7yCXKz8ZyuOmaoQ1jEeMkntItE8K?=
 =?us-ascii?Q?WwKl24/L6DWeWbu9IU5H5HcoF2/FhSWFmAsZKMQb9JcVSi7GYHRwo3qU7yz5?=
 =?us-ascii?Q?pGeLFnkViL2MQ8QWB4RXX1XYpRQzRZd2dCMgYzBtICSCiIaiIBWZDenJXVS/?=
 =?us-ascii?Q?nkDgASBZybmvkwM7ewp18PKYN5AT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q39RltF2JojwoUhw72UNoVCGXrC6nlIWfyyi7dq1QskEthk0qCJbTcQPhr92?=
 =?us-ascii?Q?661ClCRLTmvHKIbKgG0Q2ggvjhNRi6dC7dNROtWwVWriXYyfp12VweSQxSvj?=
 =?us-ascii?Q?Z/o3fuNDGfzcsW7GItB0SZSZWfJ3zvkoVM/cp/9t04h4E9WjKyif5NT1uD5L?=
 =?us-ascii?Q?9EUsFEOXHXvzqNUoWVzhxf1iiKJDQe8FhBdongAuMo66u5nIMI9v+O7ywcVH?=
 =?us-ascii?Q?kM4R95ILvo/UstzbxB5yNZJY9vzF1PaxyLrVL5BExYrtaqeqJOEfcIdmmRtd?=
 =?us-ascii?Q?yNRs03QuO0/7TJvMHlLI+ek6uE2YNsipfKbaerc+gEq+ZmGhnM4td5oF9fln?=
 =?us-ascii?Q?POK4/ZLm/+hX1xbRyJAGie96q2bHZMD+sMwik0aY8GdEl90i1CI2uCJ+hF0j?=
 =?us-ascii?Q?MHAVRJxhBITfCcada9MdHv1XUtEfhiFZvqgntcQs9nmntivyn5hHJ0636rqT?=
 =?us-ascii?Q?OO0I1lYUXZgH9/ouBlXf8r9R8y0hrOgEmr9lA1Z3ru0ou1eV90qRVLY9gp3O?=
 =?us-ascii?Q?ktjW7xqUWSM4ieZpTN/4UbXbluW/UpTAYZsdJsbQHt9d/KXLd1o2CUSNVufe?=
 =?us-ascii?Q?qkSfig7xCtfPAQRlHHOH2hPUingvHSUdQvqZjPCaLVtRXSNWCXURnjSvUE/m?=
 =?us-ascii?Q?FmjCxxL5glsYR4wTNBOO+5CGSU/EzatQkXFS23Ir9fceCq2bm2tYTp2q4xgt?=
 =?us-ascii?Q?tivra/YkHzSFgBkHebxtZI6ciHt3MYCTFIz/3fmDGxFVtnAbjsRgBivrHEVT?=
 =?us-ascii?Q?urS+F9c0HG2yrwwI5Rf5naitgVabxOTz2tDdofuFJOGORetDuKaVF37kmA4y?=
 =?us-ascii?Q?CfeKej9wlSiugrsqHnn/SC/iV3VYSem4sjzqM/I71DWVgBAIGI+MBWT4eb87?=
 =?us-ascii?Q?Zwee1WPx2guZbrOYN9YgHomzmYvMWQ1bLezg58dFU5plQgsWvr0Dm+XcY4nC?=
 =?us-ascii?Q?Ge6Lw4IAyfdGM0/nWSFJQ+eV3vjmbB/mVGgYKR/vRtKf5dG9aChmH01j0QZk?=
 =?us-ascii?Q?c+obT3v0X/FxeXWKOkGNtcozwIHFfuN6ImI9CXYEJO0iBEVpUaH52JIUYmhP?=
 =?us-ascii?Q?/qmIPHXcB+ksku8dhfmc/1FwRBr9JcsTWk91/CrXeA4+Pk6piDy+GwlIaVvz?=
 =?us-ascii?Q?4QL5uQsJUU7WBsId7UAi0PHo+g9O/i9u0wkOdLsIppTXkzSo2B9AWNZbS9K1?=
 =?us-ascii?Q?96+YMAdUpd+QfTkubcrDDNor5IP2J1Px7tMIYXgrtlp0bRx+1mjIgqWMZR6S?=
 =?us-ascii?Q?r411UhKPW6uTX7jH/fTyXuRimcEqXsCh+RxbzRYxULOTiFolyFT6htpXc7TW?=
 =?us-ascii?Q?5OWv1toNKoSejZ+oQsJc0nqyMd2uyQYQCq86Bul2HJp3aoLvusJZ8KAKhVYP?=
 =?us-ascii?Q?D19B4vJy1xSeCrtYK8VBuV5r+vJoIIkiR0j2VivriHoB3g7HYRXHexormPSN?=
 =?us-ascii?Q?63XepLOn7+3hdn+bZg3CFPtXFER0CktAkG+Q0U7myAGHAAWsqobpZx1vQ7Oo?=
 =?us-ascii?Q?EXuLcNQDYp9Dl5SF/8czLkTvKQqeJih6L6gassq/hMVtdJ+5RJMjJQbp57dP?=
 =?us-ascii?Q?586VFy99l3Dh7hQrIGA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd709b-ba41-43dc-ca15-08dd5031605a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:31:55.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoPw+hOtLaa7xqg0CFtUP2p9CSp50WdykoVXrydSGRZWKGwddG7KXnpeosnAL9l+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

On Fri, Jan 24, 2025 at 04:30:35PM -0800, Nicolin Chen wrote:
> This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
> to convert a struct device pointer (physical) to its virtual device ID for
> an event injection to the user space VM.
> 
> Again, this avoids exposing more core structures to the drivers, than the
> iommufd_viommu alone.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h        |  9 +++++++++
>  drivers/iommu/iommufd/driver.c | 24 ++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	xa_lock(&viommu->vdevs);
> +	xa_for_each(&viommu->vdevs, index, vdev) {
> +		if (vdev->dev == dev) {
> +			*vdev_id = (unsigned long)vdev->id;

I don't think we need this cast

Jason

