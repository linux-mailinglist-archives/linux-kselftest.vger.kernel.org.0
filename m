Return-Path: <linux-kselftest+bounces-40337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC2B3C2FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A021CC34BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6824169F;
	Fri, 29 Aug 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLX2bQrB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A244242D8C;
	Fri, 29 Aug 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495415; cv=fail; b=Ma8KCjNYf66YZA095cJPnE3qHD4yPwEbZRgA3sh5Z+JHdl3HbBcb8Hc3jPeGIJ8ie6TM4Gep3bjbYdmaLi21iN8TSOn/iRkGsLhEEOxQPL7TpvtGN5WW4Abs2A+IpzLxscpjV3B7oSBi7f/eq4Xw6p/0UUndzyKFeMSZrdoutbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495415; c=relaxed/simple;
	bh=dUQXQrrFAnncnes5wThJNRc+ddbSjbtss2D+u4/wVwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVACfUC/6m3Ae1gZpX2mkMDmuBq7aTXWn2l5zL1+f9ZoWPcfE6hGFR9R4jFYeex24s//+v4GYyCOv85CJKLVV7kt3ibPUi0VOpemQnSN6VsjkkGfQPW/eHe8vVPS2E/bxpGaVyXQjCfaoWl/Mw4YHP/zQLf9BMc89n+qoFu64gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLX2bQrB; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXXXJfBz3/Ii6nZ8+kl+/aE9GccLjBAMAfojFW3ptPG/N53RkFoBMDB5nbmWDb7hZgxmmJiM4+gIPSoWr8QMUV7WAvKYcvDZJXbrOcbT3z3AGpfDaePpGhZ0WUFWM5ZSs3AEBtXB6P9a0S2rBnhVrdWI2w+bVTPnuZDBVTKAnWS/WTZOggBoOTv4kw24h60LeSzARFrkwtC0FEmMc/vpP1ODcsjR+kV63S/r11YrcegcjwHHrjn0pbpnviVLx/5TTnXSklZpd4zeaSao5YMj/a3ai7UUw15OCW0skeD4zWh4na6NcdRDD/S/8VyUl4JApAnO0AD0AS+17t61FVGlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BGHm7bxjH9Ks0SjdsOPqC7P3q4DQuMdmL754Q53jzs=;
 b=L1eT7dnsfBptNejlqCidLWGWoujC8WWz1IgzzOiF8rAkWH68DqkM0/HvPcEu8oG3nxJv8YtKBeJIpPHukpAq5VQmgNo3OQE139v0zx2w4KgbJxDMdvvPgUO2WtftiHanIchWeUfUSSbV5XGrVsLzLfRhyGZwGQKfQGzDY1tjR9nk5CTjgzeEzcHMbSCQX85PO+IbdXrvQ5ztVklyMHvC/dcmQ6h+LAe9X8KEck+bxcbRaPTk1KZwAiBTMytr3z13nBrJv7WeJvPccLynEKlEkZbDiCeO1MBwSXFWKfSY44bDg96ZSb83viXiL5cHsiGTtOt7bNxrcILSsXtc8pqo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BGHm7bxjH9Ks0SjdsOPqC7P3q4DQuMdmL754Q53jzs=;
 b=DLX2bQrB6Flyazn6n4K8i9gOAbhxJbw6u1Tm19YKR0rQ71robkyyAKLR/UXjl9GI9/69NnHI9c4KZGHzLKZBvon4vwByW2U5naKs5LWnyITaCP60eYszs4Df8eYCGIDFQrqHw3viY/Zsymvc2+tsxCfpBtfuM1BwbYzZhgrDbQI53RB5+am5fb660LeyazE92EKHDA/TjE1t53cp5a4/xxcKAtpM3ocJSXlQw2fzbCGv2tEgUv7faf26sR8QLxR37tZwcZP4cm1bfnXzOCmTq4JFXtCcav3ZXj5tCx390s7ti7kC3AVOttahLBDOrTp5eywL4L6w1V4W+CZQbkYMWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 19:23:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 19:23:26 +0000
