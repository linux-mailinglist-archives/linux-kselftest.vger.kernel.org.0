Return-Path: <linux-kselftest+bounces-24999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5FA1A4D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC33AAB50
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58D20F985;
	Thu, 23 Jan 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYrOwRZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3420F094;
	Thu, 23 Jan 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638678; cv=fail; b=OLSY7jrv0PEgoa5cHTEtfDUblFGVp/rimE13Vg7/w/+O4Jy4H8ikqBbHcwIoZXm7xuoIAHMzc79JAKXzk+0raPyZl9hL0UGn54yuEYX9sndsgCxwgJKtOJri4GZ0BLP3tIb24LzG5h7o7MzABTKYjc3G1FHY589GtA+tvRA1qKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638678; c=relaxed/simple;
	bh=dOClK8VGMQmFsx3rHJllgrmaacCdHU65YKAfMP2rTCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BAk2h8kWBOLHX8BXIyhFgc6nVpzcdLrNBwZSHHlsnYog8pizkgRICKIPSJEa0wLt2Jifimiiv/sm43nhfbrTXkVz0NcPuoIwFw4UgJoxTdu7LxybynKR1TumK8Fe95vVuNxitz5mWjxhCz4uzbFW5E6EQiHlrTUHxW5+4YL2/CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYrOwRZo; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iActez7wJAjF+Lns+36u2wJHFgeSi4DrtAU5C1Otrux6kDKugHOqu9z2gzA9fmw5sYhwIbXnVgX+Fm1BK9hqPSjqk1CUT9rY3KpVq7gEj22Ljjrmcs2KI/REWEexhUEkrwF87qPVw+RpLK5kdS7vLvrSYTKiG2oQgkO5yW0wFNXnrKCedkDylzMDBAViDDmn7qWZFQfAduTmi0m7Nu20ivazBsUL9xaDH/tyRlllXpL/wR9CifGS+0EMohi+2MPdq4DJgFlIK2xdeRozyfdl5H+WuvSwopvz5hie1dOOscGA+4ZG29BmdrBlsF01jLS5+u/5UyWX4doEzRf5m4TXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDMBe9tkpgHPQpqtg06bZBRTKJ0SR8sQY/o1bRFp1/8=;
 b=qc3N1ir035tOf4WGUF3/KmqQMcL09+uwrpuxkJFbMwYjBQ8BXb9j3uyZTA7HuGz2cQMlKPvCJ3sSBaXh8lU1oKutERVhMg1O2Z9Ru+AQ5ivVPUDIAyIgIN6lJle73GrGV5G8Z84ATLd211UMjWdUrRiE5uXbE9EN5KW5QhJqCsaMZFsjdgGWHhTglkEAGwfJuGigAWSObEyK6JHo9TyG37EYFSH3gvKW/deJopRsTkrjkhi9aDVe5404DnGyit6Co8WocllRUcoCG5/sRmlepb1wxfYm4tY7HnNEefNCZ9V6QrSbkJzQRLRk3tvQhO7ZRrpMsGk9miWkZ9YEO8As5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDMBe9tkpgHPQpqtg06bZBRTKJ0SR8sQY/o1bRFp1/8=;
 b=AYrOwRZoS/Zana73LzH8mE2N1sHZfJDKjbvbt6Ysc8SQ4Tvtik6ra2hGUqaCSjT1CZpWfrWKlj1iXSMLXHI6fujoF26Ao7/g6UHDqOSUw+dfxAjb1SuB8klmvf/G29CH94wnl1B2kWQ8SxFAcEn+YiPJdYk56cN5OWRU6POiAYEjrlUCUPjE2c6rYuPa97qPhZB3yeL9865Bys39pwHpzpPgi9R6myBAPKTZWlRNyxJZxX9v5OS0qbsVXgl9bsbLLU/AcJC2RJbjoP8olnR4s8WPQ/jWoUdXMc+9gnpjVzzWt2m3OP1eqWACMXbf5IJJWyfQFA1pZO0BzwfiT4oU7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 13:24:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 13:24:33 +0000
