Return-Path: <linux-kselftest+bounces-32901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D675BAB5436
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 14:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E37716E6DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761123F424;
	Tue, 13 May 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+1VWjy8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541C18A6A9;
	Tue, 13 May 2025 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137626; cv=fail; b=aFLyI2j4WxpjtPPoe47teSHP9/o9/ycMWgjIiydJOa30++yPLCM1C5om0boqfWkmUa4iw8EQTvZJMCWW78zBxrJzALcVk5cY049KinSaJK1FwcpQja39PMVyXQMPmmQnGGhg/+OHI1aOXosGo/oTUjZDv28th9OTIG5vom+lrdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137626; c=relaxed/simple;
	bh=SKyegXloEMotXSmLWKtKCB7B+y8FHSw1JxlXc/aG6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eV9dba62sTnJHT9LB1KbuGjthnNqgb1OUK8j6bdBW/YUd8UrcaeFEEOqgnL0QgghNvxGHiN6BZnCq+RbAzwjOsQ97QXSDAM7WU4eCO7mdmXOemaWg/99XFLAPKQGaO0whoAGpdqGcE2RPsO+i1IUS72yLeTmJNKLQellNkKIXkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+1VWjy8; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLfaCmRxL3Jd3HYKu34Sk/Wox2j/tlEIOYFDVAPetupI8qHBcL4byz9Uo2R1db4ckjSqiu9yzUMjbDh4a9CkIu0n/Bvxc4jd8Xc5WhesZpxKJznoHi6IYAy0bZzICZD5L9au2DfEGaUZTgwxuFjyG0BmxDRvCcsGTGk/nQY27pydLUMsQPbCjQjqlQ0sYuHDHjmsvZZuPqwYG9QJ2VB2i4TdO/7Prf71NpqEW9R3tQb1oodf+cmgD7LCO2kbD4P+UqrzMledTRbkH0SHMOH9C+s1jluqvy8LgjvFEo5Q9+ZNI18vzAIIbXc5FrdNtrCsjtCecvZk15452nKEFpoNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxCjoOVq2mCB2SptGpTkY3uiG2xA9hjH8MiiynpKrWU=;
 b=S6wLf0N+c+dS200qOwMKIX55EgHyx47ntWvxf5p8NtO0nC/4YboUL6p0qtUuCKea8VLzXqUMu+hoeD4NGR6+VbA38oT6imd8jmkn9XJX/OCJ6e9LR2oQuFzFgMifAbFZc4fe9jvzlXnnH8SFq4fgyBH1TucEsgsbQMAbjGL8TmjPXYYtsURaLCg6tJ5OVcDhbfIt3/9HjARc+p11htrif6gFog0zr5ZasFPiqY1YG4ToMl/HhBfpiVLVyq+Q7OGKPsfJ2ot5LPrWWOuc6Pyt0XLJoab0S6Fr9GyJP7OhZQvth40kVx5iOnfoKV/2x8zWbW+DC71BXV/0HeGBQENMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxCjoOVq2mCB2SptGpTkY3uiG2xA9hjH8MiiynpKrWU=;
 b=p+1VWjy8vjtaB3xBuqRTgKDCfY6b51zERmsGSyzqO3LEGR4LSkdY+errAGCu8uUyJ5gljtCssg/gOEKhwwb4+keTjf51W0iyUV5SdkJ9Fuyx57OZqJHuh0ZeXztK/6aZW0P2YT2Jeo2VG2H1MPkV4DM3xRMbtuhW50XMUftexvKdMG63qsdN4cpSH6HfSPtcpuyxF9EzABW0LvHFI4c/3u3nASHjGbOwcTkKe6onCkeisOba9FvE/sqTWRddpSB3+mLjZVVwTKCfcL452seJ36tvHK4Nr0QxHRyxd+G1C50IPZCXNzIWMJJRRtnaFHNIj840t97ZM8AsULCZCUcJmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 13 May
 2025 12:00:19 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 12:00:19 +0000