Date: Fri, 29 Aug 2025 16:23:24 -0300
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
Subject: Re: [PATCH v4 07/15] iommupt: Add map_pages op
Message-ID: <20250829192324.GI79520@nvidia.com>
References: <7-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <c17f0cf1-9a80-4f1a-94a1-8869b8ed0a53@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c17f0cf1-9a80-4f1a-94a1-8869b8ed0a53@infradead.org>
X-ClientProxiedBy: SA1P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 771a37d8-222d-4358-8dac-08dde7318742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rSkUwgRT3/nItNGjRIoJB+E19WaXv7/aS5ADaeEgRSSFEbmEwXJefvmzVKNg?=
 =?us-ascii?Q?YT4CZsnpp/2EbIG68I7W4MuYkmSyDGB5jKgRTEPTdvHrFLztMWWKwds0DzH0?=
 =?us-ascii?Q?EtXZfXtFv4tGgKX116Wl+lNDwYxMPO+n7SMSroVqGd9zzCGWLkOqKnqNCteP?=
 =?us-ascii?Q?h9p+eaGPILpGCQcpoLpwUXCLACUtSi2kXOMtQtJBhdLhJbPfzyeEg3DGoERG?=
 =?us-ascii?Q?NSscpWWIByn+G3K9NrBTqtk7XZcGbyO/datrZeg4tV/PlJv/iRx6/z0LdBzh?=
 =?us-ascii?Q?WyZ1vlOWZGJq2Aki24ju4YtbiuPIqyM6AjC4IOaRpKkW0BONIAj9u98M5bUe?=
 =?us-ascii?Q?27JKELNC8XbwzUojs2zRQxegXJj2o7+ZT7Q1KrJ891gW7w5QQZDPScyy2E1X?=
 =?us-ascii?Q?lmxYWo+bWxSE8hzym96jopK3+6aIFutqHxf2v1py6JQ9hRYhux51Uz/7lKk/?=
 =?us-ascii?Q?6X5DeO2QANJmN0PdyYm3hFQt+8yQoSKgNW7/C8rBwHhY8LBuDQOewScVxkMV?=
 =?us-ascii?Q?5FijmsFmWR54lhRrCEMYErzd7G4bgM4smX+X6xMOogOc4SrPu+RDjNKXtkOZ?=
 =?us-ascii?Q?gtda5XX4c/ZFb9lPE9Zbwq9PEb09kDC2ot3L8RGnRafMKgkMppEIjmmJQxhq?=
 =?us-ascii?Q?Vecv95Ke2JXEm1kz52tDHRZYzkDHn04Y1fyKch84vNxe95aAJPujh3/ZQpf4?=
 =?us-ascii?Q?X/XfMFY1diDiDg6PMkk2qB6j3GZfc6aNj1MEzDNDJngVk34zj2kqXsg7iMWW?=
 =?us-ascii?Q?zWJ8t3RN2LrVa+OkZ9EIMbhF/LqE9ywzNzDW6yMQlaltgqoFYa91olLHlnyi?=
 =?us-ascii?Q?3LsK+yeaxcEhoNgFPGtU9RTC9/x7BSleimwOgjHnrZts0LS9p9bmHnGD5atN?=
 =?us-ascii?Q?EW0ZcI2tn3JWQsrFLnwjAdeJRTKltv64lzzZr2CRJYqat0jTbZzhmEjItUt4?=
 =?us-ascii?Q?6ackLOL0o72TyGLm0D/WMcebYZYNf87DSeD+lkXHfXNT9tII/IV3Ai5aWg5L?=
 =?us-ascii?Q?MNj5thv9x1sP2TG5z70XLw1iVmsWBf8oYoNJ8UxUHr7bFMTO7Gf5BkUMp+yV?=
 =?us-ascii?Q?swM1pyD1hfaZLMrchXHWxTmHeY5TfGmHIiouefD+Uc1SnOQZEQJnzW2CTTY+?=
 =?us-ascii?Q?UWTJ+7NCOQyASOw/qETJ9YZLzv5T3wWxq+JdaTChQc6P45y4P1VQRlbNKbKs?=
 =?us-ascii?Q?B3/qQBd4+FJpVJedzudHH7C3phySUu5nRVf6InRdIekzHUgUOo0DEDxAvYm3?=
 =?us-ascii?Q?6OD1IxrKwE73Wap4KetqzEAvyiFImUAAFALcpq1wmY9zmiaYjavpa3EmcmMo?=
 =?us-ascii?Q?/3XNDh9Wz5qWIqRUL8SIEbKQjW6h8N7AJwuCVhoXUsK/wmj4uDGEwe5oZcxa?=
 =?us-ascii?Q?7caXSgL5jLnd2WDaxA6/Movm+NVCLd8BDLnWytEKMllP5tukC2DIFm8NIFtd?=
 =?us-ascii?Q?B8vrTr5lzLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTaIIVvA6yMrRvCRJPCIALC7/F9EmNCFO/W20o3CPy/OIbv42tOLXsDykH8X?=
 =?us-ascii?Q?SYKCyzz6MHzO/SdUGEhGvXcaAwXuI0krmzFn5lKyRlMkd+AE9Lb072825W8A?=
 =?us-ascii?Q?AgpMLwFky4iLlU1LiwyWFtIeVbW+tNdkS7lvRet2ffVZc87JhLmvXHsbX6v0?=
 =?us-ascii?Q?HsuQ0pJBnwqc3svV7lG9nuruOEnmcwPCnOwSsjviaFWKM7gKlqgaIk5CX4cJ?=
 =?us-ascii?Q?gHNpk4KP6aYOiynTovfKPMmYyGK/Zi28/x3WetPoWuLCjjBZvHEULUlmBYv1?=
 =?us-ascii?Q?MMY1q3JOlJB6CmaeyM2NIyLYF6Q5p8zep5QGJOQ5qQIBgICN0hcan3PQ2B/m?=
 =?us-ascii?Q?n0Z8yq4SDd6P4ja1VhSbi6ryx+flHC+S4dF7cgZQ6iaW+P73AM4az+7Mkr4r?=
 =?us-ascii?Q?XDKAhQtRLtpy/54HfuM8+8fh7OBDIIfe1s8dTPRSYZw4EZ8QwrTL2izG81vg?=
 =?us-ascii?Q?bc4baBJKlYjzuxcrZWX8NWH2StFmN8f6rqAfvfOilwTIb167iLcBwO2r1wcf?=
 =?us-ascii?Q?8Pu77w0yCKX8gP/pi8UOTlCI6zawIKNovOQzh56CzNbkLP11ITvgTpMLPraM?=
 =?us-ascii?Q?1oMjoZKJNM7rf84ztvgMopeyklzNhiP2o2QfMd9o2dvTDXza64DIAJEEIzFW?=
 =?us-ascii?Q?P7TgL67I2Jta1a1bKSbxY+FVzzzUjRdzuepaupG1G370eDnL3FWXGNNWrE65?=
 =?us-ascii?Q?OEpbn7wXCPIqS3qT0fIhwE/okjOXQwBC4LkwIOJfnmiUy4viFpNq9fyc0dYq?=
 =?us-ascii?Q?TVAjy9jHZgQsuw1tNL2T2Cnn3DfeddPBoeHwNbePMq9CTLrwNlMQR5X6qore?=
 =?us-ascii?Q?Ew1H5LPlixuxEp3iUhHSs6ltFnqdch5V/cAYn9FLHdfaCysivDO7OQTxx9yv?=
 =?us-ascii?Q?OkhG54imNgz1pi8Y4HhasY3poPs/abWnI6Vc9L5qnrEJctoryr+4+Igygd36?=
 =?us-ascii?Q?ASAXCrxCPlPsUqctq9EWW+wkDDYAgNOylKJ+aMZVHniRxbPs/6c+y/0wQNun?=
 =?us-ascii?Q?2dCFHPTZObSEKOkaIHGmd4MRG7ZnPNzjlcdiK+DMY1WoPkbw7rLOcXNA0DZd?=
 =?us-ascii?Q?4mgecCQXploNyKiUwKVoewC8S75Fx1eFGHUpCAHMyVrX2/6otLg1Ye7nJleI?=
 =?us-ascii?Q?fsPfgWLklntzWqZndoX+igPlRG68+MXgpZKLWf7NQubowtYS3wYN0GMu2F6u?=
 =?us-ascii?Q?yyD7YJBxMS/I8jUfZiolZhzwjLEwELzdJo5H+eWxs51gC3jyO7OQ+DmYMPy5?=
 =?us-ascii?Q?przazw/FmafPht7wGhR3AvKFI0Q8pimPvjXFVVV771QQdUFek/SCgc9e+00I?=
 =?us-ascii?Q?683YH7uP6Nt+KedJk85VPBJpjkhtttIwkiRWuAOaQsMiYsyAkKqyTtFJ3FRS?=
 =?us-ascii?Q?6nc2e2wDOUtJiZXBscVnoRbDNDvlXNxdKFGDLOrO6o5s7xMHKGPhxl0As8EL?=
 =?us-ascii?Q?oIx4Lgh3RjUU+TsflDGeQoR0mjpvSK30OvZ11FJnXI+O/VO038J3uqdoFu2F?=
 =?us-ascii?Q?/Rp0LKUOFUBJ7JC6aEaOCdvZew66XSTSNzVOFXfFNMw8FcAAQ7ADrQ9slGV3?=
 =?us-ascii?Q?Jd2ccZYv05Z7BS4Wm2PSxxn0jeWK/oMmRCh3SWDb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771a37d8-222d-4358-8dac-08dde7318742
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 19:23:26.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDqGPdNstrVZcWGDyzPZeHo0Lxy4nb0hmmsblz4ofvzTUNVBPVKwqNOmbmW1l10U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

On Tue, Aug 26, 2025 at 04:20:54PM -0700, Randy Dunlap wrote:
> > +
> > +/**
> > + * map_range() - Install translation for an IOVA range
> 
> Maybe I don't understand the macros (haven't looked lately).
> 
> Function name appears to be map_pages(), not map_range().

There is a later series that changes this around and it didn't get
split up right

> > +	 * @iommu_table: Table to operate on
> > +	 * @top_paddr: New CPU physical address of the top pointer
> > +	 * @top_level: IOMMU PT level of the new top
> 
> We don't really have a way to document parameters of a callback function
> inside a struct, but for now kernel-doc.py won't complain about it.
> (Somehow kernel-doc.pl did once upon a time and then that became dead code.)

Seems like we should :)

Fixed the rest, thanks

Jason