Date: Thu, 23 Jan 2025 09:24:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"reinette.chatre@intel.com" <reinette.chatre@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"yebin (H)" <yebin10@huawei.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Message-ID: <20250123132432.GJ5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
X-ClientProxiedBy: BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 62321417-5c24-4920-49d7-08dd3bb14627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3B4IAQxSizldW4TLwBtgVuBTcgVeGHjca31TTJrmEU/l3WbNAntfU/YH5ViL?=
 =?us-ascii?Q?R/kXbGyZOQk8o2rliIF7/aLBBUNCS7fwu1sRAYQYpWHmfaX0xKK9HDkqehRO?=
 =?us-ascii?Q?gOa/B9XimM+JL05X5tx7lX1jjy5mJSRmNHx8K5jFkb447VvCUFjhAnszj6XJ?=
 =?us-ascii?Q?56lbcOR/6JWxf8sc61FSVni9jk4FG2/3MaLU+VEePObnVdFyNER1SHb/TjBO?=
 =?us-ascii?Q?Py1bvi0RKzzwn9uNJ5pfr+DOZDSBSZClXYZBN4tmaM4wy0JoZDfurNXvYihY?=
 =?us-ascii?Q?lYDIWaHRTqniWRZyqoFkKmgsUUE0TMXxyM+n1dF+n772O6uq6azTYg+nET2W?=
 =?us-ascii?Q?FnKEKqTgVYK/0K/V/Jw2UVhGHPIFiGDIhINucQwSmbbD4JAcQBcAC/nOY3ST?=
 =?us-ascii?Q?HoMJ3zzHv7dC7hrV00c2YTMKRU7GPP+cSr24lszFXszsmgPJFCiQbBxGVL3F?=
 =?us-ascii?Q?XJ7l40S+I9fPQlzrUP8aPcssEHBg66dpwoK2sxbWL9yPfQovDjsqz0tvUA/C?=
 =?us-ascii?Q?Q0uPvhFSF3Yel6+bM6rmkeLpmPCPxogttQjTm8KcNIBwpCxQKjkk1HXBjteh?=
 =?us-ascii?Q?M3LCvWgFWbEb0qAV5sE4G4JIbpLoBVYPjImMWHCjQIvHRFnvxxOnEI4qZLDW?=
 =?us-ascii?Q?RtYxSR9fF6f5+e6jEbCj6wOLUexWUxk72oK8jcWE4/QIEQ3PNa0Z366bmoUO?=
 =?us-ascii?Q?1z8LzXdeGd7dps8Jv6uFRNjbfNf7Pysx9IuJDwvrHW6OGx+ZEuqZRbwTD5L8?=
 =?us-ascii?Q?GC6AQ52lHT+U/mEHm2QE5FvAGjG6B3u+Z1884MmBNXtjrVkYX5endYpMMLY2?=
 =?us-ascii?Q?rlAAwSQZTcdVm1C9PAjJQehKIKT9BLKPVzR7gg3/wHH2hY75ufqxj3mw3mqk?=
 =?us-ascii?Q?xmsCXFvwi8Vahpk1zMn+zT2c8zI9GKV2eSkHfspmRIZYjtivAeXQiltKC4lo?=
 =?us-ascii?Q?w0sdNERPumTr27Z6MTE8BQ5m86IJEt+43ygLTmxEaAN+BWAIacoLLWHtyqKP?=
 =?us-ascii?Q?1Z8R32LeHrPh4N1+FyKYE5ZkY1x/Qy8SDQn9W/qIj3syvwOuER5nhnBDrdZw?=
 =?us-ascii?Q?/Sna5DGv1S9MB3kiyFn1p5m7I3WulDg5f0Pmzdhzl47nrWlI9n6+hM+v11xO?=
 =?us-ascii?Q?PeQbDIqecZfDOzq5AvL5oKlhMHCRtfjrREzaVEVwvN5uIwAOZKf6FF55rYPR?=
 =?us-ascii?Q?JCXWa18LagcLTj0dfmTEZ3o5YrXNVjldrRca+MCG5IB+llshd88/f8k9hO1x?=
 =?us-ascii?Q?0THPX/8BsyG5X5IjMs8s3m76cVN1aPWcuzjgVaaRLTOgX4dZp4D9u/1a6goT?=
 =?us-ascii?Q?epbIUszRz0xNxcaHWq320KWqX5WyBmEwmGkgCxQKW+E+B7+BiS36PWY0kxRj?=
 =?us-ascii?Q?Yjqv2xamRZa6MZpgAtby4lv/uq6z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FVPshtQZqipgf4r2aqZkGPRESafjsjUSLsmm/Cmqif7Kl8Q1E3PbLta/lB1o?=
 =?us-ascii?Q?fSDM6sanFCAMfy2FMyjjaUOmnOFt92tshum8K4yTN00uCdiSf6zoydaEbIPH?=
 =?us-ascii?Q?kgfN+GIb9FVmH+k926BzcEHW2cIab0W0j8HDNVFf1yvS0Gj8H7hREnLf7yXS?=
 =?us-ascii?Q?1ylvA7WBl4CQgMQELYNEPDOu0gYg08d/4DeMfhUpOUOc9m3EEA3NKLVhYhGA?=
 =?us-ascii?Q?3N1RYX5UC1fBpLGn0Fz13YkK2Aj6UMWaa983iBvOU0RFBIbjKj5e3wC5R4Ab?=
 =?us-ascii?Q?/9tIC+M5VcN4g2wjsPZP8RapSShz+S5OdXRrS3h9rBSiAsc+iOQPBorRiR99?=
 =?us-ascii?Q?NXgETrFTcYdLYllMwsMS0/ptiJSDknLD52y5XoB0Rho/FL9Q+HJqD6Lnv2E8?=
 =?us-ascii?Q?u3klXTVnEDlR0jNqkx3D76mUX4v2dGy5FjueMbCQg0favsk0gfXEZ8bfCd5K?=
 =?us-ascii?Q?72wWh/VVz4TomClr7/7f25ElYYe3FLdrnXLKTdbiLo7mU0XqfSpqc2iQ5e25?=
 =?us-ascii?Q?Wbi7xDPwcqatt7E4DTKfojY3M0UOBXXUarQKf5nSP0Khz4G6OAw8LcMDpF2R?=
 =?us-ascii?Q?2WBlWhga3MFDIJXYHd4b8Ct/tv7Jgk7ScFgMdP5qr2nzehXNlsq+TUbHXA9i?=
 =?us-ascii?Q?K7BplwdQgWZ/k3Na/tAapFBlgPksshcLgj5IK/JOUkFAHMWuJEmc+kmpk4z5?=
 =?us-ascii?Q?EqYXPM0bLZGDluzfuhNAR7zXDAIX6v7CblrZCcCTRxxxUnDQ6xjCN11ekLWt?=
 =?us-ascii?Q?op1fLM2oj4qnnXgEUILQ+Qd1IjUTrnxc032DCRnmyzm5Jb0EP7v9q3t42mgs?=
 =?us-ascii?Q?Jmo32UVkeBGmLwwRQIkJqexB/ARCBl8dWGkooKxrNrY04woEhmidyTJjbEue?=
 =?us-ascii?Q?gE4aSHSxYeukX6LFQzu64aHRDqbNG9Q5pJ5XFvFSJq1CIfx0HgFVRqUR9war?=
 =?us-ascii?Q?zNi223g0gzENZ/raH10seXu8MgVi7fVGYxcwtUmGdcvr6KIjTWQ8/Gs+HEWt?=
 =?us-ascii?Q?eo3SBfTGHgBD+fF7LjS8G+MlWFbmnHBcQrtP8VfZd2jsiBhbdwxtDeFUKVV6?=
 =?us-ascii?Q?4xI8hZGYucYpcYV87aCD5figU7ZDDV7HcuPlvZOfIoXaeCLQt0xC5i5xyINf?=
 =?us-ascii?Q?D2WywaGPb1A1NPW2+Am/lZJDfhoTnGLRDTOc0SsVmDBzw0F1Y5i3QzQFuyfW?=
 =?us-ascii?Q?1reBfquttHdQMdi/g6LSQfEYhtCTQ39LqlNjndred8SdalmETZou2jvk00x4?=
 =?us-ascii?Q?BkEaN3FooxL56V1EQ38KQ4ryTsV8gJpwMwX3+x0CX5mMkREoJhAvC/SIEKaz?=
 =?us-ascii?Q?FjvW2tQHDOw7vKtE24AC0pyjJe0osM9cU1c82NhPntyZ1xqc5B8zT3d92k/w?=
 =?us-ascii?Q?gKJQKwLgYDu4yvsPw1CU2jAtCTkY54X+9ZvRV1jmFurLyN3okh6slrSiNOyi?=
 =?us-ascii?Q?IW8Ox2hUchNVa/NC8qVIo9Mv82UBoWrjCq9xFtIjPnXGFdxb3vq1XFx716SM?=
 =?us-ascii?Q?GJYkLeek2b9tOIrommigh8DJaIOQIhQJiF89LLevJL8eDERIheBw9nfsvhFI?=
 =?us-ascii?Q?ov1mOGHiZnOPnOmckyY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62321417-5c24-4920-49d7-08dd3bb14627
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:24:33.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNyv6b4d/+ZVW8SKTW0fhNogkxWAvWZ7Zr+sWh6oC4Sla2QHopI98PEG0/8rmdq/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On Thu, Jan 23, 2025 at 09:06:49AM +0000, Shameerali Kolothum Thodi wrote:

