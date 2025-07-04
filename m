Return-Path: <linux-kselftest+bounces-36565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245FAF9443
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E970618872DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0A2FF497;
	Fri,  4 Jul 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bmUG50cT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE812FCE1D;
	Fri,  4 Jul 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636019; cv=fail; b=RRUPWLTicDTAz4hYejhuZOML0Tg2h8r/IFFiscL+aW3QnQePowdf2UoCRV5QSo3PGQGUC6e4hUgokSWHSiZAAK7zPiqu8VvbwV3ZK46rETYnosveoyxGZjUuw2vuxed85tKPoziCFwxh7I7v847KQpAeACa079QsZMuJlbVuQ2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636019; c=relaxed/simple;
	bh=WPEvkPNRg9cUCXj0Wp7X7gd+GJJOMUIcdMsKQKYnReQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YZ83Yudn6GG6vRjYEX8Whz1YgvrxvzAZzKAI5JUG4EAB3jVyKEu0K+0pHaiQQUx+jviwsQ8hfsgwenNdTOORQ7jWOQ5ly9spQ3BHLPnRHqtITxYlbyk5v47UpHXJ/6Gmj2k04SiIotn0bBJW0FzGx/4m1Frv8w/UDZeNpMYRBAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bmUG50cT; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNjqVIZekY2NKrz7R51M2smkBStSFBYbLn9Kc3Yb3Bfmu5YfiE4mU4oTqzRu/fJaThUaOG68E1pb8IAnxP+MdX61dF06AMOKA2Pv3fI68AwUEpSF+Kl/wCB1bXBTtGNaHVJnc9Z+ab5MrEfnXhpgZu1Gppik7ol9Ho2s6DHUWS9BYh/TtinVarO9XCUYjmwenKXsaYFQ8Di6PCMDh5OFVy52Gr+V/8smyRXzadBbBtncHMDCJNaPI67hftsBBHB83a+wvhoM1XBvEZuow+pIdJerYnBJkOPISd3EtOxyj+gLfyi96Kk8a8/thYfp68FweQsuexx5akDeDEwtubxJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NEnLZ3xPergNSyaZLXtQI8DAUow7Zw94RFQ0icxedE=;
 b=muaPQMl8nWyeuM1q38ykcSkEez1iLkWwxYgMrmzXMs++wxOfdSdeWd/hybAfQet1Zj/qOzZXP2p+7niRIlwECJJ1JtncjoWZS9j+sDx3l8OwjDO8DgYJvw4gA7nSS/edOLi7gQ5ze2X7NDiOtIKUguJETFASv/VKoG8roRzEMGmzONA/taOFCKngayPUV0dJZtQMdE1Q7y8c62M8ImRCOf6HPGaX8kWH2KxuQMO7p3ECWMAGYMKjXqGM+D7dhbrPf+4hOORruqCn8KTB3W6q2O1FoI/Kz9oUwmxIaaRkx8nTgdpwG6UT+fJnoRxvbZXV04V0m7F1U9yqGUZ0hlsO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NEnLZ3xPergNSyaZLXtQI8DAUow7Zw94RFQ0icxedE=;
 b=bmUG50cTMTP+ROR0A/pDEcRbDkA4KmSbEqM6Nwr7KH6V5OZwmlZiKQzZxhGQ4JBYBtTuQxu8Puk5n2Y0En0pL76EgXLxF0me1DC1JwejgDp3pZ5DYaHXvuY19s7To8Hod+wvvBraVdkC9PVnVg45AFTOyEiI81cMePwANsqfJh1c7rE4DDNfe/WGcmr+PcXZEsaxf3BQm+njRvK05pOhdIDzb+zpyNEayJ7bJKcCsv1jtMpPlt6ThOlsqtecjBQxtnf4UjLlTPBX5CuNb0TsPlTAuVCktrZLfKYIutmJTcQHrpCXyoYc3asjr3xQQHiv79yJOazeTwox5+CLIzO2Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 4 Jul
 2025 13:33:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 13:33:34 +0000
