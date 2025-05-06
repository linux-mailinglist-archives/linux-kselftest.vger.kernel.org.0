Return-Path: <linux-kselftest+bounces-32506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF43AAC34D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 14:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E283A744F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EAE27D78A;
	Tue,  6 May 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWB+wiUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2159270EA1;
	Tue,  6 May 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532885; cv=fail; b=QCQ5gfsPCATbZitL2LlAVuECdKkiSArBoU7P25Ie/BwAtkfWqEYs7HDWqAc/THthRWCyvhgT2Pv9EsHfTZm/laYeyM9G6ttVqAuAyGyPGs3uqFj3kBk9JWQOhR00gywvw7tNIVB2q5EAhQ+vmWfW3HtfjdgHYMPy+z3NdffEwSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532885; c=relaxed/simple;
	bh=j+GDyFcW3370BZncVpwlwvEWO/c0v5dxiAURlY60MXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tADA/CCheySTOhZJ4wPvnAhGR+E/HOHQ+d2M3ta4LY29oGpnvsiSLMLyLZdYFjH2oeBmxdNi7Aw9VeNa0UFqG6PcugFkvzXn9sAcBDpfSwfqn13A0g7GLhU3WniCNXA5qFGWptw4uMSik0QIDM0TSeqGH4Qnf1gL2sCywg7q8dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWB+wiUO; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmitRjFaDiOlovQHFWoJYXi64Nx5aeMqvfMbJWZuVfwvfUAUZx2m4BTEP4/HeTy7DfRvWIwlwL74R0fPAx8XGO2yZVF65FLpNbNGbz6acVPmyylbCxexDAdGzzExUOugjG9cI3BpEAop52D3Te37CXi3eRYj3a2jwUj06+d8cwtkHysEsZOeSQmEAsEvTlaHsFLkLTpMU0jtX+nMRTd2fya6XkP22txtlQxcZyTeqJIwss8ZwlNgT/m5vA6Xe+zh6tEfw0v9vaHggsPgGX04EaDw/wwRHOhPtjFDYS29l/PV+oFUBmp+Th8lRxvAi/ILmZ4vTsebuwEB1d4P3J1WzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rze8gXCTnTd57b7ufRUcpHbKsoNWo/O6IHP4XNRr/A=;
 b=L5LoeMuJqh2zFNYYMBMW1wH9VT3W8gJMSXGNz9Dnkd+2yJm+Q0tUB2YGxA/2L/MBEKsRw+mWPOmUrqOiX4LN4TBI6AlPI7R6SxlD62cWgWJRCpFdQJMhWt8i60FGJbORK1DZcBsYxdBmxSO/LcVhA/lyduLdyiIuagYu3Z8fpIEUzRpKmgYwRCOgNi5kVUnZtlZS5FZeREHv2VK/Kyn/n4Bp0wbBEaVHZVxemeS5RolHonpgWnXH7O6p+zC8Sd0VOn8l1NmUbrLR6Dx6GkmPUVHjFFSCZT1sQDDw3oE+m+f0dbVTU+x6io8A/7oPp2k0Jzoa8hy3s0RhYKlScnRVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rze8gXCTnTd57b7ufRUcpHbKsoNWo/O6IHP4XNRr/A=;
 b=HWB+wiUOZcHDVEm5jrJvye8VqeN64THl8iTuoglkCjfv47sxobwtC42QixRqXRPFlci9YaR6hTlRTR2oU15DBiL22ziSoONTdi/629B4u1VaaEFsaKKnKqcbON9FUGlLpsANozW2JYBEPJTZMhShVQOzM1WuMGeLfXCAxEmuCp5iBofc1NJS1dkqR8ohu7kI6caasRo66TqR0HNlMjaX2eskafULMfm2JzNet21930im4/IJtAP8TaQsIPyBPPWrojh/a1yPI6AlW8rmBGiGM3jmQP0kuN3FvwOV/TiY9Ly/6U6W74FEW8LmSv3KDCOlin0hg2h6q6FqRbhwCiki/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 12:01:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:01:15 +0000
