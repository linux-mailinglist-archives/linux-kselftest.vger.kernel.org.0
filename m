Return-Path: <linux-kselftest+bounces-41888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F3B8660F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711024E1FC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873982C327A;
	Thu, 18 Sep 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ND86gf69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631132749E6;
	Thu, 18 Sep 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218829; cv=fail; b=NkI1dxB1fB+fLGsuRJI5deTrgJJuFIVuqfBOARE9ztEgKi6x4xSxQz2DtXNA1HD+bm+WM+m1UKGtLfbdfnoRSKYcsEdD/ye+/mn/sT6lrDZhoZWlP8ePs8INVgOW378jLQZLf0QI3Zinc7Uwvrwh8D8Tr0n3thYNMfb5bKA/3PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218829; c=relaxed/simple;
	bh=xSmMWBiSd9nupeuCrPQ/HQwd4sSgMs1u5X4S7GkXpEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZbmGxLyNbjH1P6pv5jOZoQ4sTkCJDgqgkVEfG8tB1UfIcM/z5ErHfkG3NHtFpLfrRTpxkX71d0TDKKYISjWdj5OgbKvqWIwYYHq1HbxgzhbIpvoMpy9/zcX8NALu/C85ZxpM7I2TRbDp+Y1BxJxkG/Md/mlG2uUw25b855jml9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ND86gf69; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b36LM+YYR+dUs0ihb6XGdNf3jVUTh5OcW+sNzK3/+TFcTCLJSlE1zrtfXdtk0vSHYjoXzLCWQVgX5L6jDU+6oHR/BrYaOLmXPY6NAJWBnr7N0qUsqFJ78yAwiiE9CnVcPCR38CsUkKG20C5F7qMALp5UftetpIyVCxTnOH3l7PBE6zP+whTjUCJhpTc002SbJZCezWoEGe1WgxmIQXk6zciSQAbBu2l7LyNJGfdbhOuwgtgYfjc0t16rf2SfvsE8iIt1RVOaGxZa9nCgvUsdPdzlol9zpJx3w1rDBsNZcYgjyz/QPwJIfHxvTmNS4PtDPFaFEh8+qsvqBJYhMAl+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygJujrPMWdqZLyG54ZD8dgZ5gpz9L57yUXS8wIFwWfs=;
 b=abd7q/RtPUClVh/fNqtLIyspIswkHY/u9w1TVlw5AallDkqUeRtXLKfkEfbc8aDz90/f0kxLPCo79hU+T4nEAKV7tycN2Uc3JmJuhLUGFS43sW1oiS7lThEpX9iywcFdlmM55qTP2J17WgeLtYtk5DuizuBvOCdndCHpZzup7+Nm9cjYaqeq3ZGpFyMZoa2NWrhiF26799gOcWyaKvsRMUAtroVk7Sq9loNd1InC/jO+sDe1A8n9GwTEXuJ7HAnIBpIh82CXljGQk3XLB+F5kCTDwBonAEPcZefOzKRdR7+LgB0gToPzrV1ukIBjJiP3agZ/T/+Zie0KB11CNRMy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygJujrPMWdqZLyG54ZD8dgZ5gpz9L57yUXS8wIFwWfs=;
 b=ND86gf69SnpTC4sfa/LstCQzIUVMvaSkjKXEbJAYVCM+WtIiHhyrZwFB5P4XCLzoTC2Q/v9s1K52dlqWzAhkxRXuyJOL4Aiq8eKsQwo/3nHQS/6RX9doSh0B8tDUeBSY4dIcrXbHBDSNikdAgUfkymn35fO/qrBVZobQ61MDRPGzRMkO9HhjtSQ4XUanKuwl8tBwpUvAJ8d81QYpGXCw+JIr6pRgEyZNce8e4RzwTA4aFtol9p4yj86C/diYnDIvCDKxbph79wqirwfv33/HaabdR7SlA56Wfb+JbOCAL73A/0NDP1K+suNkcuhp8EONoRpDZTVOFE6Rx94HjzlhPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 18:06:59 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 18:06:59 +0000
