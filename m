Return-Path: <linux-kselftest+bounces-41507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A67B58120
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA57172282
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7E1A0B15;
	Mon, 15 Sep 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="moz8uK0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9F78F36;
	Mon, 15 Sep 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950946; cv=fail; b=i5qKYRbpWGQVKsqJ4w+aqitoOS0r/FEpDisqs6WD0NaQ9y2RaUU2JK6Sj/dls5g09P5vUznOAz1oz6gy1pTeygXjaKKqkofNNVuqk/4CAT1vtCYS3gVXmFtiukd5XNz4Qjq5qko0iNmmcHalSJNtDDUd6dtk8TRjZm1//oNUNKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950946; c=relaxed/simple;
	bh=sT1Y0NSbCuzYUIt/QxVEhUlPq5OY8uggc8P8TQu966I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JECTMmlphq78oebvD5HkE8/R9v2PWMEp70zG0bzsebllTa26K05912Ga7keQmm6woqWTTYKeThFjuEEtAy4YBV7Ot0xxjzQr4xkiIYUNAtBGVFXumWhOF95mmlEfK9p/sueLVlA4WWgBosfmXiM+hpXl105xG2sa2SLkQQAb7Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=moz8uK0O; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtUr9Oj64jOYQyKLGDhBmyfc4XU1f23msj+kqZQe92gmhMC68Ov3YsT3X5lFtbeoZbzjQqxVntC9/C6WxThXeGQGuYzyhzvt4Co8tkPVsZ8++tJoOjXKxcR2s75cpj/zjWCMXRragx7YKLRHjgWFrkCxHBA+T3uVjkrSwcHIxAUvKWCqnH9buxbOimDpBWiHASyvIfF/4V0HKsSuKZNJYlBmJt7ifbhbTrGOIdsbLAKYlmsePzr16EsV3niFrqjKV1WGwmxRBKB1e6v3t4j/6OA45md0IE2rXG7QRzsXzyY1nr6qLAkJY0Wtn0BajdAfu0d4CjuVKNMuuakK5Hn2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc5G7mda+5nGWFfQEeIS7u2zXc69Q7En41fVT5YWs1Q=;
 b=tlK0RMcnl4Shk4atYhMTOSyXNFhCTQ/c0T5KuiM6AxJin7nBABvt8vHhGqJ7kNJOR2FdXBQAjSht2c9SYEif+P1zUVLAcS5UlFB2Y9TCvOqRaAGOM/xib8FhOOSa36aRGl6iu27mbgXbhpDtDbA1/lo7DfZ0q3Y/2jqbbmb7ifMLfX369pjDWYg1TZ0Q/t544XipOOHK5lfLl89WI9JAqvWTfG43wjS8FvRY3rN7sXwUGhOv1LTs3bKVYxJmjWHb1ta+enf4nf7dzMsGURjxLodEp4OPEl7fWTlJOa8Lyz4nV6miCJJ8LyUw1d8BA9J0hThYNzaoeUJJU/y6+QJ7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc5G7mda+5nGWFfQEeIS7u2zXc69Q7En41fVT5YWs1Q=;
 b=moz8uK0OJ+nfvjH37DVVhvG7YxDBwOAXcCz+63nCyECDSg37TvBDBnMftmdbiQ73LJr+eqXGUnXqXADOaJKThaGjxIXBvuknw0MNG6fSewcPzrZ3h1exHppjoVIi1XuEUpU3Bt5maTu9dlwIkyM8V0DzNE50IaiJKGfM22LXGxDYsBu2QAYySLHGHXkS5EmMf3PgFEknrtBjMznE4N6f1K402ztMR2vzN8B9pmlYdz3Io2rBXZA+17V2JLFNx6vmXkcTIjdWEf229wPaKOaOKbdEfA6jWm0rlHxo2/JgC6OodXKvEO/ewc2N23Gc467AdHjKd+WSYtLzx2nVxBLd2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 15:42:20 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:42:20 +0000
