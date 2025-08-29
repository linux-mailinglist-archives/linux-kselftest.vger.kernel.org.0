Return-Path: <linux-kselftest+bounces-40332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EFB3C2B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B4BA0048D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948D21CC56;
	Fri, 29 Aug 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpyc+xIy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A39443;
	Fri, 29 Aug 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493499; cv=fail; b=kVQlEK8eciT9jkpJXdRmB7mmLZjv4fQ6q8hAtc1Og7uO+5zOKoJg50M1KyBlpFXei/SweeC9pCbXaavlhzbB3Z8x3q9rxz+HQtmQZV3QPwh1/6urlUVSdRySXEBrjLcODgvy1xyW92SuZB++ZRJZn2vJ67Y1Opnp7Ny1k08+KlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493499; c=relaxed/simple;
	bh=U8DKfN18mxrGXnHBEa1YEGRvDCebwyY3pdghJkziDn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ffnScgCYT+2/VelhBkgJwCmOMrGbEDvP3bMo7IwQgaNSxvJSvMF77f8ak5oaPtgLheoUtY8LD7s5BNYR0i4X017360FDBbS9W48mpFF59kE5NKM9siuO/ZG3uf9kc7Kk7V+vQ92MDMKfubH2m0DuWp7Q+1GxssUYVXcZ/I2+/FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpyc+xIy; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI2AWv6dI7FMAdDxSEYM9eTgIkMNu0z4Y1I/gN4u/mRYsUQQIuL1mbxFesgeQv16MMRL71xmgavFDCDvqVnliH/YUSfnDce5d9+gcLRPt8RryF6Z9TNHliTN+sFm3wHcGipdJ/kZSuxsHC4gR813U1xRsXy5k7vETm9zvpOO14ri276TOls2AyMHEPAM3Ab2/RR26dvMpmYHifXuvrUcNguQoN2+idUtwpBSzlbVZIEV6EDaYDdzbhM4pXbuXbfD5WQ+121WTBOOT9nYhKT9nEjoVnBXdPaQH4eG+J2JVUnRpKBmi4n+jD+J7kIN8Y92w+8vdTMK3zJvtkSHG39/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVUNdoi9XMx1F879uLbmFW7sxPFqblsF9EEY/G9Swoc=;
 b=G16tjVaMpmcqgOEOF80DazKfm8JKb6WrrmyMfvttS1OyIQTRO0M755c4vwN8Ik7cvEzOszDP/KqgcPqIRRWKxRM8byLwf7tWLvO6jxkT59SGIb6l8TNF5HidWCK5n4iln4y9rj8J/zRKoSVenhJJp6hHaWY6Kp/DD6pH/N3DNx9eXEU2NfF09BVWlT0XFrEmUXOLn3RlD9+kJKNvBg5d4xomYbYTKkwJ4mTVeX3OvcIZN6B3PA/Bv1mPKwPvvuD1IparxG0oZvgDmk1v3GyGUeqCghbJj2FTePIazMrLVZXeoJXPtMaEhPHTLch+ix4OBcBnfS2DmtlQMI85H6wtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVUNdoi9XMx1F879uLbmFW7sxPFqblsF9EEY/G9Swoc=;
 b=mpyc+xIyDOd5Zxirqwk7//1iieOVxui6jz/cmtHi/RBUsVteCL/e6etj7VSxx0JnYAJFnw74MwiES7JApenajQBm0B+JazGLadydI5QEFWv4yeethLVRbTEdjaU3jHbaHd7DNcs6sZ6w9H7WNuGZmVy/qVgavI8COJqqIRxcvuIchcQ6VWK3NYwZe1kOFJVkGrtLJKeSTdatHY0qgPPVH6F5mXLjG8FK52uXCx9vfqbpiZ99hihM/aUP3iD7jJRm0/fo+AzD9481yLVc81aHSFH/XaTaOMXs9y8c5OXKnkAqrfWPbxifBAHmkzOUsJy/uQXkRXIe9W9Vu/AL0gdXRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 18:51:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 18:51:27 +0000
