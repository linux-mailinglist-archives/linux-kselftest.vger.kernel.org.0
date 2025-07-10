Return-Path: <linux-kselftest+bounces-37028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AEB009A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93216565202
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460792F0C4E;
	Thu, 10 Jul 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGzv22ko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEB42A9D;
	Thu, 10 Jul 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167543; cv=fail; b=T+ZGsR5s0RW4KZs761yREISLWjEaExVq+icZdo0Mt9BPu9mtOhU6EDMYZiqoiu4GWMlLqgtYcLo9+l90vsU2uXDbbsgYtrg3NmR0S9FMMIyuN3mw3hq1EuAK230kR36VEvziylL+5p68nRfp5q6AUX/JyxxsfmtavEYcW7ImBJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167543; c=relaxed/simple;
	bh=1SaYCsmGE/V9seXF9yyEAHWs8D4sVOHPuCo6Q1CrLvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bkJz7HAJismk03+ml/+jcX3mF00VA4mTsxPDm/0ckfg77KY4gCLtZy5Lyi4//Yz9ckk6yf9p8Iv4r3/yJJKKArhNf+QC0d4bhkrTRRN4ZiRa53GGdA8KV42Snn9XTr47qw9jdKarN3u7s+CI/Io8oyA2EwJOzs18fpSIaG6BwlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGzv22ko; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqMAaGZS6JSFNaF+YFPrf3e2jPNE57RnUVlcIwrARbjyvrjUWe3cUXrzr9yFtmr6XILw4Ef9PAy/waPzSm6sYVWSQPWjTYSlPBTx8FMxUWAaT9E7lGuO94QdbqviW+MdKxM1neb3F9tWKL3HPtjDfv4QkK78yrYJgoHVZt6B3Sul8a3KlXf5KjMPYx1a5Tx6Z4gZ8BCaqFE2vKlF4JpvbNCwAXV74wfV/R6CdXfZkaq6IEjxZDpKkHDf1aYefIGrgNaS+RbYYz20R+OPBcvStYLZxyaWetFazMr8zbiT4vgN+n9ShuPhrC5/qHORuhb8eOuYVMTqMMDScPDZm+FWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWVRkHrf5zU7DoxtYe1u38EE3dbybhaF26iF6PRnXUg=;
 b=kGTrHgG5+Lp7lofY0ya9nrvJ0ZlXApCjYypSqoWiaGZeil5SMmB/D3bOTv3jUsXYD0O8ticB28ZQkMI+qQGbUJRoeGsi+U9Nz/h3GlO3m1Bc6gCNgWXy/fgeGjAfm+vtgFu8Kj/rKwtWSSJ9sXqGyPdFQvehESvatwSTL9lDJZ4gbKw06i9p9aao/O5QndlpQMkP5JeyKyGBlrDHClNl10C4FARpe/yjQY4J0pK2UYeiPeMHU4doebdVxZD2xq9EGi8HBTxVwlBSWB9+Me4uJBqEhATxYjHdrjvRAjFrEaLO1SB2cfmHzm0Da6D/Nrd24pDMpo58KkBo1+V/VeeYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWVRkHrf5zU7DoxtYe1u38EE3dbybhaF26iF6PRnXUg=;
 b=JGzv22kou/tWuyrkvOdoZUqiQBZfdOj6C0QKPz2K2Qf8jKzQDmTTc7UuE1GzowFLiLpRdvRhefUTF2R+2UuuziFhggOHUB66boyxRheprx2eUpi5T+lUOYfX6dhZt94js296pVg+njy4Aymc2G8oYS9S/Awgj5R9n3iJkNJcFwacVSU/+yv4CqwXcambZj7NtmMNmnjKV5Eg9nlkqVelCfvxfA8d85XXL7LshrsxjpCV364HRJtMuzx+CawT4B4mnNwnOneSvRIvxcdxzPus19ki7YHefaRRzuVnQdm+jtOdtsIOylvdfVnsibNfIcCL9aotXT1ySFGTKQDYrzGZyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 17:12:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 17:12:18 +0000
