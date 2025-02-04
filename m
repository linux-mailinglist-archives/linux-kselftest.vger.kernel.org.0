Return-Path: <linux-kselftest+bounces-25679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C64A272B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395AF7A2EBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D8212D85;
	Tue,  4 Feb 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYnTFpMC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F08211A16;
	Tue,  4 Feb 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674148; cv=fail; b=PQGwS5v/4XJwdS0o29xp9k9r8D8edQJn3XiDLZ6l4TuRz0Y0Dft1HD+zcbjnVdDaUtr7GHGMkmhV34igBZi+oncrox2L18JpECZmdQNeIOg8/BznxSufFrBYOBDVIGD1sTeESisM3pe+7ihFG0mk0wa9GBlSAjvlYY5fBNaoXIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674148; c=relaxed/simple;
	bh=95l+OCPZExP3PtjfTTFHiYOuFRzyHawgC6ZyZElbNcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7H8G2wtATvPgWhw6wXzIxvdPG41XeTqOHqSPftFP99tTY2xCsPMIyX9HRepsplNAwd442MsYK3g6zs91915Gm7XlnUvXpPbvV3YgCn4Z84n7nK8oof0g3bJ3FTFznkm7A2b3+pXI7Wqq700I+U6YtockCI+HPdR1SGEBRwkEfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qYnTFpMC; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQf8jWqLRsNeBQnJd8C4kdoS6AH62YFhRPh1cKrrSP2X2EuoZi6ooJfxS/WA/YFKO10Vl+7Q3qjSkhc9JAPkLEkxYfVqKUcq+/C7/rVFXF7ETfV+dgVI3E3bGXIh5xav2b8iwfyZdtxjKcPBfRs8pxumfg2s0gBtZWmAgtVyLMyiMyb/j34S6ipXEYemB62ff/e5ZYwCNo4wyBm59JxutRYMRSDfEM6abOdS/XgNVO4myWJ1SunPvi8A1Ut7rIKHzVl1K+BOUUvDmBMcPf6tFDCuJsLwk73SymBA/Rh+r3CC04m5ZOgT2tzQW66Fy0W7fyZuxaMQFJU8Ga2+yVnGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95l+OCPZExP3PtjfTTFHiYOuFRzyHawgC6ZyZElbNcM=;
 b=IoglM9OdZqjbsshAXlCRoQOa4H26C8uqlllhhf96FV2p7mVpThpAMw2glw4AZvWPmY1G/Wy9yYoEonm/cl7OJ6lgB8k+9esp44YErHOmX4jXlpBrpwIJ6lwY1aJRNh9yIJRwy3hv2mucGfKtAhFKGcKHhV18rEb6RmmRinFXklN6RmBRpKPfp3+KDmuRN0KIWqXnuBtaUDXb870NPb0T1bjpVTiar6WNXwKRX41p0NlIMvJIndlCXlQSVuNP81JJQmRat7yX4eMAZt7SdBrBcU6KahGhI+A97zoyaTaNcAeCqIeQT/iZpBf4IL7JbIMtL/PZKxSjhFLM6hOUNVhM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95l+OCPZExP3PtjfTTFHiYOuFRzyHawgC6ZyZElbNcM=;
 b=qYnTFpMCZvPitBXSUyrNb7XWU525SFIQ+vyZcwdCMf+9rlMDU4fFD4zxpU4TMD6sHtCXo1CLJOnNrOg4Amuann+Zy17F2+U3Zsg7nyoT64FQu8XAipwA1xBR3Li7EWtBl26PUo5u49hklgq/XzG7TfWuzby53wu8Yyi3CvgmTZpfD9d1kLVgjg6eCiS81yHE7FSYGvKVpPn+AbcEfAyrQ+guM6XSulPKHEyRYpRjjBEA4yKLNThZbiw6lJ+y9ll+UfdNb64i5IJw8sVrMLcCYreteyPUwKw7KNgcE04pBZ3tRFwTLjlJIXJsRBYYm54pNE/rvH4c8c66HuRz6sV09g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 13:02:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 13:02:23 +0000
Date: Tue, 4 Feb 2025 09:02:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
Message-ID: <20250204130222.GY5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
 <20250123132432.GJ5556@nvidia.com>
 <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
 <20250129150454.GH5556@nvidia.com>
 <8e4c21b5-3b79-4f0b-b920-59b825c2fb81@redhat.com>
 <20250129201307.GJ5556@nvidia.com>
 <cb087202-3a64-428c-bba2-196a3612e5ff@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb087202-3a64-428c-bba2-196a3612e5ff@redhat.com>