Date: Fri, 29 Aug 2025 15:51:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
Subject: Re: [PATCH v4 01/15] genpt: Generic Page Table base API
Message-ID: <20250829185124.GE79520@nvidia.com>
References: <1-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <bdbd466f-01d3-40ac-abca-81527dbfb901@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbd466f-01d3-40ac-abca-81527dbfb901@infradead.org>
X-ClientProxiedBy: DM6PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:5:190::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c3a8b6-fcf1-4cbb-99d3-08dde72d0ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e42T5EVq2eWlAd3hQ2eq4nItZiZZHfzz8Qds2jBdIG77whsKPkoO+f2spq6A?=
 =?us-ascii?Q?QeaKv6R3DZrXPaI5qAJeiF7p1DuYqqV5R6lHQ7/UrTcvMA+PhHd38sAO1Whs?=
 =?us-ascii?Q?GCV+h7uxmMtHs7Lodua3622ArU850qNRwIkNszW5V6GB2cDsJPV+XnYgui5p?=
 =?us-ascii?Q?V14HU/M79gIVHck0yXY1lwUXDJIQhxgwHCWQ1PSdWF6SKaAcIwLH84lunWM7?=
 =?us-ascii?Q?If7xVmsg0/1hPzIm7z+kxGQTeL7pJuZIzE/AO2Jc8lPgOj/nXPMY+8T+1Yml?=
 =?us-ascii?Q?0K0IuQWwD2YIxFo/Z76ALfrBRpREd+eu0SF/mRTukqKxkJ6nbVew+Ew9SgfI?=
 =?us-ascii?Q?Eo9AD1xgRIr7uakAVraxuSJpQbDpDEBCpiUdRN4HIPD4h9ruos7Zo+s5xeRQ?=
 =?us-ascii?Q?B5fcTK4kI66IMvyOYV2wzZFje3fy8jDZqEcB4ZgyxetVX6/IgBoX2pRBRRvz?=
 =?us-ascii?Q?chTIFs6jPGNLc5dV584EH+mLS5j+Zb9yU/9CSsYvfN5F2AluVr3/e7xFZn4x?=
 =?us-ascii?Q?0eBd4bn1HJOZ07qkunyqGqyQXfY4cYSwKkz+aNqPmYOziY/0IBJWd75/Kao3?=
 =?us-ascii?Q?Bb4OT+90TymQN1qUGGxwudTBNdEqLCU6aHQHeOkks4fy+0YBpXJ1Xo2fIIbD?=
 =?us-ascii?Q?9pVApIuBxqx4xrek7LToP6/a2K1lGRhw0shup41cnCvFgv6kWMnODCZ8Dydc?=
 =?us-ascii?Q?1ngAI3f4FZHJxn1GMXPm9a33nCqCn8ghWN03we/s0iEmA98jO6/rbbGFum/o?=
 =?us-ascii?Q?bYw29WeldcS0A4e9mIoRu4iTiiDuizClCdiFe0N8gAg6/krGOZ6y2wodjrbO?=
 =?us-ascii?Q?ab1gnM/cqDCR9tyW5PWjiRlF8o0nFZnvctck/lR+fhwLK7aES1dl9lV/NERd?=
 =?us-ascii?Q?JBC2BcHHKuWYBZXn4tllfHtn7QFy7em3vl5+dj2s03Hag2I2Z3spwN1e2ft5?=
 =?us-ascii?Q?UJjYDsAJNtqNn5fOM7OVo+NVnxUMcPyMWeYiAMeRhA/o6OsndriCS8ZjVDnd?=
 =?us-ascii?Q?dNOKsnSYEdV9LP9wgHgAXij71M76daeeHfzDux/CCaBDg32j8FnWB+TTWqfw?=
 =?us-ascii?Q?WaWTAzsbPsRlQVbb58ho/dyPT6wG6SLO0b1nt2qyPW02qeGajcOQ7ranVssQ?=
 =?us-ascii?Q?Xe+c4YNwSQeQYvXuD4clIlbUIIkFEsXnNbYP2IFn4DHlD+spAeTj/hphmqJZ?=
 =?us-ascii?Q?MHRN5PVsbLN+0AEoT8+1FM01Ckb3dHpoPW5tmDZRc8dlGKOrMjgcgpB4cD0W?=
 =?us-ascii?Q?UHUUO3PxZ+fLZv6yXR+Ahj6CFPX5SCBmwNfPSHbCP6iVQjOquutQf9PGnXXp?=
 =?us-ascii?Q?s5FGdkFca9DCmw/XJiMAjU1yG7YevI1R9PbBN6unqjCS3sm7qB4zWSPvYcRo?=
 =?us-ascii?Q?xJrp/XZIZmnNUGswIdLLOooe7EXEK00L/L2GzfQ9RV566Ay7cLGuxpT1DxM3?=
 =?us-ascii?Q?5tmxCHeIfQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jg1L81Gf468Ak4POBAQi8kzvOIdqBx01owg0uW+dowV4SwolntyRAgEFsPuc?=
 =?us-ascii?Q?V9ZlqBFHmcFiTB6WU2tTHmEw9ODJ7dhK67UyGY+h19i1pwuPXXH7krTF3C8N?=
 =?us-ascii?Q?suxMUsj82PYokhI4D+nUljJvTqWyOprDgVGdeo4aJdD8PfXqTWijd4W4NVa2?=
 =?us-ascii?Q?Cc4qf+BgA37VHqtKLntkiQLAxh5OcBMED+mv7wTUb5F/SLzt6yDgdIgvE2AE?=
 =?us-ascii?Q?YL3aUP/naW+d6yl78ESQ9Gs6Vzh0XFW32Bk1LSLhH0X69PtVkEQ5FFhlNno2?=
 =?us-ascii?Q?NXfvGy3x8biUdoZP4wFZos2oDTXyOfvJ0Tu2WBYeCdcmhkMQMTm475ALHfmk?=
 =?us-ascii?Q?xfCRKimW2fgSkjC/M/7e54QuWeYxocFmXL4gd8WNGJ/e/WCiYt2pWI6pnhIQ?=
 =?us-ascii?Q?v2JvbxrJ3QrAimLkqD4Qwwk4Xvr5prHta9/3YFBgJ+abCGMBOUeNOCtCLU0Z?=
 =?us-ascii?Q?+/LBxcdrYUu4GPmUN8EMyn+6BRisBal6wDL6zNcycp1OJD1ikRlemMBhYqMV?=
 =?us-ascii?Q?miMlJtpsUs1y8jPrTTCfyx72rE8WhSC5200w/cp32hriaOGeEdcRJFpoSf/A?=
 =?us-ascii?Q?l/JieX0zs7AYi6UzozT9xUAZhcBn9aB9YVaKN1uYzUOUjWc7flCBNBHm1MhG?=
 =?us-ascii?Q?B/QiZ0K+SKOw6avnQ2aNMHYVLWhs3vwKRyK2IjI6ZZYEYOVyLEYKsEIUkARJ?=
 =?us-ascii?Q?LAzJMWD1K78EIaRD/8DUrSK3uCsyyBCoIVCjswHfDAyqlD8F6f5AJ1m14TyO?=
 =?us-ascii?Q?MLRxZGUb5sACEkmE7fmvpIsjTVGIC0DpTGXyC9YWUQhGIG8367Ak44/gAoY8?=
 =?us-ascii?Q?PrA8Dgydh9ajmrP1PVyPRlBj2qt1hXOj4lUGYzcUYfiJTa41xnF6NJaME7Jt?=
 =?us-ascii?Q?MwgPa0yQuKxugWbRaMLMIxgP8Ep+2P+18c+eEDqCKpv+DntQc3tgQILo07LZ?=
 =?us-ascii?Q?53mEGKtY/07wxNoyyxzMaggP+bar0xxrd8URL10YEGjjXUdPDT8WwaJv+cfD?=
 =?us-ascii?Q?ZYjIWWfROTUfl3IFjd0KaMkMUB5xiyZpfRrpAIPtdK7NcnnOjfQkYk2RwKSp?=
 =?us-ascii?Q?i4eFT3esmszOg4uBKar1kGgtl/A0Mw4ZfcIeLQAIc+p7K8aSA707lJfRJNjQ?=
 =?us-ascii?Q?Pg++dlnFycOtFUscUqQheNk5uxY8rtZctNPTylymaZAbFA0QcWBMXijkqS59?=
 =?us-ascii?Q?CCu4fMg+XtjBL4J/74ELaSu/xo3BxhMhg103md/W67NS5WTS9alLmxS5ENb6?=
 =?us-ascii?Q?ePGVEkvh+xWeEQzKKHsn/IUMuiJv+ujRvOyVsBUztgmUuHcgBBO5IW+24f1A?=
 =?us-ascii?Q?mdAQxQ9NYFJm07KH/uoHLSztfJrWESbpMTHQYdo9SXRqyMt8Ma7KbwUy0f/T?=
 =?us-ascii?Q?3sxnJeT7it7xHOmNcSB3nOHzaTMReXjdemz79G3u/w4Sx+CYAJsGh7BoPASo?=
 =?us-ascii?Q?2NhIp/1bpSbNW/SL9GwpsAghvD3Cv5oIXbaZMhKeKGHyqDbSTPVkGMqyEhWp?=
 =?us-ascii?Q?fc9ccRTZoWbi++F0WZa+A0WFePycOXNiDjpKMIizKUTG+SNYKTjvokeW7oPQ?=
 =?us-ascii?Q?iuB/MCiSa9y6mN5+8sKoi4w28qaYqVMH5aN+6Adm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c3a8b6-fcf1-4cbb-99d3-08dde72d0ec6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 18:51:27.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nex3n7F0eWd7DBWtVflKWmwO6HH0e3Fuf3N7cUqQR6w/tNwd1hVXyd6UuWAfB62U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070