Date: Tue, 13 May 2025 09:00:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Soni <Ankit.Soni@amd.com>
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
Subject: Re: [PATCH v2 07/15] iommupt: Add map_pages op
Message-ID: <20250513120017.GC286987@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <7-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <br26mvt7nlq6gpgkzomargxegaxsdelnwjn7rhhh3n5u3vd46e@l5cokjjdjx6a>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <br26mvt7nlq6gpgkzomargxegaxsdelnwjn7rhhh3n5u3vd46e@l5cokjjdjx6a>
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b100a5-60d3-4d4a-11f8-08dd9215bafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GYdHCMWhAoD5WE0zsHawOMwfhFKecf+Qbw7e47fZOUJaD857qPaqlzoBLWAy?=
 =?us-ascii?Q?/+U9vD4T4LZ7MVCVZTQLC6WtGqI9Lm+66ks+ebGz9Ufz0OBZT/X036y/CDXg?=
 =?us-ascii?Q?Ymdw7KpLihqLnJgh3e3IdeXgLjC26m3YY0JGDcf9LZbGBO9eua7z5g9X4tCt?=
 =?us-ascii?Q?cOjZoNwUJyyNB/2AQsQXKbI1FFpsuKM0Sd89BIIZJJyeLHh/3wb/rHFuZ+4g?=
 =?us-ascii?Q?h8GlkXEQfBMYAENajG6rrkv2BegBGs7vv/bNDR3/IgEMrxc0XfyHPeHo/6q/?=
 =?us-ascii?Q?uNEq3pu0+G2kn6Pe1X60r3T+M2JXjnwiFKjcfIPHKNWbUFCSyHrQFN5xujka?=
 =?us-ascii?Q?c+xkNer+Bc2dAgnbk5oUUSVnPxOBdgzvKRo90gZOVGJBSB6a70saNqXrXtoP?=
 =?us-ascii?Q?2EwZJl8X1yHUA4W/F1bnXkVaOsfpdmZPeg1lXJUa2AtyJEfH7i/kGdCOTGK2?=
 =?us-ascii?Q?6ecg0M3S+HYv8up4DRaLN4aXjoFsmR4tA3ph1NIeNFAH5O0/9Ov7q4FTMXmd?=
 =?us-ascii?Q?3fIGXA5/67KR6HLQU4KWpwmL0Sqq4iQRibnfTVBwuPac0g6TLdDHifI85jZ7?=
 =?us-ascii?Q?6t8N3rR+6kZtnmGXFd+ZGlR4XCg5EL547lGT8KKSFfeypu066L6QxZFePmzS?=
 =?us-ascii?Q?XidYXcPgib/wviBh5A2b4Dlnp7Lnxse9z4chnWhaopo5O+dGrOsNrJYR9d0r?=
 =?us-ascii?Q?y4+ABA/gRlGFW6XlXSZnxa4VYMxbf8WTwtWIRRjDBkxpRyQyZnk1hxQsjxe/?=
 =?us-ascii?Q?Am2GnQDou7wwSocTkUBQmMnmHbN6QkRZtLkCIFNBzHeIqSZwpNaoevD3H4bx?=
 =?us-ascii?Q?OPs+z6atM9/I34CW114YAnouJ51sEMOkLD/VH0qF5wdFQt876L488uFCTZo+?=
 =?us-ascii?Q?01XJyQSgBBsbFGpSoXNm3i1SNZF1EHrU7j3CiDDO4mhqa6rn2pKZIIpEtygs?=
 =?us-ascii?Q?HTPHbaG9genOoXyHIeMjd3T8wtopBi5MfJEuQhUtDK+rGwsqeSRvnuVfCp5c?=
 =?us-ascii?Q?kxs5lKE1KrFi2B1TgBRZcFqhbR4T3QsxXzMgoC4Juv04BtEXykl6QVEgZkJH?=
 =?us-ascii?Q?n6Gwl9STlzjZr+8TastUU52fMi9trV9Y/5RrYuMHtS0j93rnlCo2xfRC+UJb?=
 =?us-ascii?Q?63MeYh7gzp1OA5NmmdRFN3WaqFfyrTQAa60n5yUxNJqIGTQiBuIHcz4lUzES?=
 =?us-ascii?Q?ULOpPoYUrlP6/Nma1dhIShW91OXlm0nJcYyKnruHi6jYEL7Z/g0uTCyOnBsN?=
 =?us-ascii?Q?zCq6oQxb1PjhFwp3uQ9L6FFsMG5I5XE08ZJgslIOsJ+zOgVXsBVf8qygLovi?=
 =?us-ascii?Q?7gTpSEB68SfEPvwE5tz70E08zjPz4wOcdKCGfa4XkZpAVjJsPMwcdtP8rgKy?=
 =?us-ascii?Q?zoDmQdY8eViPiGvCLhoV2WtF7Ms/TNy2A93WtEMLf0GOSeJHZEEw8EGSH0uf?=
 =?us-ascii?Q?xaKA+b0TCe0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYMmKZUcZWelkoRnu/j39nIQKZzhmjauP1TTJqLk+fXXZuJiJl+d2ClkY8Ei?=
 =?us-ascii?Q?HGTdRRywsgwWvMNnGg1pKc1FgwqKv/rvPHI0W3zyg+LYpjs+uLuK71rzotk/?=
 =?us-ascii?Q?BrZaqm9Ks+R47GAZXznLPBvBb/EcnoXb5Vpw2/jsnzklOtN5XSF2KBsewVOI?=
 =?us-ascii?Q?qafHCP1jonS3vbJYmbX9+KwuwfOc/tL2MEhLUW9Yah5kLd6TE5i+VjXpJ7rT?=
 =?us-ascii?Q?bRsn054sXnYK61nnUxfLkyIx3eGVuV5lcMl2Omq5IgScp5XAdGoH5EW1xwFd?=
 =?us-ascii?Q?WciSskH8AkIWpDeRwGPimthbKvPaAzK3kBoaGTphxgztAbobsB9N/bX9n5Uc?=
 =?us-ascii?Q?kRUO1ECOYylBSkmTtbu62KEUkxdArKWyB46gCxX6qLUzUP80i9c4GEKRlgqt?=
 =?us-ascii?Q?bAooxU5rvJwmydvSDNDxovuqmTPA00n0cvRlTSzPXUOu1M3aviaFw08ShhkJ?=
 =?us-ascii?Q?sn9OYKTDgOAFdiV2/JPAll5jzXWpaetFblbPwXVtoEhGlfMCAwF2G0ljZU1j?=
 =?us-ascii?Q?H9jIhWsFKO3du0R6N92lGMYQWOmtrF7HlCbZVmrayUTKnDwXsQ+RN5ggRLTE?=
 =?us-ascii?Q?UEfuQoCXE9UuSsMYUv4tIj1jHQYuWjSxggCaReZ4COwIdrDTaOF5NXXWtVES?=
 =?us-ascii?Q?BrwCQmidI23Pd77ZS3GwEcfsquooOwOSiDQ8RYZi9x7119YT1QqJbMjOJy5o?=
 =?us-ascii?Q?Cs+oYed9jKIzzK4XOvOvLJszmwpc8mlHKkmrxsAqlSr3wlNN3w4nKXWLx6T/?=
 =?us-ascii?Q?18zQaAmYJQIEKIjkn6ZMIxzn2i2Mmhj2zh84g7g2PQp3gZLQcc7Zu9X2bwAp?=
 =?us-ascii?Q?Sc0cHHuTt6iXnAu/27NcbEOpluRuqI2k49XZ2W3idY1sRg5P78VLqoss0I/1?=
 =?us-ascii?Q?XBJV8m6epi13DTS6BtjYY4PkQOQpSCpRYRvNp8wllb808jtVgnl2/ZmxvZV5?=
 =?us-ascii?Q?jck0tAmUJ26HRbvH0rcyfFuAw8sMAsYDFmzMe5NU0BmxrTUc9QdA+SqM4SlO?=
 =?us-ascii?Q?b9Qe+tIEp3AJdDllb4r+o3pyvD39R+gJ42G/IOX5+rULXiVisA36Zqpio6Ir?=
 =?us-ascii?Q?507zyfSNZlubL63ZEv9W7qXKhQd+nby3fB65demfNwszW2ldoi33qkOgzBYD?=
 =?us-ascii?Q?yHoNVbF6Y7bBYozd3lSNbNs3Y9p89P3BIGBYjvomT6fLlsUX2sIkMFx1WqvV?=
 =?us-ascii?Q?zVVG7I4GR1gf/2gX9U2RKTH2+vOhI7Vt2rr5xDpkcH8PWikgl/+HPpPfs7sR?=
 =?us-ascii?Q?WtpZEykI8UZsm5AqdR13fOh9O4ZCLlunOLrctFy8BJ6CEaYLirYAMVSISR9E?=
 =?us-ascii?Q?tEGF8XF6c2UDumpvENKemKFcOsAo4ESQAwCrrpyAssUZd0UJkFa77ZLBE4ii?=
 =?us-ascii?Q?Nn/fBoMjkHARRW1C7GLECdVL3n+We4Nyj9HtRRmACFeX411DOgvkbHDywxKy?=
 =?us-ascii?Q?ZcETL4nyipOdoP9faMgf911TE0o2btz2x+r8KlMXCqmDWqXTBA8zWUhVKsLV?=
 =?us-ascii?Q?CVVpHdaDYK9snJbPdxKKKX6yvfrRYEEbOZDscMPlGMv287ZD59et6LAVRdzL?=
 =?us-ascii?Q?i6E3E5EcoMoIIsnwFn8B+sF2ad/shJj5RDT45uxb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b100a5-60d3-4d4a-11f8-08dd9215bafd
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 12:00:19.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8TP8POvpRCh+guwV358oAznnsLgH9e9biGDBVrwA1C2mgOexl6pgjo5qNyzOqfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On Tue, May 13, 2025 at 05:15:50AM +0000, Ankit Soni wrote:
> > +static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
> > +			struct pt_iommu_map_args *map)
> > +{
> > +	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
> > +	struct pt_common *common = common_from_iommu(iommu_table);
> > +	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
> > +	uintptr_t new_top_of_table = top_of_table;
> > +	struct pt_table_p *table_mem;
> > +	unsigned int new_level;
> > +	spinlock_t *domain_lock;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	while (true) {
> > +		struct pt_range top_range =
> > +			_pt_top_range(common, new_top_of_table);
> > +		struct pt_state pts = pt_init_top(&top_range);
> > +
> > +		top_range.va = range->va;
> > +		top_range.last_va = range->last_va;
> > +
> > +		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
> > +			break;
> > +
> > +		pts.level++;
> > +		if (pts.level > PT_MAX_TOP_LEVEL ||
> > +		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
> > +			ret = -ERANGE;
> > +			goto err_free;
> > +		}
> > +
> > +		new_level = pts.level;
> > +		table_mem = table_alloc_top(
> > +			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
> > +		if (IS_ERR(table_mem))
> > +			return PTR_ERR(table_mem);
> 
> For subsequent calls for while, it should necessitate invoking goto, correct?

I don't understand this remark?

There are two loops here, no goto. The loop above is generating all
the required page table levels to reach the required level. Think of
them as being built in a linked list, but not installed into the main
table.

> > +	domain_lock = iommu_table->hw_flush_ops->get_top_lock(iommu_table);
> > +	spin_lock_irqsave(domain_lock, flags);
> > +	if (common->top_of_table != top_of_table) {
> > +		spin_unlock_irqrestore(domain_lock, flags);
> > +		ret = -EAGAIN;
> > +		goto err_free;
> > +	}

The second loop is here, where -EAGAIN makes the caller run the whole
function again.

Jason

