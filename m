Return-Path: <linux-kselftest+bounces-20805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A999B3129
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 13:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3454C2825FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E551DBB24;
	Mon, 28 Oct 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="obUZt44f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD751DB924;
	Mon, 28 Oct 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120340; cv=fail; b=e/MIyVeB/iyGADGpQJiwE+QbBQCMflIAhkabP16Cebu+yd+V3A73uuxQhTEO9JtW+EbwbhmlBqXdaBltU5ce+vXVX96UAVg5xkjklMAECp4slxs2pKHYX+IRDRWVCE7r4xGH3jLn8f74edi36rrLP5uUVTedpd9nw5J0jIbAruo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120340; c=relaxed/simple;
	bh=D1vxDntaLBfU/Sofhk2Jo0FtG5A9AMQ0mMgp+38RF7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tlCTv9AZ+FPhtNQE0KMZoJ0EG1owLO2knyR+Zcm0EC4u2j+lNqcnZRz5Jd0Rjff7ERIodufEx7Po4l4Vc10+RouMCQ/xff4hIRPF9wnJc7oNL0ytPbqS30jEDeFB6GHm4WlqMwsksdfX/WgMhWUK9zZpSmk9f+OhcEXOIrOqRuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=obUZt44f; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2lIktn1Te/nsYdPC+AoScUO9BKH5+MbdoX03wC6qRO+FwuV37kxMXWIduIDyoq8CfJyLpdIG3/m5Cx03Juai41nM6BNjpm4LtLrRCvsmlKqcYaPuEMsil90BZdHpOr9tzuo0u5FMNKqdxx2I/u6Gox72j/vqxsAsSl/IaPwCIA1xrCepY9BXx47HXMhUHVqSs4cU4sBZJdu7pP1ncxmm9ZOadZ9slnFpikM0TNSFWdSl64Ujvk+ojhIkUPk7zbeyXPTMYHotN2VxK+4aTPnbgLuVX8B1UxObNXamR1dcjBh1F4X5+mc7q0EstRo0UVxYNiu+MG/ppKRVe11i7RKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQslgWNWh1KpoMRSSlTA2JJZ0i6RhINLzT6+LN26EyQ=;
 b=BMkzBSlS8OWliy++Y/astdKW5NeV0GaPmItViUwcXHAGTvUXeqW6KbQsv+rBfyusEweBOC9W16jaxcV5ZKW6Xh/Uplx5ghtC8O6jPfgE2CUa+0LwN4y/yi6GzQ47gnrI1FpftLIHxk2PU5B0qWm4Dd9JcflmnND7YuCDY4oSP3Ug8ntJaw0qBaoZz3fYerXQmtEFr6Sk1tztEK9i64aWzy1DvvlRETx1J4om+w72a6ztKY/RHLXLy6khueG/pxlnWL4UvAveSshuqHAMr4KpkxWkufcRdBZWiOX/GPTlzaWCs+gPRCyA/yMr90wvUzHWZq1QntCNXTgAL82pPi1y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQslgWNWh1KpoMRSSlTA2JJZ0i6RhINLzT6+LN26EyQ=;
 b=obUZt44f9n+/Df1Prbjq47Pmbeo+ZIYlBAohUIiggQ/rlH6Z/MdJok1ZgRBV/lLhgG2GgDlCkvC7tEzWFW88fbvu8zoeWEFnlBaMj5Sp09FzqNv7riftrm2LxLCW5IW4IixA7ekEcVl1Qro+ml9L1QUrtUrxGclPP+LSQmgLTm8Qv3vF4xWucOJlnuTmVNW7H9ig3DHJ3Rs+3/f8hFoaKjk18xsEmsxYt1bl920KGvxUNe4o2xKNg8Km9Eele6iq9fcp/pDMx6xWs/PzZHeYxAmDqB4O3SZ4+aY7KZDIYpDfsjWRZ9EURTsgEAVvR1aMiToUx5uuxBk9/LnUPLEapg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Mon, 28 Oct
 2024 12:58:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 12:58:50 +0000
Date: Mon, 28 Oct 2024 09:58:49 -0300
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
Subject: Re: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control
 vdev_id lifecycle
