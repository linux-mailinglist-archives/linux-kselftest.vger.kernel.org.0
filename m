Return-Path: <linux-kselftest+bounces-36844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E8AFEF73
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAD1165627
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72F22256F;
	Wed,  9 Jul 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wy4KoO/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159E207E1D;
	Wed,  9 Jul 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080951; cv=fail; b=M7JOKYvclflncH7cFD+FtRRJIybxcVBH118ucj8uyyYfT+gwchMjPoOd88zBOmzPQtRrdGjXjh3fqNGQStF3I7dS7W1Rx5SkUTYx+HN4WbXUbg0kzVJe58gJyv7vkiYcsmi0EWxWh36ulhP9G7bBDxmqGZPJLWs9l75EyV/ijwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080951; c=relaxed/simple;
	bh=LiCgIm9JCLSPRAUhmIplZ65Lvfa/AJjtABDFik8ovpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fhz5E658txR2QyTCG71rfxkqNbhIJwpKUORxqeHEnrHnd39WKTNxpfqmC7VIySAqsgnot/rahxvNLyBkX4GsadXFWNliD5qLc9EmJ7VE3A/4XB2lYprGWBJ1mTd8dfJChnocT927oQTD77wAmXPiM6PoUAq8cBGcl1wxL+7DBfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wy4KoO/k; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw7UHFkvQr626p0TBeFUHgazFNuyo1BKSVFSAKLiP5jaMF6AaENsSxCaQq1kQACSVCe/WXXnHr7XQWMyQE1bdzw6LWtIQQ+qqy86FEbnKJ3wNQYhRa0OTcs7wwBCkl809qRc8kSIdIgQnWsFa4G5GUz4QOKhBY7SWHBJEZRnSKiR88VVlJRGF+d4Rs1ilzNkjuj7OY64L3nxvrQVIie4D1Zfx+Wq2pERp7ivPDn/3hP8PIkG8F2Z02mVVRurhaC5mrDMIUFWMpi4h8Xc33ZKVJhryy5XKXu+d3kHipJaeozXag9HQgEyHzVqlZraVqdxdTSlkJ5NQzGfyAZ5ARt2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPqy9z878GyC8K/bE9nTQTGvp0eJ6+uB1iGmNFsFHDk=;
 b=aWsYaJJJruqqcp+vCuCfVoYfCnxbxn2mKrJR22gvs7Is8jWwD2mPm2mLiN66AvetUiiVlYailsxtDIvNBSIsIQZbdQZz2Wxh+FH3I5a4jAbJBeJx35kStX+HnuFBcUqF/OuQ72CubXzail0qFhKDqdwilQUzshHrxV1Xoso4WweNcUV4eMD9JvpWGso7Lr8p+2qaNCPYqQgnJzO588gYkFfgVEDWKFg3SEjkbzDe9oj6e4PE/mQOW87tC8u9xs0YtzgLbS9fbynhEI+vALiRNXfeg4+uSR2Ztv8LG2OutPowWRhZSjP0cQX1cDTDOlcs2Dlp/dV8kyhtZtXgBF75oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPqy9z878GyC8K/bE9nTQTGvp0eJ6+uB1iGmNFsFHDk=;
 b=Wy4KoO/kehQGTXBpTHD/ohhClBCOS5X/LnFvXC1ZCw/QmjY0CA8rAisq1iVtBKf0VCwf06VRxjGTifSRpXW9gdpiwKa00vmUVWePqA38Igphu+qAmXrFzyy5R0h7EB1mQYDN2tSWNkRbSfzdpwbxe/e5le6uJdA83zUC2pWZ68UfXxnDCGiTqGCERxUiM77dP0UYS8HQ/yaNSIxCOCcg0ZyQCaYrsn3CmCU9rZcRG0UdjRU1fP73/2OLJmD69nGwiK0omszFHmPLHiUfAx0O9UVlXl3PrwPrv2/Mi9Eb3+Ti8e/trC3LlWUPa0FR4/pyeHPCLeStwVzgaS7smsKPLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 17:09:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 17:09:05 +0000