On Wed, Aug 27, 2025 at 12:11:40AM -0700, Randy Dunlap wrote:
> > +/**
> > + * pt_entry_num_contig_lg2() - Number of contiguous items for this leaf entry
> > + * @pts: Entry to query
> > + *
> > + * Returns the number of contiguous items this leaf entry spans. If the entry is
> 
>  * Returns:

I think I prefer to leave many of these as is, putting the entire body
in a Returns: block seems too weird. I did the ones that seemed to fit
that pattern.

Most of these descriptions are entirely talking about the return value
since that is the only thing the function does.

> > + * If true the caller use at level 0 pt_install_leaf_entry(PAGE_SHIFT). This is
> 
>                          uses
> ?
> although it might just be missing a word or two? I can't tell.

 * If true the caller can use, at level 0, pt_install_leaf_entry(PAGE_SHIFT).
 * This is useful to create optimized paths for common cases of PAGE_SIZE
 * mappings.

> > + * Otherwise the bit in position pt_table_item_lg2sz() should be set indicating
> > + * that a non-contigous singe item leaf entry is supported. The following
> 
>              non-contiguous
> Also, is that               single
> ?
> or is "singe" a real word here? (IDK.)

 * Otherwise the bit in position pt_table_item_lg2sz() should be set indicating
 * that a non-contiguous single item leaf entry is supported. The following

> > +enum {
> > +	PT_VADDR_MAX = sizeof(pt_vaddr_t) == 8 ? U64_MAX : U32_MAX,
> > +	PT_VADDR_MAX_LG2 = sizeof(pt_vaddr_t) == 8 ? 64 : 32,
> > +	PT_OADDR_MAX = sizeof(pt_oaddr_t) == 8 ? U64_MAX : U32_MAX,
> > +	PT_OADDR_MAX_LG2 = sizeof(pt_oaddr_t) == 8 ? 64 : 32,
> > +};
> 
> Hm, duplicated enum entry values?
> Interesting.

Nope one letter different, pt_vaddr_t != pt_oaddr_t in all cases.

> > + *  start/end
> > + *     An open range, eg [0,0) refers to no VA.
> 
> 	                 e.g.,
> 
> and is a half-open (or right-open) range or interval, not open.
> 
> Open would be (0, 0).
> Closed would be [0, 0].
> I used to think that was "clopen" but now I read that clopen refers
> to sets and not intervals.

Ok

> > +/*
> > + * Add index_count_lg2 number of entries to pts's VA and index. The va will be
> 
> s/VA/va/ for consistency?
> since it ("va") is defined in Generic Page Table Language.

I changed the language section to be upper case and fixed the lower
case versions I noticed. There are more upper case versions than
lower..

Got everything else, thanks a lot!

Jason