Date: Thu, 10 Jul 2025 14:12:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, bagasdotme@gmail.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <20250710171216.GR1599700@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
 <20250710153202.GO1599700@nvidia.com>
 <aG_togvop53dLSZM@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG_togvop53dLSZM@google.com>
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f031938-cbd8-46fe-d5c5-08ddbfd4ecec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utvDYeSAiagQTZr/1QKn+0AM2od/M4zSMO12ib6AQiW+QYRSEy1X9mtzpxfg?=
 =?us-ascii?Q?pRJBYKajAzwVUN1QJQ/rIGCNAx+hOuZ88p1N2cYGMebFMg2ksFWNtZqUccyU?=
 =?us-ascii?Q?d7JvjMAPYg7zY1+BaljOPx3TfAoV8MFa5cqL/QgFVtfvbqjgOwEICrXgSANs?=
 =?us-ascii?Q?ZEUjmqOkNtLCOrPklZOiaJr0voHZQjMUK94lsYLJ5kY6DRT6rkUlrh1tH4s/?=
 =?us-ascii?Q?0YmIIieo0EWOo++BiKnfOHiLhAFwMT/Z383XUq2kPC5Ph3E8LYh8+5j2TYAO?=
 =?us-ascii?Q?6szbW787y4m5OkvUb7j5xgj+jnzYLQPHORA9lptz2e4rqttb/zx/Av/qXRsT?=
 =?us-ascii?Q?5IPbr6dxzcV5qf3UFub9uDLLpOKaHKhoGbS1YEb3usdGVyER75PXrNF/Ntmi?=
 =?us-ascii?Q?hv1zdAnxWFycFaOEKbiMr/BNRzIccOSixFNzq7g+NPZQxuTyg9ZKJ2Ra4DKv?=
 =?us-ascii?Q?F0AmfVpvEyK0UqKav5sQRG5Fud1a8WDNbZ+RHM8ttpx47Xx/ODvRxA3G2seE?=
 =?us-ascii?Q?N1jbvwSPZWDQqY3IkN1nZBZ8suL2CvajKlDbndPSmsWJAKE81smZKCgTqilc?=
 =?us-ascii?Q?8hyhBFELYfRg25Zcr3mwpsi4Ky8gb5bxt4CJY+EQeQ9x3u5tixZRcD7nM1sr?=
 =?us-ascii?Q?Rq8241K6dRx4B7icoFsQdFxvDkquRgrkyDOLw6pcXJfs7VNKm9iU0ZDrrNPM?=
 =?us-ascii?Q?ajzr0G5BP4DPkrbrJOtGao+6m7+3xPsBMHL7Q90RxIiPjqYmbr1xeoicyoEd?=
 =?us-ascii?Q?wsSmIPd4BPdHXVySWQT5PoSAggpwVHaDtAgI/serfPK/AqplB1+SZkMQaP7H?=
 =?us-ascii?Q?JtypZK0KbQd5LiciaykEX+T6q2qWrNjAbWoAb9A/bc447Wm9pa/25GU82hc8?=
 =?us-ascii?Q?efwDUY3dDcXi0/bsKW66if0id/3zdbb7URBdIsAMUyjFEOCKgz1K6qR1yJfy?=
 =?us-ascii?Q?roDKhW4zWIZC+MywY82R+gTAMar1T+Ar+dhcU5cdEqm3geqFMmJxctkFWGwu?=
 =?us-ascii?Q?WVjbz0iVLKvxSG7IMetGMG/KgCCsUpsEGD1ozbQI+cEJJqOCfDNFL05S6GBe?=
 =?us-ascii?Q?ojT1b74un3xwCsNAgunf28QLJP5HqfdqW7WVEfgsgnrNXzmi0TiD6L4N+1vH?=
 =?us-ascii?Q?RaJRc8Nicn/3Kod3rKiuKjJdmPjSNcefiz4UsdAjikS3USeQUx9PM3vrFBoS?=
 =?us-ascii?Q?8L+kuYHv8fddRsKJ2l0PgoHQ+/6PcREYwHR7SV960lxAVVspEOIPTFkGbeH2?=
 =?us-ascii?Q?C+ekUHYcs/KTK4/MpXzkz55WNnnCt+GCzRtcbvx5ALFahm8xjb76i2YnjnAe?=
 =?us-ascii?Q?XPa7Xn8OfCV+JYzANgER4fyaWjGe4Nh4ItsMSpNe7vFXokaUJyqdXVXApoCe?=
 =?us-ascii?Q?P68Wo+g4Wh0wNz9TnoBzvbMIf8MLII2KUn9rzi+rZuQCiSkg0wHEcImPTYuP?=
 =?us-ascii?Q?hfmBHlJsLgE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4LYNcOjz/a0BpTwbnG+D9qHqMbprHaVpLMirS3zwkFQZgwJRDRokZI+keG0?=
 =?us-ascii?Q?u2OO2gSSG9FLRNK0OC9F5CtwNlbWaFRnuV/EL1Mek+Lhrzu8vrwIa7I5Tf9i?=
 =?us-ascii?Q?QWxKnySN2OlrX1XgP5e5+VDk3jX09dxEHNXUTSOKmhNijye6o3AzOgHOjXIg?=
 =?us-ascii?Q?zc7I18LpftYdJJbarLigAeuSVguCFpJTnjvWQTxOXXWSGYGH1/VSRd4qFTo9?=
 =?us-ascii?Q?DC919JtEc8+G+HgCPFgW8KCbma4G7cGQPH9ZStF1u78A6w52IORfDVGX85dR?=
 =?us-ascii?Q?ReKO7ZlIFGHfKleNMoa5q3OF/7J1jtSLumCmxIQLiFqMU/jMyq6wTGfkyKdL?=
 =?us-ascii?Q?NPg4a0FVp4JKW6dMiiVa6wKDpnDr6SZsBfSLz7Rr0N4uDPSKmQa720Xw+OGk?=
 =?us-ascii?Q?lO85lbrJgQnkIkRe9ZgXKRna/voSEMPYFn3Smac6eoyUBYDV1q0Ma9suNOxg?=
 =?us-ascii?Q?Bn4k3FA3/lUlw5umGZFRGRZKKVkiH/AvU70qViah8WGVCA+SIgA+VG5MOskt?=
 =?us-ascii?Q?wLDPitKW08kS/5rKwS9wwIOcjRQ5t8KntyQ7EM5cBcS7gzbq45vAhPqRelwJ?=
 =?us-ascii?Q?CeV1RJBMORGytUTP65FCVJJMLARZ4BA1HctLMp6Xzts45OBzDR3mue95JIJS?=
 =?us-ascii?Q?6i/pba2NZtpy8YEVp9B0GELb5p/qs8nTf3oazW6ioz9EWKydKXBG1c30JFpG?=
 =?us-ascii?Q?HjIS+uyyeGWbBbaACnBdg9RtzPyIN30YN716UkYzTp1c9MpyHGYvtbo1puN8?=
 =?us-ascii?Q?4RtC6gCAz+EAvdVQ3XaCt+USpURpJRDIErxnL9++KDBy6AC3xwPsQ0bJEX4Q?=
 =?us-ascii?Q?trDcgL2q7oJ72nXOPme9wrdUHf93t0NDDHQkDF/3hOhAfiFnOLdP2O2JrXKf?=
 =?us-ascii?Q?Sd3wKtjHFFgXz7V8Sugl4e6RICI7DUrMziXEYjVJd9FFRmRQ22i7eg5C+SPw?=
 =?us-ascii?Q?zbL+TH+VawAU9ARW5wstEBQF7A9AM4oKb28VLjh2CZdfYfuJxK0hPEs/fECk?=
 =?us-ascii?Q?SdHFnch842UVeQqEu/T5oiHnRB6xcUEaoNdJoz5Nc89dL8OAt2TGCKMqVI5j?=
 =?us-ascii?Q?wSyPTHR+NiuwVnad/2ldfDtUuAG4Shlsxq3C/NcxCVV7IRPCKP0AyMFAxs5A?=
 =?us-ascii?Q?MmKBedtE3eeZr5LaDmKZIb+tV7XVtnG0yYestZ9glPsVcNpXZCs6gxMFYTgC?=
 =?us-ascii?Q?TqFZJFv6R6b6tFQ/D0Jcp8JX5rSuE3xJ98pIeX/m/nS9UiGmNplA+uzqs1oh?=
 =?us-ascii?Q?YthZG0i/hhW9/awx/duT10O//9vVwETlR2JRLkt2AAB2l9d+En0fs70Ld7MC?=
 =?us-ascii?Q?JVGqWH1VYOU60MHmYr0Pk7K8PQWck2fO0t66lgjxVq/A33zfWOKU6GMzfFyC?=
 =?us-ascii?Q?8BC2FQl3xVFnepGaLfxTTnXfQJMBMhYdlxOT5XFwyKGZDtvSHYvrEoV/amSq?=
 =?us-ascii?Q?LnvFnsJsBbXRn1Z/nuElkA+X8D7OJ7i7S5FDCTv4NO/yNYHubi3+94cLqZrD?=
 =?us-ascii?Q?IqYMRRQyBotM5L9enb0XNHPbgL016pxvOEpwk7TmgiBFvtkm9FEzq9y4G+DA?=
 =?us-ascii?Q?UR8eWbRMtvmf1zbCrhZRr8RGjeB6BNSvf8ZXaR9L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f031938-cbd8-46fe-d5c5-08ddbfd4ecec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:12:18.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRfyz9ScGuIgD2EN8cF11ns/U2LA6lbLpf3pSAmNwnxm4iwUmu9QC7uZmujlbpcy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259

On Thu, Jul 10, 2025 at 04:43:14PM +0000, Pranjal Shrivastava wrote:
> On Thu, Jul 10, 2025 at 12:32:02PM -0300, Jason Gunthorpe wrote:
> Alright, this was on the `for-next` branch when the head was at:
> 3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
> iommufd: Apply the new iommufd_object_alloc_ucmd helper
> 
> But I see that on `for-rc` [1] the fixes are merged.

Yes, Linus discourages back merging rc without a going forward
justification, like following patches need the rc patches. Fixes some
bug is not a justification...

Jason