Date: Thu, 18 Sep 2025 15:06:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <20250918180657.GA2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527669A84AD24A550FDDD85A8C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527669A84AD24A550FDDD85A8C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:806:24::26) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3fe49d-cfff-4f13-0ebf-08ddf6de295e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eg7cQU+r/+PV/qDukf1QEIF14emctmadxd3V8c+LlP1SjezqbjPHh4mHLPG5?=
 =?us-ascii?Q?vKKLBWXQ6YUEpfpXRMMwzps5M38yN3UsP69pWCa6duPmwj2iAR/48nHCShDI?=
 =?us-ascii?Q?BdSNjQHT5qr6c5YbKsasta0Vg/p9jIEXMnhoFrA7co+u6SLFGxjX1YynyUVA?=
 =?us-ascii?Q?bnf8S0/Gba2AFIEyN+riqAghKTaVt+qcJmHJozh5EYLoRPAn8xjutQjh5zAy?=
 =?us-ascii?Q?Lu8Pso6eMWYeTurvgSIm4n82QBvkzWLHcfimuK3H9oK7YNlB1pEW+94yGztV?=
 =?us-ascii?Q?WaBKG9iAX5TQotktRWvSasn8hTHY1I5LJzOjHeQ7txhWTg1Uu9cSBDHqvHc4?=
 =?us-ascii?Q?NJ27vd1lMHbo/IthYvMMON3toVF4FCXC06LNUXIXQgGtjGQM5EtVJVepheyM?=
 =?us-ascii?Q?vlMGI/Ofe79VsvSJukzHojVTFES60k2PGqfXIIICpWrTTqwVCuaSWbgOSlbR?=
 =?us-ascii?Q?N0cNruU8+tJr2EVJuFg88Tu9pEPSImu/NB2VYXNLMXLM9+Dd/8v5Nx/S10Al?=
 =?us-ascii?Q?2LzP1X1rotBfy5Ze27aizKm0oI4u9uHXMQhIszf5wqRtzRa1wu5ZBdvprP6l?=
 =?us-ascii?Q?ZI/Y0BMZDxeiGdK6kqWVPVKEv5xGpHZhdfdvWaOYTswwOZrrplnmuDtT6mgA?=
 =?us-ascii?Q?6kZz8n7IZJEn8cG0VxxeUtKhS32GA9a4ZcIvlnLfgzjgAeBcaRprNkJc4auD?=
 =?us-ascii?Q?7aGVfbLCW0aqsBu21IRBjh4/rz6VlakQJLKB6XMpsHjz3UW9awpJrKs98LQM?=
 =?us-ascii?Q?+WyVubaEGrz2DwxpHbWQgr3uXHkZd2WjIIo0PvtL867oEEksSrnMri2scwxL?=
 =?us-ascii?Q?18Bp2DQJUb6IXJ/msl2KOvl25PhbI2auFc+IWH03QHmjyU1KtcLXVbvS/Cjj?=
 =?us-ascii?Q?wPv6jEm5LXU++T7RvIagP4blyYtyMOp1+nvmU/tUUZT1G/XnPykVQYD7QLfK?=
 =?us-ascii?Q?sq2BPFxlVJiSUPKc+MHIPNmYYhRh0uHPRZGdf5lw/P/dmq9RYWQAx+7F9KXb?=
 =?us-ascii?Q?hMaRN/O9fxyJUHEpdNfJp2f5uoh6itq7GYsjRDUZwH1H56YdWwv0bxpU1wwO?=
 =?us-ascii?Q?5Dz9S/nwU/mKCUVnM0mPnHgbDkIPEv70FW5N2Y327NBRLCEbKPbQsI744e6B?=
 =?us-ascii?Q?xoZsA5VBnaF0VztcWRN8XtNHnIJTEm7iRoKrv+ny8QG11P7/jLX9M+Nymsje?=
 =?us-ascii?Q?RO8D9BAjHo0EXJptZpXhT0CrSLPD2/ASbl3xy7LPritZ6sG5J4mGqtInPhHK?=
 =?us-ascii?Q?fR5Ue1xFGOkSSIJW9R3kB2H0Bjuh7htFTj60WsJaeL4nt9Vqz86BhKFCmKIa?=
 =?us-ascii?Q?1RWSs8nv+G50aaOgPBX7U6xAcw6NQbgPslcXxFdd1oJgHxyNkmr/NIkiWOka?=
 =?us-ascii?Q?mnz9yahJ9e9O/TMFRJtblr41IHr0YWUdy3ChMmeGJTOLeQ7P/pPcjCu81AHy?=
 =?us-ascii?Q?3GexVo9MWX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5k0WEQfe8OxwwmcNI3y5IE+t3jzn/eTS4eoZbuRxY4YvBrhPcdDfYEwStIK?=
 =?us-ascii?Q?mPkKSHgJ4BaSWlK2k0jNi5yHuegKMxSMk/5t/Ia/YYLvPbKJkC2/OLPLWsK5?=
 =?us-ascii?Q?y2Iasrsf8wMojwWKDK8OVYlZfhqGPpMsD5hBUSuAxJ9hP0rTpekZ/hndMRQQ?=
 =?us-ascii?Q?bwcOQQHCDGqAiU7Oh2yVJjVhR1mU7/wdSEcojPQpihflWe9QM3q2hK6TWbxp?=
 =?us-ascii?Q?9OoDBxjvIt1VEDywww+Q8MOCtI1ja8TydT3Q/tpXoufpROzZp6mxKzArGM9d?=
 =?us-ascii?Q?q1ON5Q1ngzy7CnLwGPMhejs8/ObVnR78KCL4+SamlE5gbQ5eFkKxvqhEr3r2?=
 =?us-ascii?Q?aZ5hgS2L+8dLUoin2aVbt9JRCQkmqPI/0IaaZ/Y914f5XJtp6QB5MfT4EX2m?=
 =?us-ascii?Q?0aaj2mXyKIjfSa8lIwPtgQ+tiAN00/yOxdrdr716AHqgFcuiIyfJTS3OA0eT?=
 =?us-ascii?Q?wsyyEtCRGFYoXYvBPA01GR3UvDsgvQgmCcFpvfyC8kj0WfS6i72dbVq4amBM?=
 =?us-ascii?Q?k4uIE2mppUcFXlgcJvVbE/3JUQfIuGOOtrNAQ7cIYrrmC6EtgJT82/lxWX7Y?=
 =?us-ascii?Q?rmaRvbD+we80COv2DnbVr8BuOxUMTSkhqHiQ8cqO1NcAA7us9TMOxWXu0ZRX?=
 =?us-ascii?Q?8Wbba+G0k5XvAn/fn1e53C3xtYNe0AYndCRwtIw3y0rSQlWrtwwQAn0f2w0O?=
 =?us-ascii?Q?hukpKfYEaoN9Q9d6iBJsf6Sxh6PkFN0gI3PyADh/Wv6tIqGk1u0u82tRfgR7?=
 =?us-ascii?Q?AOrN9W2aKvelpnyam2nxQcMoDph5NZThM1wYL4tuh7NSEg/vN4slm8QfzWVB?=
 =?us-ascii?Q?omuHN0bFt6k9VsVb/yCNlbTlF5rO6yTGoEUd3asiFgBmkva1xftITssnfTC+?=
 =?us-ascii?Q?M2OBs41TYOhpa2iOX0l00/z2dItFp3BHtuCVAVtTkezxP9LlNIINfqlcRZiY?=
 =?us-ascii?Q?fX+I8vLc1z5ipI6qZ+0G/1Xa2KDIDaHuRwEx63FFq3JapTTQ70aBurUvIZgz?=
 =?us-ascii?Q?ARb14UvT8aRn89+KllhswEhXkpiD1EC3PTQxVE+ILxQrrkq8FxDeugqloQBl?=
 =?us-ascii?Q?EDl391y2x/EahWlDnwOhvaxg2B+pwk2+9XRCR1SvHFOf/M4NRu1MXj8ylV3j?=
 =?us-ascii?Q?sFcquj3tEIErkijiXbWZJiX0Tm9/rmUjBHnAYWhL/jKNmA/vOWo2cR+6XeTA?=
 =?us-ascii?Q?vE9CBB3IXir2Y/nal64CDhRxrGoakjh5xjPUEW6Bsqxj97ss18CmLogvN2JW?=
 =?us-ascii?Q?vh7essfLXZXfcd5W56LmWdcqNjpCvDUDid9nplf5+ndN6E0Pc/1NuhybxOjS?=
 =?us-ascii?Q?n9sGoovB3Mf4yYKYQGZD3ZrJpj0duFY/d9NEscjftIF9RLi3j3jUU7uIZ1hB?=
 =?us-ascii?Q?V5IsS01nb0Dz9grKZbLwtLphzkMkRNgdxJFIskQuhhLejyNFo3bQxkHhLcPg?=
 =?us-ascii?Q?ZLSwWrurng8D2kPYMubk5D/8ZXnhcZNhQbVLoyjtmrVpY5IXj8RceDhmeByW?=
 =?us-ascii?Q?RFljbsjSr6/U9p3lGh7I2Lpun7kyAaOBZZ4s49K2R49cLxdGDLVB1Eb3uLAc?=
 =?us-ascii?Q?GMPrI7i0L2QZJAWVaNV6XkVzAutgoHa8o9xETe5X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3fe49d-cfff-4f13-0ebf-08ddf6de295e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 18:06:59.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2l5l5MEe4+tlxD+F8DABg39TcJSCgH914FJbYpUXGxwZg6Cq4FW6Y3wGWD83vOyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628