Date: Wed, 9 Jul 2025 14:09:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v8 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250709170904.GG1599700@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f13d8c-ab08-48c1-207f-08ddbf0b4f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVi3HRBhIjZxXsm/KMOnmOq+P1QJaM8JXekmQ/xl1C+pmFNjYhKKfYiqYKcW?=
 =?us-ascii?Q?L/0p0ptrkKdueKBqJZPfkX4UJdsj+BEOThenUi5BCACCV1C2XtwBARoda8Mq?=
 =?us-ascii?Q?sRB+Wzt+nvxTEYGDr2LdWxiI37w4Nd0q2tRHEdNTartIhg/sh384+sA757dN?=
 =?us-ascii?Q?Frl9WLPGlYZzHLmV+h+P85LXGSr/jIhxrCVRMzmH53n2g83rD/EkwxhKkHcD?=
 =?us-ascii?Q?Hc8Nv5mRGVZpK6pbtFmOm2WA9UtzuLEfDrk5CJIKoQAYxThELnake/fGvUHt?=
 =?us-ascii?Q?LvXl+/p2endLrAfIkWCsEIw1nen6nLj2LMSm9k8w7jhSXC7OzkZ9XwLRQtpI?=
 =?us-ascii?Q?TmYk+e62EiAzDRJ1oRFLasbdfcQBHBj6XVPSB0vk4HRaUVCEMLStcrkVzW1U?=
 =?us-ascii?Q?yn3FJ9gyyWQxsxiZuP1CEJzTvTvjN41zA4LG658vzP2tOIddahzKcORirEHP?=
 =?us-ascii?Q?E7aZrGceBZyzMLDU4fqJFS7rap1N2SFIQWok9wlXatvDlHc+DsnyOPi2DscU?=
 =?us-ascii?Q?pgsEEneGd7762UyD5E6IVMpimeg6QFVznzS01qNB0Ta4fRb7J8Rvd4RxyyZI?=
 =?us-ascii?Q?3oDkr/N7dZ6mcnV1sDhc1Hrj6vk60rjLtKHF6pA3cNmEQ4S4XbOM3NeYm/7+?=
 =?us-ascii?Q?+IIgGdQ2zzBvuaihJlzrhl/BxT3Yamnu2x7Xoz1ftJLE2WZGLxAkkja0WoE+?=
 =?us-ascii?Q?7ftliP9cIR2X86uMAkwRHX/90v54/WS2sZorkHtdfrirkwCSKicrfkQIERya?=
 =?us-ascii?Q?OmPyr7FqakHosQajqVmg5WAafx+dhIa+Ee+728Ssmuwl9ucil59UwVyE+Pw3?=
 =?us-ascii?Q?djwMjVH+U+SGrSOPdEHgKFPqdLcJSAZ3NHOJLsL3CWkYTRtq4BxjFWeCkzHC?=
 =?us-ascii?Q?bu0jX4SMiI8oBTs0T1E1OX34MGck7WOjYQF1N13XkFESre9kpVxMhY0sRiq5?=
 =?us-ascii?Q?la2oXCqA9VWFtFF5AOsTN5ni399jsozlR3d5TVu/rwl7rEBXZSf3lwUDW5UQ?=
 =?us-ascii?Q?wrzskcRIiuZVbdNczFjMJrE+0MvPztUsRsLF6ZA8mIjODjrN8KjiJAezn6/B?=
 =?us-ascii?Q?LnohlWxDa5pN4oFjI19RjSBOhCkEm6LSn7k4pzzwUbQYMgaK0JayYz1G7BXf?=
 =?us-ascii?Q?f617DlneqdxBG2rfmftEb5YoS9zFZt5eA799MGf2IgBj33sqE75iJByYe7DR?=
 =?us-ascii?Q?Xc4ZCmlTVWLROnwwtMqKi3vhy//fchhWerDOHpE+zHGrE5KinjgQgqw7YbGp?=
 =?us-ascii?Q?nvLCcDOM19Rkzm9hbuCkNOV2h9uQO9Ux0tb9i/T73ZT5/ZzLItIgtUIiqPFN?=
 =?us-ascii?Q?M2ZxAn02DFNZUvW80sPdBH3wDOoEVe1N9SH8o//HAFmsiBeefatVpzzzJ7SC?=
 =?us-ascii?Q?BBPU5Zg0Bo1x8TISyj/SaLO34Mxog5mUxkQOUSkZG947I0srWSyJm1v6x8QQ?=
 =?us-ascii?Q?qm6J20HXT9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?whGIr8PIpbXmSaJLpxXrr2B7QsvJUH/XfCyJZf2woTsKzYGx9XDbgNpOAp0R?=
 =?us-ascii?Q?5vqtqSDkehvSUr2phHBz2v9A2gkEcjh+wRFxmwBmCRt1HaPrG9OY5b7tpHwh?=
 =?us-ascii?Q?tp8F2GmUg6Jt46o7wYEUbXcwhGRZnx0C3rN26S4pw1Uz8SK8mgZNrTn5hAom?=
 =?us-ascii?Q?fzANaIvTvS54dbckLI664HI5xYwPgU8/p+layCRbXEE09stZjI6A5WRxrdGp?=
 =?us-ascii?Q?T8HIPEzRDhzwLQOAFhcLOGFsnREw/Ni67L9yGuuGV2o4p7qvAJ19iU1X0Grd?=
 =?us-ascii?Q?ef8DSYN5JMq1qusdmIWGUxO5S7rQgLUhPP1DeIsxgbm7ZTLuOsdjWahzqTtD?=
 =?us-ascii?Q?v6f/LP+qa20DqzcbsxK8ljrL+z41T3NCQHIAdowGHCMrdW0JSIwTF64L/yF+?=
 =?us-ascii?Q?sJhUDOxPZLatHPILH3r1TDn7R1DKbNLxG3YciAJEMpmMoOaqHuFBpr3reW3o?=
 =?us-ascii?Q?HRLYqWLNmda5MoRbZXJ2WuzwfYhXJk646QCJN3qtGb6QL9JUZsxkZVwB+l44?=
 =?us-ascii?Q?67+bP1/3dp5p+mz1TS0KyaxVrO7s29N1C/KAJ4Uigb9sk1o/Y85hp1yKxd92?=
 =?us-ascii?Q?+xQK10qOr6hT5TSpH7i3e+V57EWA3pgOYNoZyk0Ej5baNE3tJBuxaoLnZqXG?=
 =?us-ascii?Q?Z7hPE5wiQmH2ViZIY+0G4WQ0dbefmGGpHBlN1NJhWSzNscu/xgYlZsMfx5dx?=
 =?us-ascii?Q?doSRGyUkF7z++YCQpa891mpJmhoHPz60tGRIW2Ng88E3xq5nraCf2INHHggh?=
 =?us-ascii?Q?FyiJxwCBQ7HhadyXJNpzpCqrxb4P+3ur+L8GFURxl8TkARqER+p+SAbCON00?=
 =?us-ascii?Q?b5UTZbfB6OQZdiNv/cRD/whaqs00IWPuiJUNUodS5dLmBLg/Pp7ah1wKQh95?=
 =?us-ascii?Q?YyD7QA5osv3V9OXrH2VQ0AMcKgOrgKwZ2LEYEPy2MLNz0QajsvzJfMJvxd7V?=
 =?us-ascii?Q?CHX8aV8PXNpiWIrDWoWKsdTjx/mpGJgxlkO0fSGVxOI2Z1L2Qqa1ker7U1UP?=
 =?us-ascii?Q?AMF9J+tz2R2ccPJAeCk2U6XjGkW7LrQXJ7w7HTSLLJA6/kHJEWxSnyqCcpaj?=
 =?us-ascii?Q?FtVj1Ti7YBn6TkUhEvFC9aSBt1thatbmIeGzB4DTviZHZoTUdIXqpSW35PHm?=
 =?us-ascii?Q?69DrVywGvyxs/VXPa7w9xmGdC2UUD4zO5an1G4ZkskT2S9hIW0XJo9NdYbnz?=
 =?us-ascii?Q?JuG1t42u+oT/A8UgpjN/9PrpiV3C1h90e0ohv2sSdKkQs2X1tZFQh/Bo8Gqr?=
 =?us-ascii?Q?Hgo8i64bcdTb4toTf0a2QjaEwPegEIhNNiTGa42t5ilcX4Ub95DOlkLvq26e?=
 =?us-ascii?Q?nUQ1nwWGL4d43K2VfFjDkuIv3M+IBYjl/t5h1p1h4JYnnIi9CF20Tg+tS/VN?=
 =?us-ascii?Q?zmueBCvdsssgegdBBUi4iVJ9FHtEG6/1nH0DcOYaIA6ab04CRNWYBsHYjoEs?=
 =?us-ascii?Q?pdep+g/1Fx1QtjH1hlAbQpmwR+8qKzIZU2u9GVXjfduf+YUcqvf50i/SGQXS?=
 =?us-ascii?Q?r5Zl7wfT8FyDOT3u32YaUhe2GHGjT9oXZxhb6I6LQ9AEn3J+9ir9+xOjOfk7?=
 =?us-ascii?Q?waof5wB7OzB59KTZLzLDabZdYHHg4grAfmX+bHoN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f13d8c-ab08-48c1-207f-08ddbf0b4f83
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 17:09:05.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TfWYl6KGebgpKx4VeLILaAeueUlGYjnri7XbAP/zP9Sei6y/ZK9+wT3GpkaAL+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607

On Fri, Jul 04, 2025 at 06:13:30PM -0700, Nicolin Chen wrote:
> +static struct iommufd_access *
> +iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
> +			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
> +{
> +	struct iommufd_access *access;
> +	struct page **pages;
> +	size_t max_npages;
> +	size_t length;
> +	u64 offset;
> +	size_t i;
> +	int rc;
> +
> +	offset =
> +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);

PAGE_ALIGN is ALIGN UP, that is the wrong direction?

It is just:

      offset = cmd->nesting_parent_iova % PAGE_SIZE;

And this is missing:

	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;

??

Jason