Date: Tue, 6 May 2025 09:01:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Message-ID: <20250506120114.GV2260709@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 61891014-ca92-44a5-0e3c-08dd8c95b409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Yy7FI4kKw4CLZqGY7YDUxFu9NZtJxwGCaOP7h7a2/WM+FEMrwQtHQuuCpT+?=
 =?us-ascii?Q?xNzMs3MGaxGhbxPDjY1Jj5v1ZB/Sm75GX48kIMlndi2GoMjHGaVmSXJyve+r?=
 =?us-ascii?Q?p2yOjQxRy5c73Bi3Wo1vjmUhukcp3O9mmKM/gQLHHJMqT342PK5SJAElHoqW?=
 =?us-ascii?Q?pEpYCmnwDva1qpaLcoF5gGaGlboBeHmdUryPHZDrKm/v7lfXwzbndctYKNx5?=
 =?us-ascii?Q?F8DYbSfZEmTyFxD7kZojpr1PO0RxcDbMaUSb7DTMIIsrkjhfz4vhPzeQo88K?=
 =?us-ascii?Q?zKAxG8EqNBVHNbkCzRVFpHv45RM7QvFSfJ4ipKl9y2kXENATCbLivbw/mrQD?=
 =?us-ascii?Q?S4U6ddNcobi1jykCpHMPQ7OazSnyt5t++q3SJOyqPnBE4UyPZ2rI+c+l+UE1?=
 =?us-ascii?Q?DqFUWuo3v3ElsIivxw2eC8jdwrIEFqxioCTu8E9oUv1bTigTLcgK22K1Pj29?=
 =?us-ascii?Q?RsnoK5Lei1gDw6eJoO+2CSMUUYRhxVd3wTOAmKIGiZg4DCztxRsLjfG8nSDC?=
 =?us-ascii?Q?neUuo5DL8gvZDBKH47cR3CsdV+Soum00Zp+FnCgX3vjhMxHFl6emi6+ZxcJ3?=
 =?us-ascii?Q?hlpbeBc5d4EInl94mCoAYJDJmLNadRiZXb3RwNI2fAH5+MXEToq+p+358+v8?=
 =?us-ascii?Q?D8N74OY1GpHmMXwV50LuMDaC98sAW1KsLml+XprE+BTQW1KGtdrGprQ+s8A7?=
 =?us-ascii?Q?w5DLgn7GtfAYLW6SCUXG9YVIVa+zN661pBGhHe37PbL3Fn5SAvanh6ZxCFYV?=
 =?us-ascii?Q?DJtw+dvSsElsp/EqKrnn/wEqwuJYNmZ2DGcN0ztamWs+tQgg34c3FIqBlUxL?=
 =?us-ascii?Q?ASd1JevnLp55za0LO57nd9Rji2PtCFwwz+3ejEcnEMza3GbSjHfZijN5rgDo?=
 =?us-ascii?Q?xzkli6cm3oQ535sNMq599t5+i6leVZDdsS2gnUXDbmm1zpPNT6QJ8W0xao/g?=
 =?us-ascii?Q?/lCnpjYPbLuHzz6NTVVdhRJvWHJgfsGi9Mp+YgATmSMQaxG6WR6SWOunZOmU?=
 =?us-ascii?Q?CNDs1769yiooFf8bCjXBVkjukPStovFy6gkRzZLlk5N27UrTYC/sIy1VNnfX?=
 =?us-ascii?Q?E6Ho12Y1tretrUhqIvNm3s3ORlhYOBgqAKFGdKscYz1wBYMaVGrDBQECR6T7?=
 =?us-ascii?Q?2s7McbdwXwaWv9GNEG6Ohhf8d9pmXN6c0/OAPVywqVhMowZ/s+6B+nXw3Akc?=
 =?us-ascii?Q?44aZAxIqEW+utVGyswJq40Yx489jKNeNqchFyCRUwvYeOLrzsvW6tfpDYmtq?=
 =?us-ascii?Q?MIEczANUO5mUiULhbbglJjtCiLg1ogpRI4asRMGk9BjD1cQDMPaGItk5UbR/?=
 =?us-ascii?Q?a2tP+U5/fFXTzDfIDToarNumo0icW+WMVejJmJigBMAYEk3isJD9XDISWSwu?=
 =?us-ascii?Q?In+pr8cih4zPB1YjngYbB2PnmGIJphTtsnQZc1a57BVZEqh3LRym4xC9IRgN?=
 =?us-ascii?Q?m4xchA9PjBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWyytGrMSiPXH2nuAy8zg8BzgWmVmiahDeG+nXzf9rVCzAqaUiA3rdD5cHSI?=
 =?us-ascii?Q?xNgttLhhmnZecbp9O3L9tiMQD/r2yFufZd1vsmL4awBITJ/dB9POrY2pNtPD?=
 =?us-ascii?Q?tTxgMD5NAk0uIJ3a7sj6L8mhqwhDOibgP5zRpdCeYb3F0ncBzlj/fNMcD/ID?=
 =?us-ascii?Q?r+VwkPc3QNCapEgUVKeNyOi1nZHvzw2vIDZe/unyICQjH++ieFZ3DmvwZ2hx?=
 =?us-ascii?Q?c1IkNic8YEr79USv+md/ktMAgLY+OQpqhIVvQlSi2xdBRrv89oeotLW5NnzN?=
 =?us-ascii?Q?pFBTwcOzSLjfpEUm1veDdj8HzuRU+VnQzHRIcWqBCir8eYUa/o1y1AiHhJ0j?=
 =?us-ascii?Q?vNMw2xDLoJ8w2sCwbQo+/2WMaojSXe/LO3WgdwqhmOJ/khXmYZOrqgo2tYs2?=
 =?us-ascii?Q?gucodhZDoCYoZjjJEXMYvACUY6uOr2yLzTcQrLgrm5L6XLjgN1GgiWPX8F+F?=
 =?us-ascii?Q?K0iXWXFDxB+dVsyPbIQdNc+T6Sq6bX6oH+0Y9rq3G+bFt2yQ9q9Svb485Xsm?=
 =?us-ascii?Q?oHHTsiZPUUA60bhRfvRb9LMIKcg6TImnpkzX3VtgWB0bjUgIRGUgZKz2ioHF?=
 =?us-ascii?Q?4XOoZd4Ct7I3FXmqTL7PKcv2uaabT1XsFiwR86irKzjLrMKEpJSgkZ/8C5Xo?=
 =?us-ascii?Q?vupicr9GupTQAAdkxVku5UF5o+BMFdwYE9scnY8l9CTeqWJWNI7vVa3CtKri?=
 =?us-ascii?Q?af9blfvxk9TJwPqfNzNuT7pCSn8p8Xv4fi6r+r0QsXaXmwLFUF9Or4eo5mON?=
 =?us-ascii?Q?LXgBxhAYVZMpsvPlG51basiXqqnoNgpNlUFz3swLv+vdxXzIbHbEfJZtDZLt?=
 =?us-ascii?Q?NtyG/mePWNuWdQviD6zqcPAAu+F2Sj5PqsS0TUzIFk9dvjyfPrMNRTELn6sB?=
 =?us-ascii?Q?KfYl66te/Zz0pxscO7Zw/BfPl5cnuSmbM9z0kCg6OFSTLmveH1+9DOZPvILr?=
 =?us-ascii?Q?VX936ZJ9nXuJMiLZFFvSiX/CXiVUxC9FXHQjpY/Jf8eRuNmKmMjDsh29LDUk?=
 =?us-ascii?Q?k47DiE7Q8pYNU6yZCj+bTEA25GSIwwVYJNOMd/W3cAE7eMAO/2DBwpn4HjFT?=
 =?us-ascii?Q?3K2L6wzIuLUttmcDouMhh+Y6z8XAjcKTztRUXpesoy7PdTv43h+NylgA++Ad?=
 =?us-ascii?Q?a5QGIBHgBasWrpuu/5zRNv6l/W77F0nElqoGo/0/fbOwttL0AAbGCfKl5hn7?=
 =?us-ascii?Q?+01HQX27T73AoCy5XdM8U521kIeX6dvfzO1G/97MHvSjjuu8VFZ1wUkaPRhA?=
 =?us-ascii?Q?n3UqNBvSN498L46AfY1bpgDhmde1y51Hlq82xKSy1EXyJgpZ4htmOulzZFDk?=
 =?us-ascii?Q?BVFTZQYdLDhf4ErMuEonpHqGGPcSTIWRSJzutkvY6gW0szf4UXj46AM/MmVw?=
 =?us-ascii?Q?HVgkhPyuo5Eb1C/K/F4t0vUvElyR+GzT/C+7YQI+6owEcE02NWGlsihGwk6k?=
 =?us-ascii?Q?3W3uaU7kGfcVHey0afKTkoRGXNnYDZDbcjncS5bMn6nPL1XVQcNBIGSluAKZ?=
 =?us-ascii?Q?EqqviNAIbMZJZoDdIE2849DJ+CaEuK03vI4QvowPBKee+Pkha9Jk4AHwwmLg?=
 =?us-ascii?Q?F0o7EgNOUEypAR0iLTByJpwfFjGt1UXByEfxY7Fy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61891014-ca92-44a5-0e3c-08dd8c95b409
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:01:15.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDd7OUouDMi9BG238YKz2TwCPzkFWiEJq/fmFJmLMQiIS3easKppczBbXXp3TDoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

