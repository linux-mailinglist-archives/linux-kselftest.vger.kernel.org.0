Return-Path: <linux-kselftest+bounces-35360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B36AE042A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914DC3AA0DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B7C22AE75;
	Thu, 19 Jun 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FyHW480t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373E229B29;
	Thu, 19 Jun 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333490; cv=fail; b=XEn0GymQCmR7hLB9RKoXlVbNUExpz1z7J8nBqzvTeqUVK2GFO/dr7cq7CDGy7E/x2XBqO+QsP9E2E1ANSjJwxHMreHGJ2GxlESsrlwQk9mujHFjksayKXLPIVRql7FfcKi8z+spaMtUjRR2HB8hvXNvGfXX8vaj3bPJzTXW4fkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333490; c=relaxed/simple;
	bh=1FOy9KIFhpACFMitapijNSa8caQzRYqXQ57sUkze4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UtfPWHIF1GJnkQeHQrG5tYx5kdaPIA9bwXOV1mlOqAhIUHEIxS4vaXNzNOSpLBvEDqlufOQRuiFav/AJjup0sKfuthMJ+zzYyE7B36LaDGJfzqWVrRmjDq8/2HcQL3eu+tFMUSs8dCe6bHQ7QHTXWTW/cAQYjnW2p8Sn6r1Pc54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FyHW480t; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFNl6NVGbz5737zh3vtp/3Rv+bsK7seZm5lGD8cXE47Z/nY6uCkuyfF3V4r4lFGwh3rdFyflzXjrZkVRlQ0HMgzPIECTDtn9oXdoxOCu0noQhk0Vd4D+DFKHFapR9zvW64JFN8GD6aSUxzj0VBffPkWWFBPfC6pO89ElzzIHHpAMp51zDE3sLrORh6sVMrbEz/27gVjlpXY4c2O1OBmzygkxU7KfNY6UUxyl8FTgJk3JNIoU4c5qUIvHjFY3WH7SsdamiIE1p+IfzR4r1omsnQd70ekefFdOKqDCVtEzK3m4mLCBypUKYwRyMpMoFYjmhodS+EFg+1kigjDjlhBxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J/EcIxYjDu3Omiti8fppphMPcS/IMVyY4FDBPpQxS0=;
 b=xPatuDqRGGcjrtCOktcZWP39Z0FNa9sAlDkshx544d9+eqCp7WFSq4Znt1+syAfiyHrYfgWFoQBrGY/1bPgqrjVFTcOTRHTvjfVdhNQ2GBe+CkpCwvdWLYpghPTX/CSpLDex8rjmQ/FQ6ruEy3A5adXGOYj017Xk1BNWtd5QNPtHyKS7PVCTDqhmwwt1omGwLrL3b0cTaTlGWxG5527v+aGA7S24zHnIok8iwwuJctM5Gk/15OYxO9XCbMmPu6NlaUIHWmRnunm6N5w3Erpckn9tSvwQxtu7XZU66jO/IZMz3WgcOqahs5mPIC52lmSp3Jyhe/KIrPobA5AD0g3Qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J/EcIxYjDu3Omiti8fppphMPcS/IMVyY4FDBPpQxS0=;
 b=FyHW480t8xCQdWKpNdhA/ZrOmCB8HaJQyA7IZmzD5KS790+PYFEoUr4Dv913C0911AVcEHBZyP2f1LVPJfhZ67fq2te0fXntXih13Dmz2B44hrG2EFNMuEhS1NzfwbXERVCy7nKUKdiX8U8aIwzbSoagSBDrPXnhAVVMFpAWO1QXRWsEY/bg+IRCK5f4HIwn/Ohn253K8sQDNm9FAMFfmUzpa5ASONhwfFGnajpB2eJ974G/CEgGIrDEh3TGeFkunPPLFsNEI0xsqQC/ypaUUxvElMETUOlHm/h7OoKeDex8vvgxeREhYZ+vezCrBaAxNdKJkGPk5pO9+L92rakIHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 11:44:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 11:44:46 +0000
Date: Thu, 19 Jun 2025 08:44:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 08/25] iommufd/viommu: Add driver-defined vDEVICE
 support
Message-ID: <20250619114425.GB1643312@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <937d515032be07af36c06a4adb662ee2f7693c75.1749884998.git.nicolinc@nvidia.com>
 <aFPl1LD8r3Du-Far@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFPl1LD8r3Du-Far@google.com>