On Thu, Sep 18, 2025 at 06:49:08AM +0000, Tian, Kevin wrote:
> > This is enough to implement the 8 initial format variations with all of
> > their features:
> >  * Entries comprised of contiguous blocks of IO PTEs for larger page
> >    sizes (AMDv1, ARMv8)
> >  * Multi-level tables, up to 6 levels. Runtime selected top level
> >  * Runtime variable table level size (ARM's concatenated tables)
> >  * Expandable top level (AMDv1)
> 
> any more context about this one? how is it different from the earlier
> "runtime selected top level"?

How about:

 * The size of the top table level can be selected at runtime (ARM's
   concatenated tables)
 * The number of levels in the table can optionally increase dynamically
   during map (AMDv1)

> > --- /dev/null
> > +++ b/drivers/iommu/generic_pt/pt_common.h
> > @@ -0,0 +1,355 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> > + *
> > + * This header is included after the format. It contains definitions
> > + * that build on the format definitions to create the basic format API.
> > + *
> > + * The format API is listed here, with kdocs, in alphabetical order. The
> 
> Is alphabetical order important here? It's not strictly followed, e.g.:

Let's drop it, I think you are right the grouping is better for the
generated kdoc anyhow.

> > + * functions without bodies are implemented in the format using the
> > pattern:
> > + *     static inline FMTpt_XXX(..) {..}
> > + *     #define pt_XXX FMTpt_XXX
> 
> or provided by pt_fmt_defaults.h

 * The format API is listed here, with kdocs. The functions without bodies are
 * implemented in the format using the pattern:
 *     static inline FMTpt_XXX(..) {..}
 *     #define pt_XXX FMTpt_XXX
 *
 * If the format doesn't implement a function then pt_fmt_defaults.h can provide
 * a generic version.

> > + * The routines marked "@pts: Entry to query" operate on the entire
> > contiguous
> > + * entry and can be called with a pts->index pointing to any sub item that
> > makes
> > + * up that entry.
> > + *
> > + * The header order is:
> > + *  pt_defs.h
> > + *  fmt_XX.h
> 
> s/fmt_XX.h/FMT.h/

Oops, yep

> > +/**
> > + * pt_entry_make_write_dirty() - Make an entry dirty
> > + * @pts: Table index to change
> 
> it's about the entire entry instead of a specific index? if yes then
> "entry to change" makes more sense.

Yes, cut and pasto. All the "_entry_" function should internally
replicate to all the contiguous items.

> > +/**
> > + * pt_entry_oa_full() - Return the full OA for an entry
> > + * @pts: Entry to query
> 
> s/full/exact/?

OK

> > +/**
> > + * pt_has_system_page() - True if level 0 can install a PAGE_SHIFT entry
> > + * @common: Page table to query
> 
> pt_has_system_page_size()

Ok

> > +/**
> > + * pt_install_leaf_entry() - Write a leaf entry to the table
> > + * @pts: Table index to change
> > + * @oa: Output Address for this leaf
> > + * @oasz_lg2: Size in VA for this leaf
> > + * @attrs: Attributes to modify the entry
> > + *
> > + * A leaf OA entry will return PT_ENTRY_OA from pt_load_entry(). It
> > translates
> > + * the VA indicated by pts to the given OA.
> > + *
> > + * For a single item non-contiguous entry oasz_lg2 is pt_table_item_lg2sz().
> > + * For contiguous it is pt_table_item_lg2sz() + num_contig_lg2.
> 
> this sounds a fixed thing then could be judged within the function instead of
> letting the caller to set?

The point is the caller specifies the size of the entry using
oasz_lg2, the documentation above is explaining how that math works.

> > +/**
> > + * pt_max_output_address_lg2() - Return the maximum OA the table
> > format can hold
> > + * @common: Page table to query
> 
> pt_max_oa_lg2()

Ok

> > + *  leaf
> > + *     An entry that results in an output address. I.e. a physical memory addr
> 
> "I.e. a physical ..." is redundant to what OA already explains

Yep

> > + *  table
> > + *     A linear array of entries representing the translation items for that
> > + *     level.
> 
> to not mix 'entry' and 'item' in one description:
> 
> "A linear array of translation items for that level"

Ok

> > + *  item
> > + *     A single position in a table
> 
> 'position' is called 'index'

Yep

> > + *  entry
> > + *     A single logical element in a table. If contiguous pages are not
> > + *     supported then item and entry are the same thing, otherwise entry
> > refers
> > + *     to the all the items that comprise a single contiguous translation.
> 
> 'refers to all the items"

Yep

> > + *  item/entry_size
> > + *     The number of bytes of VA the table translates for.
> > + *     If the item is a table entry then the next table covers
> > + *     this size. If the entry is an output address then the
> 
> s/is/translates/

Don't follow?

> > +enum pt_entry_type {
> > +	PT_ENTRY_EMPTY,
> > +	PT_ENTRY_TABLE,
> 
> add a comment to be consistent with following line

	/* Item points to a lower table level */

> > +/*
> > + * Try to install a new table pointer. The locking methodology requires this
> > to
> > + * be atomic (multiple threads can race to install a pointer) the losing
> > threads
> 
> "... install a pointer). The losing threads..."

Yep

> > +static inline bool pt_feature(const struct pt_common *common,
> > +			      unsigned int feature_nr)
> > +{
> > +	if (PT_FORCE_ENABLED_FEATURES & BIT(feature_nr))
> > +		return true;
> > +	if (!PT_SUPPORTED_FEATURE(feature_nr))
> > +		return false;
> > +	return common->features & BIT(feature_nr);
> > +}
> 
> common->features is already verified in pt_init_common(). So above is
> kind of an optimization using compiler to filter out static checks in fast
> path?

Yes.

> > +/*
> > + * PT_WARN_ON is used for invariants that the kunit should be checking
> > can't
> > + * happen.
> > + */
> > +#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
> > +#define PT_WARN_ON WARN_ON
> > +#else
> > +static inline bool PT_WARN_ON(bool condition)
> > +{
> > +	return false;
> > +}
> > +#endif
> 
> Then call it PT_DBG_WARN_ON() to be more explicit?

Ah, I'd rather leave it..
 
> btw looks there is no plain WARN_ON() used in generic-pt. Just be curious
> about the rationale behind. Is it a new trend to contain all warnings under
> a debug option?

It is sort of like VM_WARN_ON(), the places that got put are largely
performance path so you don't want it enabled unless doing debugging.

Generally the idea is to use PT_WARN_ON() on performance path cases
only, and leave normal stuff to normal WARN_ON.

> > +/* These all work on the VA type */
> > +#define log2_to_int(a_lg2) log2_to_int_t(pt_vaddr_t, a_lg2)
> > +#define log2_to_max_int(a_lg2) log2_to_max_int_t(pt_vaddr_t, a_lg2)
> > +#define log2_div(a, b_lg2) log2_div_t(pt_vaddr_t, a, b_lg2)
> > +#define log2_div_eq(a, b, c_lg2) log2_div_eq_t(pt_vaddr_t, a, b, c_lg2)
> > +#define log2_mod(a, b_lg2) log2_mod_t(pt_vaddr_t, a, b_lg2)
> > +#define log2_mod_eq_max(a, b_lg2) log2_mod_eq_max_t(pt_vaddr_t, a,
> > b_lg2)
> > +#define log2_set_mod(a, val, b_lg2) log2_set_mod_t(pt_vaddr_t, a, val,
> > b_lg2)
> > +#define log2_set_mod_max(a, b_lg2) log2_set_mod_max_t(pt_vaddr_t, a,
> > b_lg2)
> > +#define log2_mul(a, b_lg2) log2_mul_t(pt_vaddr_t, a, b_lg2)
> > +#define log2_ffs(a) log2_ffs_t(pt_vaddr_t, a)
> > +#define log2_fls(a) log2_fls_t(pt_vaddr_t, a)
> > +#define log2_ffz(a) log2_ffz_t(pt_vaddr_t, a)
> 
> above three are not related to log2