On Tue, May 06, 2025 at 02:45:00PM +0530, Vasant Hegde wrote:
> > +/**
> > + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> > + * @size: sizeof(struct iommu_vqueue_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: Virtual IOMMU ID to associate the virtual queue with
> > + * @type: One of enum iommu_vqueue_type
> > + * @index: The logical index to the virtual queue per virtual IOMMU, for a multi
> > + *         queue model
> > + * @out_vqueue_id: The ID of the new virtual queue
> > + * @addr: Base address of the queue memory in the guest physical address space
> > + * @length: Length of the queue memory in the guest physical address space
> > + *
> > + * Allocate a virtual queue object for a vIOMMU-specific HW-acceleration feature
> > + * that allows HW to access a guest queue memory described by @addr and @length.
> > + * It's suggested for VMM to back the queue memory using a single huge page with
> > + * a proper alignment for its contiguity in the host physical address space. The
> > + * call will fail, if the queue memory is not contiguous in the physical address
> > + * space. Upon success, its underlying physical pages will be pinned to prevent
> > + * VMM from unmapping them in the IOAS, until the virtual queue gets destroyed.
> > + *
> > + * A vIOMMU can allocate multiple queues, but it must use a different @index to
> > + * separate each allocation, e.g. VCMDQ0, VCMDQ1, ...
> 
> This will handle multiple queues. But AMD vIOMMU needs to comunicate certain
> control bit setting which is not related to buffers like "Completion wait
> interrupt".
> 
> How do we handle that? extend iommu_queue_alloc() or have different interface?

Do you need a modify queue operation?

Jason