Message-ID: <20241028125849.GO6956@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
 <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
 <20240905180119.GY1358970@nvidia.com>
 <ZxikJwzq8rLPgtmS@Asurada-Nvidia>
 <20241023165905.GI864191@nvidia.com>
 <ZxlGfgfwrGZGIbeF@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxlGfgfwrGZGIbeF@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:208:23b::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce4bbca-32fe-485c-37e5-08dcf75044e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3r9h2asA/atSv7Wy6SA3lIXpJt7EqFPUO5t9LQ6Npoe0uktlOMeoErqgNLG8?=
 =?us-ascii?Q?WHgGJid9UHmquah5kjtjKmM6FwMV4aNDKCegWlw2DVyG8DSnPGrGUjUbyQIk?=
 =?us-ascii?Q?JXp99KGJhmYBYuuNI5GqzuKFh0zhp/s4QBd8SiacS/Xa647OYfvn3x5KIMGO?=
 =?us-ascii?Q?Yb9Hv1r8PPsKDKHepJrIzuOlPQCSaeQJTk7kpf/baOxcBbAvExiAWQeGRkrn?=
 =?us-ascii?Q?ywa12Sp3FGVh1wWFSapali9V7iHf7kVlDIoIXFChR4Wy3IIq+20XF/KS1OcA?=
 =?us-ascii?Q?yrHYY2w81vAg1rhusU3L+AQUJv4YfNJm/1sxhhmxvRH/8qvKvECBeUQ2aTZF?=
 =?us-ascii?Q?aINyLZ31VOz0DO86S6j3PxtMabSASAudbb98JFJS7ZKyEm9/NE1uPSSdAo3l?=
 =?us-ascii?Q?LmzEAgR34BDkJUqX7PDYSOq0WGoecIcRyuFPlPj9dBHRu0Sq9U3JVmhVpPXY?=
 =?us-ascii?Q?wjn+K5zOZQlCf5w9IozyEBIJqYQnjObMV8aSbTKJeA3YhCmi7s5PBgHC9u/Q?=
 =?us-ascii?Q?5XodCDIJNhQkdjhFfUSYu+xz1dgxBkHZqXPpelh6aF7c3gJCXFosMmsymo3v?=
 =?us-ascii?Q?ckvdykAI7+/khPVbWKaJTfrvUOO5W9cCk5LNFzYfmz2ELq5ey+Vbf3sGCMxS?=
 =?us-ascii?Q?ymHLs5J2Ub3ZWPXiiB7cn6jNzN7F8fmJUe7QNerSMFodeTCOa4dmOroI75JD?=
 =?us-ascii?Q?QmkTd0KuQ9+L4iimJn+Rd8yk0r18k5DbFwqzRreaTeOIk52+wCV2qoOKtUXr?=
 =?us-ascii?Q?/d2NCab/amEewDOARBCd8aorjeu16orL1JLxOCNMYS4R3dHYoFbX8nDgQoBN?=
 =?us-ascii?Q?kwQbcDPN53Qj5TFQVa+OvamPMhReeF5+wLE9AuX20Q3s+vguKz9UNli4tmih?=
 =?us-ascii?Q?FKzMy0Lg9o7ThaDjIeOB8FanvCLguN5MvdDT502s3kEIMP4TUH24ncuskeZx?=
 =?us-ascii?Q?ECzZ3l8sPHEQ5T54F5+YjV2ZFoY+rUR5o4YkKADmolMaLcibENQdWIuvkzl+?=
 =?us-ascii?Q?QsZhAqtVCGhzie0B4AUOaMug6R78U4iIksppIdXlmr4clrAuH9H49xr5S7GC?=
 =?us-ascii?Q?vNO7WCazJtTC6NG056EJAMNB5TdO63xE7KCSpQXq1O1OaFbaI9rMmG/IZyFW?=
 =?us-ascii?Q?VD6elTBCOOO2d3JIrbrrLXhcSeWCeNmjPY+HH495dhqBGtpUjq/PCxNn+xOR?=
 =?us-ascii?Q?KjbR1a5w1JK/UAr7gdvtATzj3dmlw4xrJ7xAZ3OXbUcjnnodcmUD7FjWXX9N?=
 =?us-ascii?Q?N4NasrhFPkZNCfv4608XNAuuwEG6Vh301vCdrrwjEIvBk/UJO+utXEBaE+0v?=
 =?us-ascii?Q?4gk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TeSI5D4ZtC6rd98pNKHOuOjndA+XwaR67uveWOdASBnBrYQFwIOux3pl19YV?=
 =?us-ascii?Q?EUFIq/JkPah2nJFG/X/vH4+vjpJt/oo6jKV7P/3hkwghtVZCVg0b8SEfrs1V?=
 =?us-ascii?Q?X5DWxtZkiPGuLobIpOq0sQt4zphGZqBw3hdPA5GyF8jzHDHSGCKsvozao/O7?=
 =?us-ascii?Q?v1c4chUx4F9663ZgCn32S0c8sFI+0kG5WjKnp49lMcBm/hj5wQInjAM1pLyg?=
 =?us-ascii?Q?WdHNA1cQrOtsdCRqF0yLq0uJxfiTdlL4PDu97v/GU6qbdg9LDpJ60sUsFE3p?=
 =?us-ascii?Q?DIpsqlxNu4j0YCQnseQ8ak8pF2z/im+vHophGTAlWl7liRmHLdy+OgsRXrBl?=
 =?us-ascii?Q?UheY63UvlcYfnDjNnEhf3SQ6tZmmVvPubHz6wSQvXB1t5PmOqfodDGogAumP?=
 =?us-ascii?Q?osbiPhfKfgcn3GLMLHcHITZUIr1kQi0pG9hg8gMn0gF2XaQ+nMGwvlHRaiN3?=
 =?us-ascii?Q?Z9/wT7LTSiTdRobXybP80ultHjjGCqKTXJ4DDDA9EeqHcMm2nDNFP0MNf9Oo?=
 =?us-ascii?Q?x2/rZUpe4LRohLWGASpNOSZfk8bALqQNf8KPzOSBvRopDcF/FA56YhiXIbbQ?=
 =?us-ascii?Q?fCozH4wcZmdnZIs3OtxoYtGEYHUpEbptFKjM5qtnXL7Ia0Bs8yhQDx8EXZq+?=
 =?us-ascii?Q?0PhD2B2Vn7yuU2p9Ep+RWizbEMluSY3Qr+eBrMbpCJzah03AHta5j3ZQymWb?=
 =?us-ascii?Q?Hqq8ISP8fILESBcCH1i3ePMnX1rtq/VGxD7LpN+acf0cErgvhHIl6z0CNPjL?=
 =?us-ascii?Q?goAX5NVJkCfAaZzZxUW02PKPQ/WQjipMd8s2W55DM8sHPzulOAE6i3nK9ntO?=
 =?us-ascii?Q?LSx9hBGssMzXps3Yudb74aCro5GunKZe8/1aXw2mybNz6U6k14GfaALlp65d?=
 =?us-ascii?Q?u2apIvUBk81ygncv9CHagOy2DXgSV/MUSMVB87KKsISTAmuNrtPeXrsmEfsu?=
 =?us-ascii?Q?iTq7qD118QNjG1rAT2Y2yQz90Lqyys+01Xzx+KbTK5KuDoaat47C1vKLCp2J?=
 =?us-ascii?Q?OMdVN8qRf7wLYWwxrqFNE5Re1Qs2ye3cRvDziz7vSZggS2t6KsqvPBz2tmlO?=
 =?us-ascii?Q?2mhXGl0TEn/tpST8KGnxqX5olNpNfvqnZvB/8es5pRE2qJ/JMjIws++gD2YY?=
 =?us-ascii?Q?6KKr/eF2OsqSbBmQxcEt7qK5S3l42LKDq6Td9+gshNT8sl2fLyHro7MpRtI6?=
 =?us-ascii?Q?+KI/BtdTLFhbmPIPfDgkPVdqxXTD979Yq6hTvsPjOTygiNkDU7sE5PyKynzf?=
 =?us-ascii?Q?AQ2o3jm5etSFqjwNPC3S/hnrpDK5ghKf2+Fuktj7mye9Ysahoo0Snjm0o7AZ?=
 =?us-ascii?Q?36LXUHxpkwfxE1Tlgopncv81mrWpgD2+4di4FiM4L5r9Xe5VM0tLwlP/5+EP?=
 =?us-ascii?Q?oGqmprYEA9VlfW9hoDrHooTWeTD9c3/n0A02QfU3lMSHvxNyDkQy5yweEFpl?=
 =?us-ascii?Q?PuHoM/BDJ/J4TVzOiYM0yjZvjQIcpNBeGhPyxAlPMPDu1hEbQv9j8AX2B9od?=
 =?us-ascii?Q?ULBPzZboW3UghV/vooucNPipsu/rn6cNvtIU1kf+LxKrynda5/AdeQiwinsV?=
 =?us-ascii?Q?uiIQ04geb+yrab2wCAs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce4bbca-32fe-485c-37e5-08dcf75044e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:58:50.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0DTYdbrfJyY4wgQ1xnGNixw5H30bBeJYJl4z+Qz4bsNRZGXqvTz1juIc6A2GI18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428

