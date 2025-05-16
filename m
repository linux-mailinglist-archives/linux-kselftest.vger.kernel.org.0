Return-Path: <linux-kselftest+bounces-33178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C553AB9D27
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1927B4A09FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51BD29405;
	Fri, 16 May 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QdpZBFVr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CDEEB3;
	Fri, 16 May 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401782; cv=fail; b=WopFwy0u2UDxUBcLh0BOW5QGdoiTOdOWaA2y6MrYqmlKS/oKL2eK+RLmFcAPRsT0WZ8ZjbBcIWJkQqNmP+myX0hunzR9bPyGBR4QpF1e/8TyK3GR9s8OMLsvaEBZz6NBc6S4m3vYhOq3ktind1k0r13jznogqYs0I4/Su1k8zbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401782; c=relaxed/simple;
	bh=52fUmNTKHoSLjJyPQq8rXdiWROwckKwnMougxnIk1GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0iRI0eldMQpZky9mR3OZKljIBL4W/uOwuSDIz1AJFV69e6w6TFZAllDJrsKfnZ7g/4xQj/9Vmj4vh3WZ0WIRlWUdCjEnxE8egqMwSrtDmQfFQAbu97CNXnoDlXhDeUwvoR8K/J+exJQA9eil514qkmhD5c62q2+qw00qLvk/rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdpZBFVr; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2R91Lo/QL7xoeSCRUUDl39qMVYjXjUPJIOhX7v8Upxg/IkvfXzCAzEJGvtUMDEcsfFCGJ9bMZQR8LofUcYDOoDlyss7NwjnIgTqXqwMPF07O7t0rbvvrCAhXhgZr/k6rFKr7RjsxlHSwMoJ0/itQxjfi5g7sdZ++pMIdo5+xspYwaPwqI+5lGJL+QDhdpB4rDRrYlAW+2XzZUErIV6qfhmLUwPqjzWN5ZY0pWI0Dx0/oV5QTRLCM7ZUJygcyJew3QBQb/m+gamIjjDQb5rGFvsLE6ULR/gKrUHm2WNfz4aHyhKp8Ug+H6r2oh/w2q3sg14lS5K7IY0iLGg5d/CRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJACVVJcbugysLVLrxkPBG/vSdXHDbaVnX4NaRhZ/uo=;
 b=wGDKSJyF5MuKBw8VGy8T9JJuZ8rJJZ7oLbuk/vXNR1bYf9LYQFA/Wwp5yh8mdHhHOH1JX6ECcxMWPYjLW143RT26PAj4YCGmi7ZZVNYN2MDejajIcdMyHmnJAm2/zLrGmJfMaQ0f8X819STmRirTaLHZ0OtuSYm1G1J4Y+jCdNCMq1SQkTFbtFh+hyapxcvNOyljqhYkM7Hd4lM2UiJZ0AN61gf2ifsc7rScRDaW0wyvXy2HTv7ehV+Xowa8O012Ev1ng/kTn6hG7oX8FcKu50j7dLr8Brw1b9nqLIiKrtdLAIq1Z8WeN4BOD1jaJ5VyYraM9+3o3EBeaNOrZJdumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJACVVJcbugysLVLrxkPBG/vSdXHDbaVnX4NaRhZ/uo=;
 b=QdpZBFVrYcnewSbwiDdoYe+/6dJb4AR0kLEHHic+TxuKgUaRcUfsyV0SBod0cBhQY9/jBpjqAlO1hpT+FMYlt7sQCGRoWZIozZWdYwekIMAnYtxAaiobukaVoD198zRWNwFYPQBSc1J/5Hj4wAG2v9HcatkQKmmJkDQbGQjIxIZdRQourj/9KbMNZgKrArj98Mb+JE92KjU5cMo+av9gX1/JUBWbyAwDz7S3Ut74eeBZmk6oRApZoxkoa+VqiHNE08fr3LAxErY0L/UVf+ux9IpAQ8Zf5g0vWdJfQJE4YI+p8zvTLla1ZZ6EkjhspPyzTCpUk/jrSJjlL1FBRLOS2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 13:22:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:22:58 +0000