Hrm, maybe not, but I also don't have a better name.. It needs the
type multiplexer. Let me think on it.

> > +
> > +/* If not supplied by the format then contiguous pages are not supported */
> > +#ifndef pt_entry_num_contig_lg2
> > +static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state
> > *pts)
> > +{
> > +	return ilog2(1);
> > +}
> > +
> > +static inline unsigned short pt_contig_count_lg2(const struct pt_state *pts)
> > +{
> > +	return ilog2(1);
> > +}
> 
> what is the difference between above two helpers?

Oh, pt_contig_count_lg2 didn't get kdocs because they are internal
helpers to build other functions..

Like this:

/*
 * If not supplied by the format then contiguous pages are not supported.
 *
 * If contiguous pages are supported then the format must also provide
 * pt_contig_count_lg2() if it supports a single contiguous size per level,
 * or pt_possible_sizes() if it supports multiple sizes per level.
 */
#ifndef pt_entry_num_contig_lg2
static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state *pts)
{
	return ilog2(1);
}

/*
 * Return the number of contiguous OA items forming an entry at this table level
 */
static inline unsigned short pt_contig_count_lg2(const struct pt_state *pts)
{
	return ilog2(1);
}
#endif

> It's currently not implemented by any driver so will have the default version
> returning 0. and it is only used by default pt_possible_sizes(), which then
> returns only one page size accordingly.