> One confusion I have about the above text is, do we still plan to support the
> approach -1( Using RMR in Qemu)

Yes, it remains an option. The VMM would use the
IOMMU_OPTION_SW_MSI_START/SIZE ioctls to tell the kernel where it
wants to put the RMR region then it would send the RMR into the VM
through ACPI.

The kernel side promises that the RMR region will have a consistent
(but unpredictable!) layout of ITS pages (however many are required)
within that RMR space, regardless of what devices/domain are attached.

I would like to start with patches up to #10 for this part as it
solves two of the three problems here.

> or you are just mentioning it here because
> it is still possible to make use of that. I think from previous discussions the
> argument was to adopt a more dedicated MSI pass-through model which I
> think is  approach-2 here.  

The basic flow of the pass through model is shown in the last two
patches, it is not fully complete but is testable. It assumes a single
ITS page. The VM would use IOMMU_OPTION_SW_MSI_START/SIZE to put the
ITS page at the correct S2 location and then describe it in the ACPI
as an ITS page not a RMR.

The VMM will capture the MSI writes and use
VFIO_IRQ_SET_ACTION_PREPARE to convey the guests's S1 translation to
the IRQ subsystem.

This missing peice is cleaning up the ITS mapping to allow for
multiple ITS pages. I've imagined that kvm would someone give iommufd
a FD that holds the specific ITS pages instead of the
IOMMU_OPTION_SW_MSI_START/SIZE flow.

Jason

