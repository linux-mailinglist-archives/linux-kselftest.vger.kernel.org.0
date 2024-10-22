Return-Path: <linux-kselftest+bounces-20393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DC9AA2D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586C2B20FF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F05819C57F;
	Tue, 22 Oct 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hce/NIw2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26E19ABD5;
	Tue, 22 Oct 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602962; cv=fail; b=VRJfJj6zO69t8vasMDnfNlKjNXsKEcc/jAdnvVCRcQX6QYTSca35lnImCZbE6CSDVjmMBTHCzg/r2Mli3HQUryfnim0JfrmruyHjd2bz09UQWVzauHAA5TnyCxQj07bpA7gcwq6xdzemZDeHBo4s9SkgcuuXT1wUi5w8CZO+cMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602962; c=relaxed/simple;
	bh=TXSJsSHABIoSA0C7xl21/kF8PGV67rbI9LpSL6Wrk0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KR6shtIEIpcfva9Gm9ki6Gs6KhHQ5yKQIQX4drRDZkrie3IGEO+XBaSbg/25NtlVRq4cqcsvZJux54yPtJJbtgy+TDVbuApu3JIULt4Kz09vLvvz1mfTMzEWFHTEw1D2myJeadTHvfXQigoJRJZnbEvUV3pQslBR33UBIaApOQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hce/NIw2; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXcdSwqF13ZyrJaaSA4TQD9Q+gYW+uNglDi6T3jmHlUgUN0Tz2hswJbwzc4NJLvvYK3EPtoN46We4OXMvmBBOGJIQREUFUaiXXGxNLFSy+ceWDX98C9/3jIJcwYitYy3KFpA+kxe89th3a5hKoP9VKlREwM3FvV5gxtG8gYMZkna9Hkc4LvDLDJndjdw4N82muaN2EyR46PRPShRcmODG4UTqS8eXuJYp+64dNSlmigshdSpcT6MDbK/3W5YNLbS1CTk2gTeYxlXc82zi9e/pkEkHAyJt2VzOqChTWiTAt5Mo2M9//HxVx//BaO/xq+mJ9Nk4MXOS6w054j6AloZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=podhBmBDmPgVq3Tah38raSopHfLRR3QOkuM3ACGrfpc=;
 b=LD9Uu5+XJgARfgDgkW5tCxuDg+5WV82yorMjj0bDlIomvgnuZVLU7Q8Ga9ZH8Gus6siwKuLNMZVLyc0g3Ld66KDTssCjGzD3OqMary+0jIo4L0HALPhmZPubysh6gCc/Buw//XevLbv5MPpCzQ3/7wHSnZUcckqHVndMaPl/WL+UxHnDs0OdOY9R/wOqe5DxoBJxGgtzgeHiwCyD0Roh/7Adnr5v5iu2UeqKa1bSvsmYSCx2HrXrDL7l7Gk0wt0P/88LtiDmYp2tZCXUCeN3f6PKhLpZBog10mE7ivPPEp7Gg4BiQiBvzqwbRlrYnpYj6UdvFBUUbSjMQBp01v7Sjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=podhBmBDmPgVq3Tah38raSopHfLRR3QOkuM3ACGrfpc=;
 b=Hce/NIw2Jiqh7/OIOD5nsOsJa4+e64hhmNYRCr3Drsvm/hdfbrDq/QnEyCTliBj2V5hK9hN9xQKONJxJaWF7YVKNNVG8bVRED3q4mq33s+OPg5gisQF6eQgBpYPvkQwc4LZ4sLFlLHob0tcS/VP+SKmdWC9BDivfIFS59NmLfAQYBNEHtGVvwgl/Wpb3P09u1vgXxNxedwhYWO82hbUeZ6cAkl1qNRB5PJMZvbwYyI5KJTW7Fxq2T+IwaxwdUPLItPP1fP9Oc1b9utzDkTdzkwekAH3Kh04eBLhDWyyhljlL+LvXdzjUEy0amSdJlY2lcWKrogjCGj7uhYhmoaK9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 13:15:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:15:55 +0000
Date: Tue, 22 Oct 2024 10:15:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <20241022131554.GF13034@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
 <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
 <ZxcspVGPBmABjUPu@nvidia.com>
 <dd7eb37f-13c6-4c6e-8adc-954ad9974b93@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7eb37f-13c6-4c6e-8adc-954ad9974b93@linux.intel.com>
