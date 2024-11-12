Return-Path: <linux-kselftest+bounces-21890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDB9C5F59
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D906281284
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795AB213EF8;
	Tue, 12 Nov 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tAkda/BP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63ED2139BC;
	Tue, 12 Nov 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433514; cv=fail; b=uKOaKvxlrprZQvHRNYhWugHC2Jx86BCZmxISnOk7pg1vAetkBYXTVrDlFipEsZhcVVeNrdAMJeGiXR8YfsUvx84Kbam8r3RUQ8FCRVntp6fNBlenoEwZo46q6F0h+yYJ2WjrpGGmErq5tTea7c1YH/r187peoB71vl8L0GvWUUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433514; c=relaxed/simple;
	bh=gFEicbsR5X40RP2nXB5l6VfrbZgdtk3AEZyN33Sk4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oK+e7a+/7iXeX25NZWbFpq8jYm74s9C4TSBp/6+p+oBdSij/fGMk20OYOf4KBWHHVTnlg+pvogqA/Hfd8hADmczXCEQkDsRuixxlD1F/e3La0ORAijIxy0SWq34SdaVCVRmnZvoqPIaHil9GJeYwNsIIrPePXbybqxYDNh7mXLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tAkda/BP; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytivdE35HtfUV/VwoJG8N8CzmX5nXRRAc75fBIl2QJ2zNP2RD1YxJO1p5s3m/ObdLYpvNUVvcNzHg49rQYj3SDgXHfrH3jmw/sRRkqlEZkmgF3bjFlCT69iPBMH3Ph4YviTpW3bFX9hojI5rH/Opdzx9YD6lSmt3ZURKeB8NsHCtYdWDsClTV9wJ7smISZTBB9jStiO/7Aiab+A3iEIpwCB2tUdV66gwGuF92zkhtqNAcqsZ/T9NtvfnUiwNlSQBIeyKgcyecvBfw44O3XJbhofI19jQ9NtYQ8VctSFCM1kzGVa4mu+K2SxQOFJ5NiheLiAbzYba+svORIYMHGgI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IS5oxdS4Q1IC5qFsWhwUWYPoZXavEVYmTewAuPYXKA=;
 b=B7Bzk2by4JRU8z7iiFadvCCG4wifCcnP52KuyYrU9l940lGZLzZLvuiwoSuYqFb/CAvc9DrF45da0vVmj4G/YTvJA9x00vSw9Jym6Qx9kmSjP7tHUK23T2Kyw5C/HXbm1JpWW33ohvV81ksIjkuMFZWKsWFndnqjap4+AXXxTTaEbFK5AQkzboMLndBIKzqH1tcodvj2I3lBVLMjrH27A64CT3Ljzd/aB//btRzfEpuQ8/CV/nEn8RDtXMFBmV/6l3xnw3RAPUThPfXxxtJZWL+wOy476QDeAv85INcfwdN57KQI0ciw8QQp7ObQNSu2F8jd1uqoIfvE4hQD5SGUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IS5oxdS4Q1IC5qFsWhwUWYPoZXavEVYmTewAuPYXKA=;
 b=tAkda/BPAj8fO5Wq1eAxy+1v4jHGAm9ilwFOgZkH6qKdPNiBc0rQo6aJ+X8sB/JOecNLefpJmsj55Lm+xuzms2SLbaFe69g4bl+7J/bwo+tYP4ZvdNJEazw6nenWhISGiU/5NeIFR1tRqtxB6tp7rnXZ5OEtuM68arcwjUkDbzqBVU/bWu7aWvxT3pRXk8Zt5nOpTJNH9ANB/5FV37Bs+/2BrmGx0xJQlr5LcO17rKCS1lz+wQ+jc8XCzte1kHXuRo7Q3uOV2g9UBBR9BqVOtaakNSPUlNFtNOqMfU9SOrVYLMMk8XES5LX9jkr0GlMmhEkLmKFBErS0cTW9LW0EcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 17:45:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:45:08 +0000