X-ClientProxiedBy: BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb40778-1169-4d57-a039-08dd451c2aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8mYGxsbjs3zEE40FLdCDqS6yOrplzTxH5fuzly21Mp/i06+rpgsRrGeKUX2?=
 =?us-ascii?Q?EKiVZ3FPNdOdzrgjhLGiBRQ8B5dyW2i2jq9+38BbsNpC48NjOBummANlKWog?=
 =?us-ascii?Q?Jst1KUP4ivG6eStaTRzIzE2TbfWpDzeOMVTUQi01yGkIKVp94ynMAqQE5j+q?=
 =?us-ascii?Q?KA43Hh6obHsFLUcunKwzBSS85vJOqzNKVTC5IjXVCl9sDrB+aH7PCx/Ju+pU?=
 =?us-ascii?Q?7oA76lXvwpoKXEZ51QPCG6lTZEtblDmFNHR5pZ6LAWgawpy8+rX+/5cJ2fxW?=
 =?us-ascii?Q?o7AdDAsxk6I7INowtflpkXpKKtbpXs5ocREFB+45jaJtIxW1HxS2o8t5TNj2?=
 =?us-ascii?Q?3VxjU8YgDC4Sg7bNgXMkmv0HMSLqNiEk5v2VlOFR4lUCN+h99m1Rxk0xaoip?=
 =?us-ascii?Q?ttM3u3oyzcloRFeDpHBttJvyszkMNz4Ls1Xh1+OCGAMQhbw9C9/2zUJylQpw?=
 =?us-ascii?Q?qB/02/6G9XVFdtqqIcrmGURn4yxYQEStKABabSnnOonvqBY4mjGCG8s1CZ15?=
 =?us-ascii?Q?ZxFTLyRUY8XvxLjGf9q40DOT5YzS0t3vhXsOU1KYu4Wu9NggIF4+sEZ69Ypi?=
 =?us-ascii?Q?iAegte82trsqYXSOo/udA9PXTd+EegikiF2Z5NAY732F+jn5iy6HwSQtYkjJ?=
 =?us-ascii?Q?JDzDNfn93Ewa/amXluCRYhKyP6GlFbN58xZdvPGoDb3NrnoPRB+/Qv9cuv3/?=
 =?us-ascii?Q?KBwFSDzODi1JCEb+yX78wqlJR26+rjvaxqD5QBxYLUPCtGJn7m3XcqQo+Qie?=
 =?us-ascii?Q?WvwwwjFrGyelFr21mHxq0ir+Bj4valLDuNupSUtDy7MjWOM2Kfib2tFkEIuq?=
 =?us-ascii?Q?thsL/LLUqaimbMF1aucl0SzhUryRMq1UXS7XQEgL/yBhIgSWjFG0O4POACQ3?=
 =?us-ascii?Q?nWgq4qrSeQ4U8jqUFcmIIygQFv5tZGjFzINxPPfOTF+pc7lvci/VuxxBxeH0?=
 =?us-ascii?Q?//mIaMjUuc3cHA/jFa5OqgIWOFHz8+z96j6WlAsgGqJclOofkxUdy4JVVqQ0?=
 =?us-ascii?Q?Fyo5vMa+t+UYFj07gMaHERA9/m5STSScQBE/Kw7giWI0yWVip9taUwXKkVwP?=
 =?us-ascii?Q?EP0/ZY6lE9rGIDdh+f1PhyjTmVmKVlxaklCa4RvH0aRT5FBFG44i6NWpMPVm?=
 =?us-ascii?Q?urOdNAoNLMidRioC0l4APcjvjl6p/tpb8a6OzIxFCAi9+vueQUh5P+/SVLmR?=
 =?us-ascii?Q?nqYtwUOoBtH7X4fxc2wN973XM1Iay305X92h8CNZRM2gc/gR4FG3lexxa7Mt?=
 =?us-ascii?Q?Vu6vUluPjobpkcv7IN+YTDqUecIBYuQuLFodxbLjSadLHpYePJSA5NXFHHpg?=
 =?us-ascii?Q?JPcaeDxqxtTwK/T4KX4TL3TsAW53ieQw9kvmZ5vB9jY0ESJ4PetQrAPmbg7U?=
 =?us-ascii?Q?SfLOug7r+gWIP6ULaC446XS6ogzn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dYxX5FHTvQrQwGiupWBWC2KD/2FWuvERn/1ybXlwvg8OQ1SRJHnKiWUU1v7o?=
 =?us-ascii?Q?4yOCGg2vDSfeJZQIa11FIMB1YeafsvWPhiHNEqE9pNHF+CpLhJB8Qq2MHz2j?=
 =?us-ascii?Q?m0wRe0sA5EXxrTC+MxqQPzevbCov9Opa1gQS5RlhsHM6GyruAWo6dGq7iPOI?=
 =?us-ascii?Q?el76Hr7LsrRW77RyTDm3OuLevfs5ZcdSse7z6x+aSv7kwB7n9sUQvjjCdicS?=
 =?us-ascii?Q?rQA5MyzQ0rAGJutJGijj3kySIzdR9j/tTtyEAGts1Zb+YWGxPvgHgLPaYfvu?=
 =?us-ascii?Q?3tWV7RusiGwd3ozHfBKeM6vGqi56WF4rjNlJCKQnLt/plyo1XopugDiHWfOf?=
 =?us-ascii?Q?mgFWFaGIzLTy41I7sQdiGKw+jsd6AY3Qji4cMxJc08U7NH0cOLxrm7vezkr9?=
 =?us-ascii?Q?CmoRwoQ+GxmKtvwokqqTFQZ+Hf0NyHU99xFKcgP0wfu1TUTQ2cQn6qPkXqNM?=
 =?us-ascii?Q?Ml46RzJNIoGwRg68s5uKj/+PmjaH66F9oGxkZbsZ6hBCO7+eJIi1HWo39M6R?=
 =?us-ascii?Q?7EODMDfpqg+xBykQEs99m31ndyW+PryUOtSJHmbxu8AX2SPkWEg+92wzEndp?=
 =?us-ascii?Q?H7HXCxAb2Fzs87PAW8PFuFA8fu/Gi9UTePChIZ1zlw6u3VxurVWKXXAqTfFy?=
 =?us-ascii?Q?5qgRFmzWp58gZhd1Me9wZYiNLhGMNhoWEhEfqjBThCXEMYGArdWbQaSKlovC?=
 =?us-ascii?Q?2yvLXi5b2PyD3XNqSOSWa55WPxHKUkre/IBmlZIYgbNd6PuBtzFH9nO3NaXE?=
 =?us-ascii?Q?muXYXHCFgVoAu5MhaFcNUyrG6FzRl6o3G73hfg8lMpOE0WE5n9OSs6mrTno/?=
 =?us-ascii?Q?0vCFX0tH+xhvhBTGmJ/3kfy88JLrYG5xWSmGihEvv7v4gNmaHKUD5mPL+6RX?=
 =?us-ascii?Q?08500wYlz906lS6YWq7YOat6ryRn6a8vSft+g0bdqYW9I6UE4uAEEgS/WzZw?=
 =?us-ascii?Q?09Spsm3iLyFoPeMlAuHYUg771tuFf16m3cpBk/0TPbj0nO5d6DEI+m37iW8M?=
 =?us-ascii?Q?wB/NcLEtrWWURkqnPoOQp3wPKIS43yUrARrTOlggYTKK8zdT+fRdVjiXAsjH?=
 =?us-ascii?Q?DdHigb7+51p1+Az+yLRMEDlEhSAmvK9l0JXVL6y80ASN+6qxxcQ/FLO0+EYk?=
 =?us-ascii?Q?KchpnZSUpCQ6m91oWBOCCoHogoEnUMxxy0jovZZLMEDdS9fU4HZ+4wyje1GB?=
 =?us-ascii?Q?u0Wm/DnrS/xta6HQTrnCkwn08jeqGxcQyIKJQwrTCNjR30JQOBLq8vyT8hcT?=
 =?us-ascii?Q?IPaLwVTYMPHONfltRyaUz1tF4xlV+RBIwzYY/gR9dEzjC0FeKLdM1qSHc6hs?=
 =?us-ascii?Q?tea7r2M5oRPRFbkC2/Mj2HWEzl+T8v/n5zmsFhTmRwg9B8/s5VteQAn0EoZP?=
 =?us-ascii?Q?1TdeTiCJTBe9+O+2FTvCr5i2Uuw+LViNo8+5qg2SRo4fqf9tsZKudSR1t0lZ?=
 =?us-ascii?Q?Y77IBPn91HoueZolTR1I31BIVVoOD/GprOJ/20NBO4FcaF6d+RJJD3pCotzl?=
 =?us-ascii?Q?/KRHXCxC4Z7sJ5+2FZWY+rL/J1cqvd2bJphNk7nBv70N9UJR4KUoLUlGq6/D?=
 =?us-ascii?Q?dQt35arkPGBku/bqTFTqUpMugDMcl5nehQGxx0p3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb40778-1169-4d57-a039-08dd451c2aa8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:02:23.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miNxtunb8l03bzEo+ALeX+gDXqQVIf6Hh/7UVlCnIPpmqhdpdDJhVmYuf4M4DRie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368

On Tue, Feb 04, 2025 at 01:55:01PM +0100, Eric Auger wrote:

> OK so you need to set host sw_msi_start to the guest doorbell GPA which
> is currently set, in qemu, at
> GITS_TRANSLATER 0x08080000 + 0x10000

Yes (but don't do this except for testing)

The challenge that remains is how to build an API to get each ITS page
mapped into the S2 at the right position - ideally statically before
the VM is booted.

Jason