Date: Mon, 15 Sep 2025 12:42:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v5 02/15] genpt: Add Documentation/ files
Message-ID: <20250915154219.GB1057776@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <aMJO09VXljI3eOAA@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMJO09VXljI3eOAA@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: cb340530-d4f9-4e04-8f4a-08ddf46e751d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ntt/C76gh0KVmxTmKNN7e1AT11WF0PkRbF88x2v5LFBoB5kVx7ug0tg/Bruh?=
 =?us-ascii?Q?TrCJBbL1aG8jOOpOGPXjVHgpTnLLZvi3mPGzllCWCwF7D0e3NTjd82N4hfN8?=
 =?us-ascii?Q?9ewBaUuu4Gan2A12y2djU/iPuxj8+fhRwLrKlXvK7kx41ZSlcLOoLf2n4Fik?=
 =?us-ascii?Q?A7yrk9uJIOYbudbkqMTRwLTGy9TXrqE7cc6ktc3Uwagnabm0VdGlOo8MTJ+H?=
 =?us-ascii?Q?tUA8/GByMabmQbEvQhw2ayUL2c5zs6E1o3kbokpsPB0mjzSRvs6hOf+6nf1D?=
 =?us-ascii?Q?55R9gYkkJ2EP2pPStVBnc2S1TypknM6TS31WBuv6WHCLepHCiJD+XHUJDq/K?=
 =?us-ascii?Q?zzfkzMuIljtn1boQ+qSELf/gvhP8i2IdjX7CpdLXKW61wyWNMpaFfFQi5q7Q?=
 =?us-ascii?Q?CApBpLx1PcrK5SsciFb4N4L9AvZS4MnSytjxIhid1Li3dSRbGNrIw9weLHeB?=
 =?us-ascii?Q?USh+unxB0XFqVzgG6URjELkDR3PeRYWgrPD0y0/KktG/WqZ9pM08dZJLKGxo?=
 =?us-ascii?Q?BdthAwqajgeOaltsAY+zGu0YV9in/vp3EbG//ghZPhvDoJGyfevabVWczNWB?=
 =?us-ascii?Q?cklOLLApCegK3B5YeHxO3N7UHWhsT7QjQc9QOaUfs/PPknDLzl/+xX0CZHk4?=
 =?us-ascii?Q?MGSgmN69B2loQ2l+iAhyR/yEOAaq1MS6EcYOfMsjU27kwAPVOtFJxEORJNrd?=
 =?us-ascii?Q?M2q4yh7P62R33Vhp1704Qj2gDSqu+0jQFlLQxdaZXXOHuTlUmH3RKV2CeG7i?=
 =?us-ascii?Q?hg9qr5AeKs3m2H5o4kqf1lMcTQymXprdZcPXf6GWgVfyTA1lENJ0dlbdd6B2?=
 =?us-ascii?Q?su9fSIoqzbg7SGXsat7Tl4fKjAMdpQNqhd6ndnz+g7U0mw89H7inLrgw8V15?=
 =?us-ascii?Q?DgPOk93XHsScVXxIiF+pLIJ75IFE4uHkdmVfrxDkPyvVhDOrspx82wglLw/V?=
 =?us-ascii?Q?/lycGZoD/3ha9qYk5m6L5vf8IRUNps+d1cDdIJ3CuR/ZY/K8aGp8JTu0ifKY?=
 =?us-ascii?Q?P+MmpMgmNBl2nDD2qb3pdQFSgM+u6iU2pxRRnSnb1oPIY7hrn8AHEW5+7EdN?=
 =?us-ascii?Q?s14FEjWjNkdkImE2QNWQKTzA8tqcAo98F3KIiL8IucKw9NBfKjvM8tt16u7u?=
 =?us-ascii?Q?YFJbisP9ag25MbE9E6IbkcjAydYLhLw1ILKM9qlaB/gYEpwBn+ovqTsc3OIw?=
 =?us-ascii?Q?bU3UvJqacJiLmMxqoyKqJsaTEwY1tPYU/Im3qQMZ++QA3NvdKYek63rx0fUD?=
 =?us-ascii?Q?+w4OfXG+HtGq6bDrxbV6VZzLo+5YJjYQNcHStkiYcJcLPSvRAJz1GZsB+AfH?=
 =?us-ascii?Q?V9krPMrkrPOC22AXZltwHoGzG5RQByFnXjUI/XgdP3al/Pe7HppKYJ4Uvnj4?=
 =?us-ascii?Q?VkpkaAulcm70Ve8nOWd30OdSIKlzvbfN0vuzJkzOWdw/XrhUmKJX722Wwl7Y?=
 =?us-ascii?Q?p5XI2qzpqRA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EcA0lF7CyMYuSZ+HxkUXPu2zzcxyalTf27z3emL3Px45GMWgbtozNB/dTQmF?=
 =?us-ascii?Q?D9EKOY6kd+W7drI5Za5vGM08GrWcShIimjsru4XX86QSXTrGCap0iD5O5PNg?=
 =?us-ascii?Q?evE4iOYm6DukHEnVQ0opeASmwzRQnCTOYvDewwqqHuQ9cpoUyhNYe2T6EI/p?=
 =?us-ascii?Q?ZwB1bc2i6n95tW8bJo4bKyUTk/uuxoD8GqbKiGOxVvwusDA16StBvSbDPre9?=
 =?us-ascii?Q?k7F/7CYDWSYRZYELYZRcNVC1N9V3bsm0M2EZEcWW9esRH9d0UvM05JyqsvED?=
 =?us-ascii?Q?Vt4nKcQ+FJD2QAmfbqtc19eh9L1EWzxKz7+jgR80/Akh88bHONon3njsPs1r?=
 =?us-ascii?Q?3obQBXm3QaekdzkDSunmJWndJAmcLcs0stm97LirBsasrCuZKwXffX87uSSk?=
 =?us-ascii?Q?DIBfzabE0SWUxQCisRYpXHZqhq1DwnGYtJL8gD0IagfcIfL28Ajq0AVmtza6?=
 =?us-ascii?Q?J86Cj4YE371CW1ab+R3y1NdJds9hIR2rTodrKD7nnEyAgK8DZldz3nbBTGZe?=
 =?us-ascii?Q?YkVzLAfEOKdgZT/g++DT7nPkHfdmZsIt0qqkE9HEep+3upjsxDxWQOCY3FdI?=
 =?us-ascii?Q?4Sxjz/Xfk5khuURHITzwdoRRJ6flIppl2QlLERo+W84tc3moslMhT7ZkeymV?=
 =?us-ascii?Q?mb78Gre0qryJBlrka1BIJnM4muJOMgVoVK3hAFIPjWc1jp3r4nJxSjsXhZAl?=
 =?us-ascii?Q?lwQVztS+1JA0EALKvoQfHeE+WhOrMMwuQt0+fQla3clPD9/Kz4LbSkpnAw/c?=
 =?us-ascii?Q?DGraJFHQWUAO7fajuAcXoGrKNdzNv8+AjhoqVGNtXIReDsT+8OezAyyAgvJT?=
 =?us-ascii?Q?UX5Wc47INPmdSW8ILTrvOF0mf6rSaWiiuAfcKpiGu4BlxhB5PvIwnmAwC9gZ?=
 =?us-ascii?Q?iU5MK1oL/ext9rZFk9y0aBXXC00wAGWEelwAE362DQJvIPf2dL2Z5b0USfho?=
 =?us-ascii?Q?Rz+ZEuzyWYCIs2JZruJYV6FJ/9EPFOTVnf0v4LGV9Mt1m5ILKDpo2R0SP3tO?=
 =?us-ascii?Q?HbkzPmd1Xg8jQOcxMnxFbP+TqLsIZh0GOFtY94Hqdh5hZ9DW0KpfqeRRp9V5?=
 =?us-ascii?Q?Qgo7Hy72zGw6wVfdWcfEOx6L2ScKsH/x3ZVdCiqZTGCAqXdAedTqOorCqarc?=
 =?us-ascii?Q?UvYTlh1jEwVn/98NQQGJTEGwY0+JmyrMI9VUHXqLz6ImZ0gKoaCKEyBNkTpV?=
 =?us-ascii?Q?OGCSQT215a+/1bJvx53fUc5E1Zd9BQKIe8J4ME/Gqeb62pNpF1oaNopfEKxE?=
 =?us-ascii?Q?ZRekXeDMha0ZzYqNzJu78gDtHgiMdLorWkXmhHdEv9jv9jmbmS5vcovyJKKr?=
 =?us-ascii?Q?6FBSbmbMAaHiKBOPX0KpUni/r/4ngtQalDUuqw8zT7B/0rMiel0Qej2d7+R8?=
 =?us-ascii?Q?aFWi0saILHmcSnTve5e8GgvOoVbo8jTPEavPqF5Psdswlgvse4hlv3NJqC+k?=
 =?us-ascii?Q?JKXh7lFVdvKxulfoJOSzUmISE4/4UkIvfG2JuLGO0VuGzs3Tj5ljxpcdpK4g?=
 =?us-ascii?Q?Cvv05Sy4CGPvKsexclLh3uCC7pk9R2NrUDFlNiyKj84OKfuhcEn3ynd/LSxW?=
 =?us-ascii?Q?a93aH4ZBkrS77l2MvLNm0evQ7cT53Mavsxgy0eFn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb340530-d4f9-4e04-8f4a-08ddf46e751d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:42:20.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L/by+b3mFFkDw1G5rh7lt3J4qgWm0saxYZG5rMiADSCvuUp173WJAicrtCsy+zA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307

On Wed, Sep 10, 2025 at 09:23:47PM -0700, Nicolin Chen wrote:
> > - * Check that va and last_va fall within the permitted range of VAs. If the
> > + * Check that VA and last_va fall within the permitted range of VAs. If the
> >   * format is using PT_FEAT_SIGN_EXTEND then this also checks the sign extension
> >   * is correct.
>  
> I suppose it should be squashed into the previous patch :)

Fixup all these too thanks

Jason