Date: Fri, 4 Jul 2025 10:33:32 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 13/28] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250704133332.GA1410929@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <31ab67fa5c4fc1f2c8bea74fa23c1da7b97b9a93.1750966133.git.nicolinc@nvidia.com>
 <20250704132602.GQ1209783@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704132602.GQ1209783@nvidia.com>
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 937c6064-33f9-442f-bb04-08ddbaff5fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3MLpb2dLpmtFMbydRHDysRVpO/qYPRsXqfRjxtmBnYCFf/MjJXKAF2JrK1R?=
 =?us-ascii?Q?uG9i1jK9mnvb7A3jQA718k7EQHu5pK20ribpnOC0KNp7qQjicRfWbQ56+7ct?=
 =?us-ascii?Q?Kfysrual67EinZUo3zBZPkQzTAyMlfF/3aOjpeET7PWx+NuZqzZgX2/o92Pz?=
 =?us-ascii?Q?7aPKtEqigsqV/8HdJjSW4QUGFDJSFnEyq6uoneiHmqy2E04tDovdt8Q1oyDY?=
 =?us-ascii?Q?lejohHTJZQv20H4H5+sSU6C6HvbqdjznbDY+vq8e5bSn5YRrKgbAxpP3rR1Q?=
 =?us-ascii?Q?UzPD23kjqTR8pYMAFN6S55zUf/m9HgHMZ1vga1Nf9fXiemay+Ha8s/Db2PB7?=
 =?us-ascii?Q?1Ha33t7mBUJw4Zg6mz4ARW0O6QfR9YW3zkJl1yZZAAZRWv16EEQbKli7yqKR?=
 =?us-ascii?Q?R/B9tZBpnTbbyQtsmiSLA6GCz86fxAeSSUXaFdJA/zIEP8xEp/SsjN/m1Hyb?=
 =?us-ascii?Q?S3QT4ib5HhUea4r2BUINrqW5NLrJ4hH9Ux6VOAtYpCBn1Im3PU7+LAoYKvLu?=
 =?us-ascii?Q?aYFqGAsRGwXCe7MazpT+eTtaSZfMi/B/L1+qjv/qm/C36H6GpsKoBkZvuif8?=
 =?us-ascii?Q?gyG09Ri+qyDp5hHS/VkU1mK25wGbZwUu0J8BHFooP9cbTV39cdhVgc5HMapq?=
 =?us-ascii?Q?j/fOVAv3u1lh/64a1S71XVj94fiGQKn9TtU9LGNP0lylF9Njkj0jg1E1zemO?=
 =?us-ascii?Q?oapMosMriNmC67HZ1PyvZLywpD38HhXYk3Wqu/WyRajYkJO0zTAhgcd+r1Zg?=
 =?us-ascii?Q?MslaZ/DHp3dr6IqlwtUoz0zQgS0XfZ7s7l4pi4SjvM9/BIRlJugZquWhaZeG?=
 =?us-ascii?Q?7S/ch05LBVPmeGR9eABlj1+27rmx4lNAK0wdz2x2OnBGepPYjdxKIkJ63jUn?=
 =?us-ascii?Q?VgzO8sPfov124lgVNHfpkXpt7jXB62WSObH6WjZCRHGwek1d1e6Uk+pVBhfR?=
 =?us-ascii?Q?GEPzAtbZ+Jc9vjydeN3820bvrWeYvXs08FWOMovAQXEAQgZ3JRDH30HG3c+w?=
 =?us-ascii?Q?6OERhwTlicWzzkicYUTptVxKsufmhUNW47BvJP7xoD+MJaVXMTwhbZPoXKhD?=
 =?us-ascii?Q?/Z+eLBJ5YKGQ/TuJboXOdkkI815ynLjNttCbmitmfFCepYAetxzDIqD0vZAa?=
 =?us-ascii?Q?/03Lp1hxBKVGvU9oET6sm4Nw3qZkCPTCb+e/smbBTMZFjGF+VfRcGCwbhOO4?=
 =?us-ascii?Q?B45HcgWwuNYcWWTgsZBgJ0PVGUW7gmh2gxjcpNuiZRMTua1Us/Dr1foaUoWv?=
 =?us-ascii?Q?BVuWCzWVTdY8YnBBy0I6IXLYa8D6vODx3PdeXO0PFJ6IOSXHzs+boN4BXkUk?=
 =?us-ascii?Q?tY8AJEAAzzq27LOxL48PH1LsA/FUNKuRNdydsZk8XY612wFj+VVbY83AM/Zq?=
 =?us-ascii?Q?pKfHcj5czVa+eLAVgpl2cP7PBS9OeaND9djbHhyCyRX6qcL9mK3hhPnRzlkr?=
 =?us-ascii?Q?w4iC5bka46g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDlVzVl6Q8O8kBcjriEqoUd9kqh01GkKgWVQpLTXT5v3Q3/ZPB3h040Jn4Zf?=
 =?us-ascii?Q?0uOJBKJrDtfE8Ifwf9HxM+YfgVAMtSeq+4vvlF0uyh91IVEJi3Ym0xwTCLum?=
 =?us-ascii?Q?As3ILF1JSMMi4l5WlvaMZb9DH0msK94YNZEz+UEge/e5kXcIGdFKNbqS6/Yi?=
 =?us-ascii?Q?UpEpX0HRd1zICdzSiJvPIQjlRJSh9tFfVXJ3ExNKL5/gC29hDai1SUfvs4MC?=
 =?us-ascii?Q?Vd0zITIsaxu3j5BIzTmics46HZr5D9Yvxy6ytd8kkBKb4r5u3kQC3k9ccAa5?=
 =?us-ascii?Q?Tsiwg9DBwEtIsghqwZ8bVCBLNlxE0mOhrjT9tWhKFPbU0JvN0Okgv6CKeozP?=
 =?us-ascii?Q?MvMaWkgGcozTX00Dl24ydx2q8ys74IGN/tQ4E8roYUplZQ1y8vcuUEjhAKs4?=
 =?us-ascii?Q?dPqiktzePGC8xVee4SVw1h6gmmP1Rwv79VSOTnVXXJSGpjAqTtQL547X4y1/?=
 =?us-ascii?Q?OOZfBEzMkscsG8/qQVawruJLl6MCZ9IoBSrixONNG6eom6cSXMh95FkoZr+i?=
 =?us-ascii?Q?0ZrVvsLUL9sJqhVcPWejOr66IVxr7dVjaCsq3lLE2AulPdqBk0oVQiMtavG3?=
 =?us-ascii?Q?1kI+782BdSGNJI2DF1LtXFLelDFVz92jiwpC+SI8zMFNu4qRjhBDDTHKi6qm?=
 =?us-ascii?Q?XaCBCrdA2gWh9MkSnDnBlLu2meuCW9PbVSTcTspmpWmYT4sYiPATInCdWlsK?=
 =?us-ascii?Q?Z1yK6M1I1kf9En4b/VPA5XqoxXNsYkUds6Mn11Oz0VkJsW5uNbZYxf7UNr59?=
 =?us-ascii?Q?RwaSoRfV6r1QjxD+xEbjnlL11my19W9zJiZestuqoqIBq5/Arjl7CJDpAx+h?=
 =?us-ascii?Q?SbFgfa3+Rq6kFigB3OlgWUCHdDznXDnFT0NM5MEjbK2eo1fIb+Qbgfz+IsZ4?=
 =?us-ascii?Q?CW5/v7b8gotjWP6ZI12qFhelyJMuj80fbAOwmqpfDJqI1yXt8fTzG2Dl1uzi?=
 =?us-ascii?Q?Fwrlxh1N90DUSlxTWpU69xrG4IgdVQwbl0smtd1AjyV+lK9nmy4i4wuhIchS?=
 =?us-ascii?Q?lC4iBjnTshBSXQ4TUDOG8dAFkp5ADcPrY8mBvOU9QvAIKF69bm1QfuXYSrXt?=
 =?us-ascii?Q?P/jnzKaEIb+Rmg7fxm8mOZuAW3XKUX9cRIsoH7HQibcUE4o+LIaCSXWRm0Ev?=
 =?us-ascii?Q?1j6PFwK23apSrsK1H1ntOCsoAinw/q8iqL6IrvjKVuWL4kVyxOkEBHhsEvXO?=
 =?us-ascii?Q?QuAUsBeUBUflvYrt2ZTeWlVJ0QdFvsi4SJREGdHtPV2Bzuyn37tylw1NSoww?=
 =?us-ascii?Q?JZMAZs3BaPvDoLtprKZteNf/nxeSyGxuKYqF3aEtgih9QrcgG2mQ68Piqk8m?=
 =?us-ascii?Q?RJLLd9frv0EmrrR3FtsDJwA+IPDegUxTgQvb/sYsCpnrbrvrlyrpYvfvcxz/?=
 =?us-ascii?Q?7mEM9XYZMuOftj/9zA6w0/zisa1i+QzTvrdeBOCTUjrwuA4+XN38Q8ljzI4b?=
 =?us-ascii?Q?tfcKAPK7Xe2zV1wALBga/+wLGKVQMZxfrLLG9qc5o+Sy/dPFH3mPDCNXZmGu?=
 =?us-ascii?Q?QhNWXIiRFln76KLa/bR2dqN7zPmoV/elwivDcbgis/GsD0JSM7O97VqbYuu2?=
 =?us-ascii?Q?UmQdTU/x8dhpqM5acohfwzqgytkG1wH+Q+jG/i3H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937c6064-33f9-442f-bb04-08ddbaff5fc4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:33:34.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDRCLOIm9zGI2ntJSgjc4Z/c6+TjPEIL6vin8NNr2HYP60GZBDBlGM1XwWAQclBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5

On Fri, Jul 04, 2025 at 10:26:02AM -0300, Jason Gunthorpe wrote:

> /* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
> if (check_add_overflow(offset, cmd->length, &length))
>    return -ERANGE;
> if (check_add_overflow(length, PAGE_SIZE-1, &length))
>    return -ERANGE;
> if (length > SIZE_MAX)
>    return -ERANGE;
> max_npages = length / PAGE_SIZE;

Actually I see now that overflow.h supports mixed types, so this can
be simplified:

 size_t max_npages;
 size_t length;
 u64 offset;
 size_t i;

 offset = cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);

 /* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
 if (check_add_overflow(offset, cmd->length, &length))
    return -ERANGE;
 if (check_add_overflow(length, PAGE_SIZE-1, &length))
    return -ERANGE;
 max_npages = length / PAGE_SIZE;

Then the kcvalloc takes in size_t:

kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)

So there is no silent cast and truncation.

Jason