ARM and RISCV use it. AMD is the only format that support more than
one size of contiguous per level.

> > +#ifndef pt_pgsz_lg2_to_level
> > +static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common,
> > +						unsigned int pgsize_lg2)
> > +{
> > +	return (pgsize_lg2 - PT_GRANULE_LG2SZ) /
> > +	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE));
> > +	return 0;
> > +}
> > +#endif
>
> remove the 2nd 'return'

Yep

> > +/* If not supplied by the format then dirty tracking is not supported */
> > +#ifndef pt_entry_write_is_dirty
> > +static inline bool pt_entry_write_is_dirty(const struct pt_state *pts)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline void pt_entry_set_write_clean(struct pt_state *pts)
> > +{
> > +}
> > +
> > +static inline bool pt_dirty_supported(struct pt_common *common)
> > +{
> > +	return true;
> 
> should return false here.

Huh.. Seems like yes. This is only used by the kunit, but I have to
figure out why the kunit doesn't fail..
 
> > + * Format supplies either:
> > + *   pt_entry_oa - OA is at the start of a contiguous entry
> > + * or
> > + *   pt_item_oa  - OA is correct for every item in a contiguous entry
> 
> what is the meaning of 'correct'?

I will use 'adjusted' instead.

> I have a problem understanding _pt_entry_oa_fast() here.
> 
> Obviously pt_entry_oa/pt_item_oa generates different oa for
> a given pts, based on the aligned size. why is it ok to alias
> a common macro to either of them? looks the assumption
> is that the caller doesn't care about the offset within the
> entry range e.g. will do its own masking. 

Yes, this is correct. 

> Probably some comment is welcomed to clarify it.

 * The internal helper _pt_entry_oa_fast() allows generating
 * an efficient pt_entry_oa_exact(), it doesn't care which
 * option is selected.

> > +#ifndef pt_has_system_page
> > +static inline bool pt_has_system_page(const struct pt_common *common)
> > +{
> > +	return PT_GRANULE_LG2SZ == PAGE_SHIFT;
> > +}
> > +#endif
> 
> will there be a implementation supporting system page size while breaking
> above check? if not it could be moved to pt_common.h

Yes, DART does in my draft and I expect to rework ARMv8 to have
variable page sizes.

> > +
> > +/**
> > + * pt_item_fully_covered() - Check if the item or entry is entirely contained
> > + *                           within pts->range
> 
> when using pts it's more accurate to call it pt_entry_fully_covered()

Not so much related to PTS, as pts could be either, but it makes more
sense to refer to table poitner as an entry than does it to refer to a
contiguous entry an item.

> > +	PT_FEAT_FLUSH_RANGE,
> > +	/**
> > +	 * @PT_FEAT_FLUSH_RANGE_NO_GAPS: Like PT_FEAT_FLUSH_RANGE
> > except that
> > +	 * the optimization objective is to only flush IOVA that has been
> > +	 * changed. This mode is suitable for cases like hypervisor shadowing
> > +	 * where flushing unchanged ranges may cause the hypervisor to
> > reparse
> > +	 * significant amount of page table.
> > +	 */
> > +	PT_FEAT_FLUSH_RANGE_NO_GAPS,
> 
> FLUSH_RANGE and FLUSH_RANGE_NO_GAPS are mutually exclusive but
> one format must select one? then we could just keep one flag (NO_GAP)
> then feature off means FLUSH_RANGE.

I think at least one or two more flushing modes will be needed, and
they would be mutually exclusive. It is setup with this one hot
encoding because of how the pt_feature function compile optimization
works.

Thanks,
Jason