X-ClientProxiedBy: BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: c909a6e0-41a9-4a06-0ab6-08dcf29ba925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4vIHBzKttB/XdUplVQSfTqtmOR2p13rJSiLKpvg7qA4l0058vIPmTdzfMvb?=
 =?us-ascii?Q?KrtLlOWjWaHnblQKNr6gupe/uCD+NWmEj6R72xipCh9WNTa4PTRtHwGRB9zA?=
 =?us-ascii?Q?d1pcqHl0F2wrWLTmOo3T+CyykY7FXpdhn4KL41sXiuR9UlgdOaOckgpMw3Me?=
 =?us-ascii?Q?JQRLbMVT/FJ3cx+GNZTstPIDirANc1V91g9T9aBOc+tG91NAvxhDbBC5T4fl?=
 =?us-ascii?Q?P9B+R4aL6kRmQtQluAvcL7pZBmekOQbA24PtMxxmWov88HenFWEFwSUvXdDD?=
 =?us-ascii?Q?wDKKQYow5VuoQJ9TRp48UKDGc+pZn2F+1Jvm9OyNix00pqpp1xv2e7+V7uL5?=
 =?us-ascii?Q?bUXgfCVVc+ah5/PtXa1ZyYAGZtWFxZpa+aJuQJaWYHNXQeCP84g9paUqTKvF?=
 =?us-ascii?Q?x3cMlbpJuLNpGMjmDr05ln8ICoPqyCO3sPdVLcZud4ihUSM1ta+vHJ8q8RTD?=
 =?us-ascii?Q?rTfskqwTgBRzQx7Kfr3Hqi9unKiTDwLDa4W8Cw9Q89fS+l+INvkCZd6iJ+6L?=
 =?us-ascii?Q?NbWbHg9qUxUNv9tmp53+iP7/FSu12v2+JklGdx44QA01/pwtVo2VOTSS3QXa?=
 =?us-ascii?Q?qwHiFmohZl6OAkpsegUs1AXKIOPibAzpf/qFR9QanLh7TrRI6Mj7/RW5vXkA?=
 =?us-ascii?Q?NbZsKyLkuIIZ5FOcJ1GwwQK/kGAK/3avL1bwHmv603PODHUbqlE8Lg4cknZ8?=
 =?us-ascii?Q?iKBb36d66VTVXmN4Qld4lYZQAEtOZTgI+NqqCUFZrf0ee43tx4Xsx8Te4Ta6?=
 =?us-ascii?Q?uI663rjEWLV3zY7sBfZXdGTA4SRu1KwKznHizqt8khzw3n+w3QE5X9GJUSI9?=
 =?us-ascii?Q?YaKW85VquCAVX6lUNH8Ls1F7/LLeTTh5oFiJonnHT6xNDveOY+CxRRWDIi60?=
 =?us-ascii?Q?o7+VFjnW9jNxpvsK6c7V9ze4xUJhimAtOxtcd4Ujrbe+UJRwa/gTQL2sdTCI?=
 =?us-ascii?Q?8TwOOLKn5agvD8VsQdN2FgrXbZc1Q+WV9zPX3wKvEVKds/EULFVU4Fh+CBps?=
 =?us-ascii?Q?WXen/r+m85BmPZGXhGtn3n0r6j6QyE88shH3dNWTqdhS4wcEm09OGa9OYe4Y?=
 =?us-ascii?Q?msXt8NhYuPDvIV8TlJugm2jIpuYrw1OhC4tjNGXf11zbvQUxynP5J3aXu8QV?=
 =?us-ascii?Q?pxCG96uP96CvR6+AbVaIR99i1S4+STVWSEffciOgREfVFjDtg3XKDe9Jcl72?=
 =?us-ascii?Q?5AjkCcd44pHuEGdG0ceHm2beHvPNpyi3GdGYjqYwRnVDBtsiXIErRd+ZgVSt?=
 =?us-ascii?Q?LK9gXrXWgKSsU8WJ169+BzAAhPvPZYL0PV5KvBntXRLbhCBLUG3nSiOn8bk7?=
 =?us-ascii?Q?s7Wq+eyvGh/73JinRtekHkuh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRTRJrcHjIopdtr0ePWGXxEj1BSNOIVqEGugozTemJdDNRC+K/pRHHu1K8u7?=
 =?us-ascii?Q?bPEKvIBBiAgUkd/9mL1zFDKJ+650IUJFUgWAH540Ne0cypXKMYnVi+YUB0yD?=
 =?us-ascii?Q?mn60NO5CmVCS2ciqMzCLvmzoJTKIiUkXcToz3WuvZx3402y7FerSN9K7+DTv?=
 =?us-ascii?Q?TMcrx3quDw1YFb+UUz9+13npa/uZ3f4vBvGZw3wT+esI9wOX04pAdzsQGxzL?=
 =?us-ascii?Q?g9UJmrEnmozy7+PerFa9PVvB0LYgV2FiZWEs3QRVmxENQfYn33Dwx7kNxXZz?=
 =?us-ascii?Q?uKQ2XCEmEHvWXjOfI5dEsu5BJllTOFyfid542wt6S1lcMtwcY938nem8BfGD?=
 =?us-ascii?Q?0e+W+281jGx8a22ojhaKkwjaN0kM96o31EbmpJwIqV6UiK94YTgzwkVtn5Q1?=
 =?us-ascii?Q?0cEI5VsxlKlke/r5aINa0W+o/nAqPgpghXy6ipKxhKV7xZFY4TS7w7iqayhm?=
 =?us-ascii?Q?cUotZDovcP6QuhOy22zeRN/4dkOVwWLdUsjQQ21o2S9/5Iwpl4YmnAlJv4PG?=
 =?us-ascii?Q?OxQYh34RlDEIxl9N0kQuO0fOXSJ/AQvqTPEJFZCZ33TZZFJHGtzNclZOAFku?=
 =?us-ascii?Q?jJ5MsVu1Wt+72pKDPx3T02d1QjTmhzFQjlPbeQqPaCQQ8wvlSGbbol+Yq0pp?=
 =?us-ascii?Q?HUdL/XSZXT3DBoY+5c8DcyGqHF9BnU8dD19nq5Q3AMtgKQRG4FnD9nPdn0KE?=
 =?us-ascii?Q?5JyBLtq+W3nxAUYpwO3cgFvN84NgJz/1i7BslSwtVXwIZkfI2mFAUnALpYXz?=
 =?us-ascii?Q?B2jd0RaOgLyqWFxdQw0aROAD83rbFN/RNXSBEwbzEE1CCGuvKf8CI68UAas0?=
 =?us-ascii?Q?c2lu5317CSFoBJJhx96vQeqmLVtqVf8mY2B0vXnuxbHSX51vxkR40rMXcCBt?=
 =?us-ascii?Q?Ymw2gnNJ1p9e6fxytAAOfZoPx70s1WCCvjmvFXbUejk/T5UQoapfDAQAKBZA?=
 =?us-ascii?Q?jAMmMcpka8ZZL0K7OHjwAgBPgWdxGot87QTVj7gJCkqP9AjNvRP5bYMDObCT?=
 =?us-ascii?Q?cN2NRClSsKfOIQPT+XVpjAK6OB0k83Rp9GJiCNH08OVW8pG5GYfRlNYhTk/n?=
 =?us-ascii?Q?MgTqYmUnjTQhpXHAc9G4gDTKmYBUcDXmXRqRlzqoBW1TkSJUsYQJiTz4UY+F?=
 =?us-ascii?Q?RJQnUE4N8bIPU12dMi4Xko3JG/zBeIYFQD/3/o5dos130Bi6rvlvge5vkdQk?=
 =?us-ascii?Q?4/PhrARExTVz39aW/Uq7xqpAxQ/39h56UtRJqciW/t9yiqjIbyC7gokDnDr0?=
 =?us-ascii?Q?Uq3xt5peyRH9pJRK7XCJmADoQImJGKtbXGvqI0roT8Q7vfgbLcVosAin+Idn?=
 =?us-ascii?Q?VgtyDMAhdCi+05RJ94QdR9+PVAlMGInRicQg4WjRIScjnnYiFkB0AtdLRDP5?=
 =?us-ascii?Q?Nz1xePK/sGM4SHc7ZnL/JrwyqIb5706+xh6jeWB+naWOd5TGfR/u0SkYY4ss?=
 =?us-ascii?Q?k83IXVJyDaa9CH3gqpvjtRivvEJKSXHa2Knj64pB917L0qlaoJgBeDfBDGUh?=
 =?us-ascii?Q?RfKgiluEhIYrW25AxUmnk9fZ5/hf8/0Q3vLASCtiMZlANuUULASlJV4LHGdg?=
 =?us-ascii?Q?OJVTyzg3y+8MQOeNydGInoj562Tv+Ditliz+jLf2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c909a6e0-41a9-4a06-0ab6-08dcf29ba925
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:15:55.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF9nvvgWIUwHGJe3+woUzxmkyK2bFDAcbtSPMkjXw19VHg96zHCyYHaWc9ddmsve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664

On Tue, Oct 22, 2024 at 04:59:07PM +0800, Baolu Lu wrote:

> Is it feasible to make vIOMMU object more generic, rather than strictly
> tying it to nested translation? For example, a normal paging domain that
> translates gPAs to hPAs could also have a vIOMMU object associated with
> it.
> 
> While we can only support vIOMMU object allocation uAPI for S2 paging
> domains in the context of this series, we could consider leaving the
> option open to associate a vIOMMU object with other normal paging
> domains that are not a nested parent?

Why? The nested parent flavour of the domain is basically free to
create, what reason would be to not do that?

If the HW doesn't support it, then does the HW really need/support a
VIOMMU?

I suppose it could be made up to the driver, but for now I think we
should leave it as is in the core code requiring it until we have a
reason to relax it.

Jason