Date: Tue, 12 Nov 2024 13:45:07 -0400
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
Subject: Re: [PATCH v7 00/10] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <20241112174507.GA35230@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe9062b-48f6-4576-9205-08dd0341bfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddtEEu3LvgqgjWdlb9T6ChFL6VaHVoo7HbpaBlleEimdT6aSa/V3Ir3TP+HT?=
 =?us-ascii?Q?bJghFjy8Yrjz+ggdIyl16zVPeHUxyp/i9umJ8Qwha6sPcA5r72/99s7c9zBP?=
 =?us-ascii?Q?wIm6lMB9JncqiHTKw3WhOkV8xRnl0OOVfBbhgToZGJEu6NRQUPslKuF22v0+?=
 =?us-ascii?Q?WX5dos9tnZ4zcjwAQEBdERFah5owBc967kzdN2OR7UhN52h8otQelLcjSxaN?=
 =?us-ascii?Q?N95aCjqpOTdTVg17d8D+Mi0gGcSwW46v8+0QLllLytPN8a6C7mqsOV6tcOzf?=
 =?us-ascii?Q?y6OryJ9NQVYUDo9lBeNZBUrQCm+3TQsGGbgDychv8tyQjb5nzGqeKI4QUGY3?=
 =?us-ascii?Q?bGZD4MmMxjgWfC4GnwTbL1ewPv665NVKXOZDshN/5tfDvAGv7VPquMF6gTkz?=
 =?us-ascii?Q?5eCre/o014hQDhVA46qNB49o1eZz/VRBRzCbtrVDk8+UJR/IxRuX0e1lVsoT?=
 =?us-ascii?Q?7begCkGSuHcPjjjJRU5/XQRWFfzqylHwuP0XyZSVz0Nzyp8tIVwFSmg3Gzar?=
 =?us-ascii?Q?Ds+j4+Xn7xIBTOXpIVNpyluhZ6ZsNZ5tCDE1098Kgo1lubSKnkROM6Io1WyH?=
 =?us-ascii?Q?ljsDvupjP27zFMgrM5Iq6CEKTqooNfiyTUI5D2NtVXKE0wfeW5ey9ZoIilEr?=
 =?us-ascii?Q?TpYDyu8fjcL41LXZ4iZzTs1Cj51GxXEIVEFHQUdptD4WQ7v0B/wi85um15zL?=
 =?us-ascii?Q?U3bBnBvSdVS/i3pyOrcfhxvju7Sxtds8zUSnGmIdbTAxV5N8NRriU9NG8Xcy?=
 =?us-ascii?Q?okdj4H9f2YHyI5KTQUHINIwEduELaOz4lqsQGYKyYRMKTzjjWUWOo/EJwRtn?=
 =?us-ascii?Q?17mWeYcsFZ2ZN6KYEHT5F086H4acZfJdXV6H20c676M2FBdcJb3t5y5w63vP?=
 =?us-ascii?Q?lXGGrltEixjhmyRcDQaBE6aJXH09+Uc9LXaZ1R95BxID+3SgNMNTI3UkrLly?=
 =?us-ascii?Q?w/NACige+VvK1ReCehwU3q6qTKa3tS8I6h8IZlJz4HpDrIOGXzjn1TFvchp1?=
 =?us-ascii?Q?8kaZkVJnRkRpo+JSCmq4t+wsbHTKqGsrZtyE5YWuOBzyT4TUItcumJ8D994W?=
 =?us-ascii?Q?HfhovdvM9aI8jOVw7RvfvcTAUAgZwWAbZ5AZicNywToiNHRNIxD4JEbQnP1o?=
 =?us-ascii?Q?1YivofdsdrPwIg+VD3RDCAEE9LsdgST26igJ/G3jABj/+VdOcZoayx5F98HZ?=
 =?us-ascii?Q?vvAd5bOMOq+F5HxCvXipU1F0drmD+6BvHuQEokTOgTRMlBKaZUaqRUudfcGv?=
 =?us-ascii?Q?JYf/Ej8k0jRJ8Az4ymhBoexH4dYJWmVCFE+a0w6/oS1j6sLp2IVGMQRWwrOo?=
 =?us-ascii?Q?nO1DHsNFDb9Y3mEo8RRSYsKu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avVzpodDf3uqljkcYOkJHAkT7qsFnw5idPEHcS8IocNzJ7h8VPyViSwanzcz?=
 =?us-ascii?Q?NprXb8XKk3pBsd4kFoTbvg3WlWoDJyV9AprdQ4XpsMUikAoX/VF7RGCsS3F2?=
 =?us-ascii?Q?JxcIP5up8YMgdpTbqwQEA8Wiw7rBgPZkAO6xUjAlNtgrJ+q9fiUtYn5X9Jr9?=
 =?us-ascii?Q?9Uhbl7U0gyAfH3kIbrnJpfh6XMyhb+mY6PxnVmxPJvaEJ/dcV+95v9vOoWG0?=
 =?us-ascii?Q?JhriSgrF6TAztMnlugRGxtVS9sz1xFs2zvXbYj/hSLKpKCdn21gGBkelkcW6?=
 =?us-ascii?Q?HCZlMeF+in30esKiF7ECD7Ksh7nI8mKRdYotaByqETQC9SoB8ty6rZxqZoLv?=
 =?us-ascii?Q?BpheVoyki8Z1qQlUjEbU/DSv7aGw7fSCicEB2VI5mAUBALUT+jjLlUWRdQOM?=
 =?us-ascii?Q?RZKEUvypZBG5CE9q4JS96D5SQLQctLrieKbZF4kDgrG16MT1xxybx9Dp6qhZ?=
 =?us-ascii?Q?I/gy56d84+Ur8WrrjcMmy4Qf5hS4qIiFs1C6qsOQ7NFYrxKpZj8ym41dS4C0?=
 =?us-ascii?Q?77vIHf2pQUM8A95Jtkz4r28/3sSOQDgVlE6LrQ4Qc/WpFF68zPJgyV2bZif8?=
 =?us-ascii?Q?jd7lV4bzDZBfkUHidP1vUn2ElHcHM/BTz7KXpQ8A+iBIq9YZaAbTa34Wkupw?=
 =?us-ascii?Q?hFuQL0BqrdPbr5GKuYkKWkJ69x5YVO0q1fRQxvDfTOLH5vJSd2uYB8SOdVe3?=
 =?us-ascii?Q?Jf8BxFVBjXvKoA23cmrParVO7dw2tjyuFz7uCuhODJxA+SfmSgEn4pcXQZmA?=
 =?us-ascii?Q?RpuDSu4skAZJir9RHRuIp3zoAttXuYmRAbc3avERZjnWkZJR4DB0gVqH1DW6?=
 =?us-ascii?Q?csvXvJOn0ZP/I4THcTlygfFqoHB++TzH2yXHy1BZ+sS84uy2oYBxJ5hXZ9y7?=
 =?us-ascii?Q?eiu1PaP8yTFRPJasYW/hY5ujejTb+fxMOhEuwjIhRXJCXIRXoqub9Q+tHywe?=
 =?us-ascii?Q?qiv6kag11nnM9XuxymsIDTyXcGGmDYls4OP4KR19hFXKTRt7hVbVDoHc824N?=
 =?us-ascii?Q?5/SliEHh1TTi6gnobHYVibKxNMwhaX8leKd9p+MbFOJcVXs62v+ZqUna2U/6?=
 =?us-ascii?Q?X+/8uSBVxlDWBOOwL4a1tYJ3ZeU6JPJvqvkVKBSzHIwtKusmglxiFY6u8J4/?=
 =?us-ascii?Q?R7Irg7ZCPj9LqNr5uCniLX3eWM5sUXi7uKiujMfClv+6y7ShoQiRoFLPX8B3?=
 =?us-ascii?Q?PHB0lqUWBgIo27NnNLfud1WRAEOW8moZ2xgK0AQjO8Jta5YoEaSAHULvcT2n?=
 =?us-ascii?Q?EDMZHzwDik9wogPF5Uv6b+gN8XXNpfrnx3qrlZfsIAbmjGIscC89mm3c9QW6?=
 =?us-ascii?Q?to2bO0N1L2dQULLT/qri9+zbEvDDe/BXpZzGDaJhckSz3PYSa0Pjs4DN4ISk?=
 =?us-ascii?Q?Ufg12phd4LNm/HV/9zeVEKyN13jJ9xFHWUaCV27Ul+L+WHKz1jsYyJ8pHtsn?=
 =?us-ascii?Q?p980Q0EYG/UB/+Ugbbdgu/UtP5N0Rx2Y6JNX31FwzuUexif/4iRHbQCrYGIp?=
 =?us-ascii?Q?hUtx4qpxvj9DlSG/4z35UYGHkRdqTQk0nBWEe/qC9B6fDIDwzB4qkblrQldd?=
 =?us-ascii?Q?8saYEjQcliGQIloqycOLcrRI1NCEQLG/iliS99jU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe9062b-48f6-4576-9205-08dd0341bfef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:45:08.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3Qhx0cIu++HWc1w4pWBo/ucn14XasHD9TAHyd14fHhK9jyd4w1218qBKNk9yGGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

On Tue, Nov 05, 2024 at 12:05:08PM -0800, Nicolin Chen wrote:
> Jason Gunthorpe (1):
>   iommu: Add iommu_copy_struct_from_full_user_array helper
> 
> Nicolin Chen (9):
>   iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
>   iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
>   iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
>   iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
>   iommufd/viommu: Add iommufd_viommu_find_dev helper
>   iommufd/selftest: Add mock_viommu_cache_invalidate
>   iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
>   iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
>   Documentation: userspace-api: iommufd: Update vDEVICE

Applied to iommufd for-next

Thanks,
Jason