Date: Fri, 16 May 2025 10:22:57 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <20250516132257.GE613512@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
 <aCY31VOs62/OAaca@Asurada-Nvidia>
 <20250515185629.GS382960@nvidia.com>
 <aCY+rXsygxjHYRhK@Asurada-Nvidia>
 <20250515192329.GA613512@nvidia.com>
 <aCZL6+vsOri+WqXa@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCZL6+vsOri+WqXa@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0590.namprd03.prod.outlook.com
 (2603:10b6:408:10d::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acefb77-1ca6-4103-76c6-08dd947cc62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5YMHssqmZTjqQnC098mESPuH2L9v16BdFoXKZDAPYF9IQU6FQ2XXN0ycTFn?=
 =?us-ascii?Q?/EbLXEnIt2CtgFJ3fMhy+9uSBr/O8Un3vRtlZGErV6NaafszkE6PW30Kj1aX?=
 =?us-ascii?Q?qDH9YpkGlMgvy/KEEyr1aMPRuTwRua8Gbf8c5VMUisYzzv/TVC3sbJcR+A3u?=
 =?us-ascii?Q?6een99NYo0TkGJ9kbn4rlXqUcNHVpPV+zYG+BIHgvSX7i+pw0tJD5ZOvZdqS?=
 =?us-ascii?Q?LtsTa5cGtPEeGbPDuAIeyacc7L6W5k9vpxVY25qvf7O5x+NKUvRe5zYBxOHc?=
 =?us-ascii?Q?hPl5+kW4mACB30n97ZpuPFo0Kn/LR1pI3xZ0MH44D3UExRh6zDmzcQHwPFf2?=
 =?us-ascii?Q?aDTWoK9fFiH9AWINFY4j4XtmYKFDE8fQlRH5NDq1x0n/BIsShT723adlKSkk?=
 =?us-ascii?Q?MjETJHenPGqa1gDlFVDNEFuHvM6MNPp445v+58rch8Ww7gGFVDjRRxttprJH?=
 =?us-ascii?Q?fNvx5mNdwKdRgl1c0/beMrN+hKoiLKSytEkmikvYAzY3GmaFZBS7+K2fAhUV?=
 =?us-ascii?Q?ZIogxqfXbdxdNEtJvzD/ATGN65DlOu0X5nDoUgeis0LoEXswMQ6DmYCU8peZ?=
 =?us-ascii?Q?s0tPR9SwHiFmi9N8T3I7FmPN+xU/3sWUS78L+K3To4TMZS4IpkwxglgYbNVl?=
 =?us-ascii?Q?dUz/vtMTlBqCIEERPiQ0WWf65Fj6YItJ6xwVgOngHb+o2KwPn5xPJUzCorPB?=
 =?us-ascii?Q?fNu7Ckz2OFAANMGwbrtde6p2s5KlFDDulKHDIxIm71fdsGUIbHcgfwMm+PWv?=
 =?us-ascii?Q?RLiTgLlR3rlk9pUf1jZSDNPxDS+v9Jp2LwQd6+UPFhRKgg2dwjv5ZDAPIDss?=
 =?us-ascii?Q?FgQixKvxRvGx9IDGYEzS0uJY3xHAZfCLZ5JxfI9Nkh6a8tZkDbldqgurJrCC?=
 =?us-ascii?Q?U4se4GLhZF/w3O8HzWnelnsSBis/u7D3csw1sJ8OCdyqY37XoJk7smVv+riM?=
 =?us-ascii?Q?NkmrTwNrPbbQ94TjtWJY1YYd4/dNsiqAkKqAlFQOS0cMN4MAr2DKuu80eEj5?=
 =?us-ascii?Q?+I32L4PcwH5Jtq/3wZipyy0bJMEsZeEZr3SWrgMrznfMsiQ7TeWUwmWYEYJI?=
 =?us-ascii?Q?RM7y0ltDQZdur0j9iHveOnwS10fCFYgPR5eCWYMff4vXBJI14a3nTuaSM2XF?=
 =?us-ascii?Q?ZpRRVyb3FsINhdt5FIvnaJHYTYQzGnVrxewMPgJnAHFpt4VPgaeLkTwEXEAX?=
 =?us-ascii?Q?txfY/yyby5KPsR71p5xN0zUskY2i6rG1fgYZN3F6Xiikcqlhk9c2cLKFoEoM?=
 =?us-ascii?Q?ZMO0Gy5ZrqIkNdjhBxcuI3h4Lc08d2d8psCwkTbUgV43mLqH6cFymyvrL5Id?=
 =?us-ascii?Q?Av3BQDrZROyW5d8Wm6nzaIflVtDruT1wjtVnnIPCyGIWyn3ky0hD+Z83sfPM?=
 =?us-ascii?Q?WYO5lCeNAx/ddwhYfwil6+Es2xtBLyNLZA+HJKQOHnOpWqr1p4NfLqInMdM2?=
 =?us-ascii?Q?OvlrpNlvvpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mtdPYdjHtnpcL30V+IJtsOol8/n54xATc97AYg+BaFNJ77hEBDDt7P9m9kf5?=
 =?us-ascii?Q?1psvx4nmiysy5UtS5tK4MEj4YdHhWnqCV4e5kLflmug9CTnAHJ9TGaBAtmOp?=
 =?us-ascii?Q?7a5f0N6sdjj2tc1pxHAMprv5H02uOs3tqUjZJ/EESx9mcvkhkl0MiYz4cYs9?=
 =?us-ascii?Q?vj09Ir7wdGqNvll7qMVuMF6uYQvPobmSC+JQi2gSow3wA5UgVGscxQIB7JKL?=
 =?us-ascii?Q?A7Rq6QJjIUZCd755puEmz/v4HkjUAxXLRhd4wY2GPoKxbnoZg9c27hqYQHDW?=
 =?us-ascii?Q?jXUWAZD1+9FuQLDrGJa6lX9ugA2DKApm3WdI7f76RVLBIMSpzKKPN5yeB4yr?=
 =?us-ascii?Q?fzaFiC2PCAFRF2rLbMZxyJci5vZzLBKbivYobZPiojf45DRK7dXceDPDVyqp?=
 =?us-ascii?Q?7AsmeYtVujfY26n26662N2vxofqIfl0Lv/No4Whf38mBf96tVlRWMnrb6QAg?=
 =?us-ascii?Q?ujuztJ2e5/DgwbuZ/E5NPY9y3BaCceVdfQwkH0oLpIGsjPty7YJYb9Td0clE?=
 =?us-ascii?Q?SNbcFwuh+g5tt6KRtj0bbZjoSnwqp1VEWwwFVA5UTxp8+TtqdrMk98YqxDab?=
 =?us-ascii?Q?pG5FTpOY3Ws1Yjdzc68psLiAHXA0zOoRwxIyLMUnVG2oJ+zETzSodNxdMtPI?=
 =?us-ascii?Q?uglQJrj/1K1ffaqSUjBehbfe5hRNfLNFNfDvc49hvnd8aPtxi6SS1IquSKK0?=
 =?us-ascii?Q?btEIRgeuMH1Pvf5T7LBYzxZpd0kNg3AG672Mni4JxZ3+t8w4eDBsFUDaYLCX?=
 =?us-ascii?Q?5dMruOXQClCUl5Y/XbwLZ7iuOLaG2WySWNC1mQACYRQ3Sv4pLb1gX9gArHCs?=
 =?us-ascii?Q?wvnxHipzf/MNwMhGNTtlUZpy4Z7OntjqmcxbljuhZQxZnpcUMKEZ2usMD0sn?=
 =?us-ascii?Q?AXJUF2dnZ6jysdSPTIY+z/HFnCTIGumgVR9W8Qig9b4mhDA8Tc+djla8KEfD?=
 =?us-ascii?Q?7sV+1g++i2xXqZ6Hv9M6zw4+RyZEt6E/gWL+aNx04FTOfhjVzXF/jJROIod4?=
 =?us-ascii?Q?9x6sIarGoWQtTXN3hKQnhzQazfyMrsAb8IhdV1vOFqwZRo/jg9MHRJN825oa?=
 =?us-ascii?Q?UtC9fJ26Yno/38ofjmFz0koqXwqIosyCsHHlbM53Xg3t3cfPxGDkqpyA8NiV?=
 =?us-ascii?Q?isNTLjQjFLrC49jXFmOW+uOiDVJk5P2ZYg2sXxXK7y7DN8b4VaE0cqfOgP7U?=
 =?us-ascii?Q?E/IIhFRPs8+K04VqocDbA+NXuzsr57iV1AjqoldoLrrnjtCjzY/5eha9PC2W?=
 =?us-ascii?Q?mB4fhOaDA1HF5Yio9Tit61sS0YS4w2FXUBfvFptsnJ92utj/fWmVkryayYek?=
 =?us-ascii?Q?WSNOZplxOpBgYkYdwQWYhNNrVU8ZAzjDNtBpEAPm62gE9fijKXolKlG1v4pt?=
 =?us-ascii?Q?yC3gqrY3gyYK6RxvvZUkytEAgGLG8VmfoLXKZ9MUBXFbE1x9gQmJyyluETLm?=
 =?us-ascii?Q?+3qVkfGbYjo7o36gHcSBsheG6ImLwXX7gxq9ixwCNebJVduA7saaQKMMhFfj?=
 =?us-ascii?Q?LGZpM6fPQct7B7Nco0qBk+tomn7NXk3RZ5l9CfnrcyI2U0CzsG+ub0PLRwHQ?=
 =?us-ascii?Q?fUN3xatf6RHWOYoSvVTJSPSmbEJ1fZCUUCXWfgkp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acefb77-1ca6-4103-76c6-08dd947cc62f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:22:58.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N6OUrBa233CIEyYLv3phi2ErrFBKj2NrFv1em+h4jfVimNBjdGZGzmy5Tgzd6Oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278

On Thu, May 15, 2025 at 01:17:47PM -0700, Nicolin Chen wrote:
> > I think the former is simpler to code, you can just add the req_type
> > to the signatures and if the driver comes back with a type != req_type
> > the core code will return EOPNOTSUPP
> 
> OK.
> 
> Maybe just turn the out_data_type to be bidirectional?

You can do that, bu you need to add a flag to turn it on.  We didn't
validate that it was 0 on input before so we can't start now.

Jason