X-ClientProxiedBy: YT4PR01CA0492.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eff34d5-596a-471f-a71c-08ddaf26a528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4sYk5SdpmaD8EcvWX52NXzrhRvCXR8YHrpkNswk2NcamYnuAXFtBN4OU+/E?=
 =?us-ascii?Q?JvXNRNLjMDcEDUrdyrDSlnrIOuLSgytfa1i4yGMKO8frf94NEO5FdYEm3/NN?=
 =?us-ascii?Q?Ddiq89aayfG0yOuaGDH4mR5cXeDpxSh17EdsVeBYEL6NyFkWhIyKJl7uZ/QA?=
 =?us-ascii?Q?pxieRqo9WVagI38ZQc2eKwy2F62vgtGjKE0196ULi+QI/Us+NsThJSgy2TDn?=
 =?us-ascii?Q?UWPtVBygvseU4GcWLqFcFz8gcemi3l/ksA38UxXmmtAS4YPEcyIJX5tCdpRo?=
 =?us-ascii?Q?4f0Djeql9dXUou92hH5OaevsmX8vXD7SHErJVZZisb9ynjAUWsUAUBqQJVIq?=
 =?us-ascii?Q?bm2bmzRlsHop28vDs9RtScJwbGX5NNkWKdMKm1/pSmL9dnOgR3tSfE/C3R9E?=
 =?us-ascii?Q?oRusrk6d5wMf8kHyqux3/7rMmRK2L445k31/GSZGWlByCz4rXRsR7J+0e3qD?=
 =?us-ascii?Q?i3RTAr/k46GJ9/KVvNK8z/DYT1IzPtGwd2NA6rR9SiAExnsBb1FbF+v9nSzq?=
 =?us-ascii?Q?8XJwx6uDi1xpwtJFqJgf4VFYm2snfAN7C6ex8SdSZsX8lVgr0XY/OEjlzI4M?=
 =?us-ascii?Q?Ez4uPkDdn2M+tRgyn90z2NnSWBOS/Bsjwsm2pKT5xFLjPOQoNiTaxqyBMkdl?=
 =?us-ascii?Q?XbcNmLhqkANu1n/GOIPeIWPXcrdpEKUAOMV+1tZenG8Dh2qOonM2aDCkt1b3?=
 =?us-ascii?Q?Kuo5ZIFlhQiNAJruI9i72HETJcby9e3XxfXkzYYlGAqul398c83scpBEg5l1?=
 =?us-ascii?Q?a9NiOjTuJQoZvOf6vpTGrD3uSN1NeLgzGCPmRibx6OXjTNapyNAKsLWbAZRE?=
 =?us-ascii?Q?2Zi38x56PM1pssJt6lw/UeK+dooVxLSnxx7e0Wyds0co3oq+bRaypa8dVGMg?=
 =?us-ascii?Q?IyAQjMN1SI2XI/UJfxnfwAFMDQzfNFoEtQuB2l0KI1ziMO0LmoGcWtfBtmB1?=
 =?us-ascii?Q?NybL641Jl384x8U3Qs+acALfS5oJnxAj29JAH5nyvO9HYX1tlP+yOK6IHhsz?=
 =?us-ascii?Q?BU4Yq/7nO992Q1uw2Z/5SbOnP3jp/d7X1Ykjq+lzstKn6RZ+FNmtoCbAjsmM?=
 =?us-ascii?Q?QW2Dfw3gi1wvbzuc3m7fYBlcpfP7B7bpx/WCgt2hhLc6XI5ychhSzTzl6k6Q?=
 =?us-ascii?Q?3cL9tDxDGO1fB+fEVu8gbfbBec2j+s88UodaP0tzdcJaAcGnMGKy/3xnw60U?=
 =?us-ascii?Q?TIzgrSrZtt4Nt+PFWH3O+1Ch7yOfre64RZUTeRdlftv08bZKc/Tt7OiO0MIM?=
 =?us-ascii?Q?z9mE4HKrxFwi57bHJRXeUmYWs2JFZxjJRbomig6KagjGKDUMHc4YhtsHXRGo?=
 =?us-ascii?Q?MbEm/e9jEBnXEzBDgzACP2xCyMFMvYTJIDqu7/2xv66QCKfg/LptgpHnyvdB?=
 =?us-ascii?Q?obps2ALvS4jAXRBKAunVL3rd5mKgCB6p07ubil2WkqKB7+a8cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZs8mS2N5nzbPvn15H65wrEufG/2EFsF+g3zbm2g1BEf9fhMfjRqG/ZvMFSc?=
 =?us-ascii?Q?Ad3MnpHSF9D2NsHAm2FcHLOofw3dqX7DvAJUg1cehYYJ7Y5sV8WaiIcJaDSs?=
 =?us-ascii?Q?cQ8SWygrM8Etg6CklPupWHERrEA+zVnaq9uEQK37LmpRlDhrTsCd4nQ+ztpc?=
 =?us-ascii?Q?FVANg65dBZQGczhvSPEQstDb2LyUarkdzaQCszYUFU6cRPMneg7g2C3PLl65?=
 =?us-ascii?Q?0VY03dz+ofHRx0CiJIWyebqZoVO7CaIAI8rP836Sex0qyCOziLtRahmcFUS0?=
 =?us-ascii?Q?BN2XeUBiyLWqbqqQZ4ZJQ6wEdXs4FH6/GKnQP/+xInx6xCEkTNu3LvVgo9NZ?=
 =?us-ascii?Q?ENlI7huOUecgq8Y1QD/4lOeyRGqeAEUnPAl2PQ6RTRZJ/tI486Ah4e4INDIw?=
 =?us-ascii?Q?DhtjuElCzgniIttprBioXqTw+DglFIzmCT1Ho9pwLoW9hk0zMTpQJkOJJKw0?=
 =?us-ascii?Q?2UqFvqYDomljBoEXp+qaTEdZKNEltGmfYZpBCwGsqw70jVd7w4e+pgy2ImXl?=
 =?us-ascii?Q?ml1bTmoCiCT8HJZWYKJuyge/peSidG9/K0e2P8tf57DRwgATeG3VlDwdlT7H?=
 =?us-ascii?Q?BE3zWiJ3OtCiI/Sr/x30w9RUZAUsoqrMSz3sPXD70oDgoor7goaC0UHfcZH6?=
 =?us-ascii?Q?A7tkzP6gO2sh+H54fk1I2l/Edi+qMhI1oUnAjxnW03W4iRRxGgi0EhXs6HEV?=
 =?us-ascii?Q?O2Y3Zzbu/2s6Lz8fDwd9QCxG3kFu5IdAIlYClDUt/nATo7H46PW7pQ1bKsTP?=
 =?us-ascii?Q?QuASpEX+wY2meaQsCFw1/9zLVOSUpxau+sBI4os3agTQ9MN1FFOlPrS3FwZa?=
 =?us-ascii?Q?UUuAh3JoVN6Urj+rHlAFa0VQ7lZj3qZeanMhFs07lI9DKVo6BCyhRrNbVfpc?=
 =?us-ascii?Q?1xOElcMOJvkcweDmO8bJvOa1XYWF3uXFMPTVSUqtllpIaE/1YbTdaz1RN0S+?=
 =?us-ascii?Q?Wh2qYBdVUoisekr/2S6aQ+CPkfgfV1WopXTFlGtI70aiVsl+1T0LIrsF5pCI?=
 =?us-ascii?Q?vxJHfVJSFmle/h1KHlHj5ektgiYWNHslvUVAOw5CJwFSaTcDtZEtCHeHsf+a?=
 =?us-ascii?Q?WD9+dzL1enJKOwcwC6hCtvg/gVjm44egqAZaPYosxcDnNrFJYPfofmdAqY9W?=
 =?us-ascii?Q?pAkuEm9OuyXx5cbC0/VBqdZtU9NAB0ngtw4dl4v+TXkvUX5ddIysKxYT0sa9?=
 =?us-ascii?Q?xP/1C9Vn0HbzX46Naxe9NoowgDyZOfS9izLr3woC2SJ5kW2oorujZGjg6W9E?=
 =?us-ascii?Q?Y3Ercu+A/xgMIDpvd8cpXEJBA0VU9iMbvJEX992KcNJ/s73CgoCPJ9LPEAyU?=
 =?us-ascii?Q?u84w8Zpzj7CMNtxOBDyJcibZcXb740VmhOOCs5WbV7V01x2aEPJIUr/aLdlp?=
 =?us-ascii?Q?JAyEbGrt4kiux68B1b2/+E5Wpvn6B15OGhRjd4cFHH1veFGHP6m6fCRiQyEy?=
 =?us-ascii?Q?H07e93KVDJtMRUtPjIo4pghZ1mms35qRXFpkBiLGGXxQ6FT/DE2VqNHy13ib?=
 =?us-ascii?Q?XQcQDHy4jnF3QJ2U4QzRq+JpF3BQjH1K6/tBbh15ZY/U5LcpsUw1pltBLrLO?=
 =?us-ascii?Q?5n52CnivWXLgdkvyIeQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eff34d5-596a-471f-a71c-08ddaf26a528
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:44:46.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9ck+U+BodpzKHO08XMSwci38ud7kwfk160Bm8OcBZMg9FCfmlpWXrUNEvHXm7AF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

On Thu, Jun 19, 2025 at 10:26:28AM +0000, Pranjal Shrivastava wrote:
> > +struct iommufd_vdevice {
> > +	struct iommufd_object obj;
> > +	struct iommufd_viommu *viommu;
> > +	struct device *dev;
> > +	u64 id; /* per-vIOMMU virtual ID */
> 
> Nit: Why not call this viommu_id?

And lets have a comment here too, we have so many different ids, what
id is this id and what it is used for, by who.

Jason