On Wed, Oct 23, 2024 at 11:54:54AM -0700, Nicolin Chen wrote:
> > The iopf detatch function will act as a barrirer to ensure that all
> > the async work has completed, sort of like how RCU works.
> 
> The xa_lock(&group->pasid_array) is released once the handle is
> returned to the iommu_attach_handle_get callers, so it protects
> only for a very short window (T0 below). What if:
>    | detach()                       | isr=>iommu_report_device_fault()
> T0 | Get attach_handle [xa_lock]    | Get attach_handle [xa_lock]
> T1 | Clean deliver Q [fault->mutex] | Waiting for fault->mutex
> T2 | iommufd_eventq_iopf_disable()  | Add new fault to the deliver Q
> T3 | kfree(handle)                  | ?? 

Prior to iommufd_eventq_iopf_disable() the driver has to ensure the
threads calling isr->iommu_report_device_fault() are fenced.

New threads that start running cannot see the attach_handle() because
it is not in the xarray anymore. Old threads are completed because of
the fence.

> > But here, I think it is pretty simple, isn't it?
> > 
> > When you update the master->vsmmu you can query the vsmmu to get the
> > vdev id of that master, then store it in the master struct and forward
> > it to the iommufd_viommu_report_irq(). That could even search the
> > xarray since attach is not a performance path.
> > 
> > Then it is locked under the master->lock
> 
> Yes! I didn't see that coming. vdev->id must be set before the
> attach to a nested domain, and can be cleaned after the device
> detaches. Maybe an attach to vIOMMU-based nested domain should
> just fail if idev->vdev isn't ready?

That would make sense

Jason

