Return-Path: <linux-kselftest+bounces-20033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB89A2D5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15E71F286B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD62204D8;
	Thu, 17 Oct 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZKG9lPnj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FE21D2BC;
	Thu, 17 Oct 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192141; cv=fail; b=B94ByPJ5aerCGze1prP1fXnceYa1nVWuM72N/t0sfAvq1Kjvl+Eq/eH58rELq9Nfp8oiYN53fLE1gRwn5HjHG6Jjmdif+eydyKCGZap5bbys4hxAgese0RqRzRpEwdPNjHC4PSZHxp/KLajFrj+ONBtaIVDeJ+/wVV3bJul9Mhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192141; c=relaxed/simple;
	bh=yKYKwcP4MMflXjMBVa9/8muT3vFnLbgLG2IihGr0C6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pe4akGWdx+bWtXe8hL+CvEtZysu20tCIObW52J7JNLoMki3vHZxOARe1jvx+P6a+DAzCg0hKLNZOE5IZaxyPS0X1kJJQv96xETZorW4s7rsNHBgQ1ys8H0OpvIVQfKfPTEZ3HRC5ktxemPpoF4PxYnbDNWRh/KpllnuFPd/s94M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZKG9lPnj; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnyYotcd8ocgCz3AJ6ys01I0E83AFlDi5SovhT6gYZgQx59harSXPeOeyqMB3z9N3vAoKsI6J78qnk8egy887beH7LtruQkaXgtyp9hAlLvDbZnzuHyzKkOof0GOVy76bVFgLNbAsjCso4ieQOvu38swGv2LZf3Zwik84fA4OKdyhiEUvNdPZhpIMmzPG9OUvIwDAATEf+6530dlJc6eqQ4GIwdhn129PNlac1tlmBHHHTcMbERp5yiWFlOMpgdqMjc6/0qhLdDvluNi3QZ3pRuVsy5HQ27Kesz/TgeBCKvVm63MqBBstSryZToFsUPANhM7/qsBAgdVBUlBIYyXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psb+D3Mwb8teVPoRWHL8j9lNPeMKCTw8ZUIQ6pbl8Qs=;
 b=Z3FiBOvDHgDAORqPBJa593qSGV8Zbo8LWUVJu0Rynlma9xDUW1fvmhzMvpVdryj1BesNNgv9zd8N4wHiZ0oJA8yOpwN+CPRZAqsQuG3wejd4Xq9+4f5H+iwhKhuBXqW6qPoRlNFQMX4lNWTgTz1nKqy4Icw1jC6fGRh8jKHTO0wNU5L57ZCDEVRRPUs6kapoatVo9gEwRToh+EBMPGRAuBNupNyZ2sIzRla5CSCoAXSYEoobtjsThO6/r/Cdzj4VN21cCwbg6QraQr2CZlgt0HVtm7bk86UbL90Sq1ZseJPoqvehqL4IycP0NV9lpQZqnM/PmiUwBTM8KnGoj2Px7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psb+D3Mwb8teVPoRWHL8j9lNPeMKCTw8ZUIQ6pbl8Qs=;
 b=ZKG9lPnjTt07ICsID0WvkYV7tJplMhnKcucjh5iw+/xVqsQ3AO6io9AXXWfc0os1Ja/D4+yYoZwGDrdj2EOe7HYI7N43P61+NwTOQrT4DQei6L2fZIUrhK9tFj3BjeFEITP3/8PorWk4OrhMRLvCJ8+beCwfUxJgl/tX4zY/YCRhmQD3c18ktNYFYC0ZmfNmowoXHW4vIAssXHC0PfImHfawGpSM1RT9jNabI7PcjLxJxwmwNiftY3aCK8oSnqAYE7DXJqZv9cTnlfl7zC635im221Q0PtdfERfAUcXJKAL0qWbPLP/IXbwaVBe1LT77DHzxHFeaXBIQd9+RnC3WXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 19:08:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:08:50 +0000
Date: Thu, 17 Oct 2024 16:08:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 07/16] iommufd: Allow hwpt_id to carry viommu_id for
 IOMMU_HWPT_INVALIDATE
Message-ID: <20241017190849.GV3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <75cde75987bf4a73ec34335e1c13efda93791989.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75cde75987bf4a73ec34335e1c13efda93791989.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:408:142::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8660ac6a-2e3c-4ed3-1b65-08dceedf228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dGWgswy2OABp9V2pORlLvtBTwPUz1st3vx1KUbILL2XZHQPw2kf55dzs5OHh?=
 =?us-ascii?Q?Buljyt0Orpbs5h+oCwKT5CfSAWrjsEdmT6E6M3Wmz+aEHKKW8ix6b2KopTrO?=
 =?us-ascii?Q?gopfwN+Mf0kZM4Cod+algfUyJ0iJYP/QcUY4iP73A3AMH+zuowIK9nZ7xmbo?=
 =?us-ascii?Q?Q+VoagZrVVbWaSKh/TDxOxIh3H8dkCy1h+pXCDyz4MjuftrfdPjh3kFwUVvc?=
 =?us-ascii?Q?AC5rdLS948r6omFGES/BYdI09BRh3+Y0su9M2Abw5cTkZ0GP/3IMGU6WK03K?=
 =?us-ascii?Q?ffahQq2owC9m5pcAyCszIQprRRusT2++A9rbCjNANv+axwUivL8WRRRTsXVy?=
 =?us-ascii?Q?Y3lWzVSBJ6uxTn8sp2auCPmfTNnnzYdBNk6Yk4cKZabwjRCD+fA31L4VTdIf?=
 =?us-ascii?Q?dMhyfEoS+l6RoAWt/QbExPXEJdXolb1gng/HBNsUNi0Pvr058s2veGQaI79p?=
 =?us-ascii?Q?Nec3zS7haHeHEgzMUfm99xIuERv+TsBWwJtMeoQJ2Da6lDsWwoBKGEDTX07i?=
 =?us-ascii?Q?2op5vSJBklnj+Gc10UrYWz74guXghbd5gqYcwC14iwsEZhfdSUASLPxEoYZc?=
 =?us-ascii?Q?wKtHhwQ8OspEbksb/QZoz3Ik5bb6ZJQylNgRPjDqj7Zi69RI/sdPRTmnpGs+?=
 =?us-ascii?Q?w+8fOAfa0+AZSn2qrxsk1wdmxoM8Af8kTXHBU/gDfnGcGOlmNYvoyh0Mnb0T?=
 =?us-ascii?Q?uoi1neMkSFk6LtNvT6GRGODse9S2cthfCeXylto1f13x4YcguGvYVPxZl1lK?=
 =?us-ascii?Q?QYrmgqJ0xQ++WsnuBaSRvUAte7HjP/dfWYfSCmK+0BjiBNHpdriB3i6vpiB4?=
 =?us-ascii?Q?MGQC5yyG4xF2Ly7zarngVCI1kihKiEOp8zmYgpUR+zk1vbuG8e2iBu0Ykl+r?=
 =?us-ascii?Q?eotp4ohAl70qrW+JQl3v1BcqREnSQ2gN0MHUgnAbJsTTdxgAoM/AKHuCIuqc?=
 =?us-ascii?Q?7twNSVlD78BMhrj5KA8YUp4wZ+BL5Xk2Kb8c1crtX50DrwDs76LrIyepIcAI?=
 =?us-ascii?Q?4XcWekAti2IDwoSrRJ1X+DBy2fwgy10Z8Ukq3oEaSGWfBcDY+Km4E8oi4QZs?=
 =?us-ascii?Q?zuZmdJRNj9/VTfqxiwUJ1b8HMtu0+LPXLY2JXMgTGan9RcLrqI73BdsLYauB?=
 =?us-ascii?Q?0eEDPmDQg4vr9yAy6sFvuUOG3nQ9YFV1NpmRW0ziG69qTxosylAHJoCyqfz4?=
 =?us-ascii?Q?QDGGn0b+lE9JbfkhjxvMKcqKLtVpPGF+kEmWUVHA90mvpgqqrvl+BQRoezVQ?=
 =?us-ascii?Q?bVlC0CFmO5sQph671uS15Uu7csaHYkxEXgaUadTZVN3KwpfuXGR5431bfX3s?=
 =?us-ascii?Q?ccsD/IbsFmyvo27DIEn9m87D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KU0iYn23JLTRkQAZ8cwRI3VTv+RzBT5wQM6ArQebeckmONAS1pRaRV8qgFmr?=
 =?us-ascii?Q?DBL2YqSNp74RKviGmRpUjNQ+Meuzb9wrl5dFh/6qNU/ZnSCr9G4YuDh33/te?=
 =?us-ascii?Q?NzGrH887xs2YwHfyR1kXdWf8EtzFT3r0kWNhFzssDMzbxaTstgu1wwe1g0+A?=
 =?us-ascii?Q?wTFpUhGCVh0CpF4iiyZ4q0t2eVFiBq5bkYmeLT0dJgZBlqDk6QplPTzBRf0A?=
 =?us-ascii?Q?3T/qEHPrnLAwlZSUwnEe5N5gLoMm51hgCg9Zc3aOVigejgHl+m04tFXLn6xN?=
 =?us-ascii?Q?60hDcaMwYe0TEiY8g/eeJgGNEAkhf+hLbzRlTUCyUJUA+YVvjaq/8juPz4jC?=
 =?us-ascii?Q?HEbbd8/xcbNy6FiOGAcBfjXVrnVs+neM4u6DDImn08SuYUIlJOqERbZuyojW?=
 =?us-ascii?Q?HpEBCNgNtnjlKqbF0AQnq2NK3vYNTrQ5cI2bpd2mPqgSIafGlj66Ruaz2oHm?=
 =?us-ascii?Q?DEqeyabWxp14eKy2wqtMuYeOHOg1O6pCbtV2yEsmxbZ9lGCarwXc9TIxKxVW?=
 =?us-ascii?Q?YUlwMp8Sz4V8IUqKaNzLXrQLzP0RX7us0ZER+VcyEZVutrI0NDSSZ5WWAI+a?=
 =?us-ascii?Q?xFd7NP8VJs8xJqgwcTKNs+BFxOfHWCm1m3oGaPBos9KiIswwQyEqJlTBqwCp?=
 =?us-ascii?Q?+VpgyWinGO1JAfn3JCWdtw2zaNaUPs42Bw2DmTDnkpVh3Ph3Mzf3TQnYQfqd?=
 =?us-ascii?Q?RSREJlO9ttLKssKztLZE0gvXom60avMO9rLJAsBUj2s+dAtPwMtFBc7EEs9V?=
 =?us-ascii?Q?bJnXwAc7Xq97mOGw2Vtl9ff1G3rQt43E+42oyUrIIOXLgLOWYywJfXmy+xgP?=
 =?us-ascii?Q?Z5dLUWOr9cZ2vYLTmmWvyEIRX4pOnUSEOurvJuQ79qe8ACdg53p4QhdjrgbB?=
 =?us-ascii?Q?wGYxZr5ncsc4P2PwepWHLoIOseeQXGLM/M0GEzDgK9lZeGw/KAG8P9EU+rQv?=
 =?us-ascii?Q?CVOTA+bUmGwVA3G8g0RThlCwgJ1PiEVNDOjmzWmCA9xcEKNd96JTHg2vFSdm?=
 =?us-ascii?Q?VHoNC9ce5a2U6VFStqu9ecb0BvwkMudpS06aQ0KSV+r29FChiwhArSR29K9F?=
 =?us-ascii?Q?2EMQ4uJNTcI0yXbmg4pwEjqdB5zFBK62EIK6ahcgRj5tuQh7oAK4khvaNCgU?=
 =?us-ascii?Q?Be0bxo7PvbKKL8dWexjuHh5QaIym12KIKu1XtM0BjrTkWRiZVsP0jN5knAg+?=
 =?us-ascii?Q?Nxhqu433LssU8nQW8sZ9vfR9oTLV7ckIOYNERt2axzRUZe8ccu/Jo3ir953f?=
 =?us-ascii?Q?CKDdMAaGWAMiFKe3P360FakF+GyCna+1idoWqRhMQfkyCN52gA1kEe4F4Qef?=
 =?us-ascii?Q?FxL2j+gr23Mvc2cSuf7YNxYGf+8GRqQcbzimuaxiwKDqSvJfP9uWKRoZJ/3h?=
 =?us-ascii?Q?iznWXhwTJLpShPqqHLV+MbhwAFYjJMsc+ah77AOPDeL15mrlUT493MHDWxvU?=
 =?us-ascii?Q?aCfSAYqixvLwvueM24kJZcyY21TkWaK6picvo2ppz3CrJBviJpviFeV4tLyv?=
 =?us-ascii?Q?Tc5yiBpkTrH68w/8aAEeXdYNalB1nhTIl6hswoFTrXNRzZh9T+y9kzuMlK+r?=
 =?us-ascii?Q?Dwun7HjxEsiDni0axpM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8660ac6a-2e3c-4ed3-1b65-08dceedf228d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:08:50.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g7oBiyEzJCua1fkaGxtJb0xJkb4r6M8ov6++atApf6bieh2CFYmZeEBS3gO1VrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

On Wed, Oct 09, 2024 at 09:38:19AM -0700, Nicolin Chen wrote:
> With a vIOMMU object, use space can flush any IOMMU related cache that can
> be directed using the vIOMMU object. It is similar to IOMMU_HWPT_INVALIDATE
> uAPI, but can cover a wider range than IOTLB, e.g. device/desciprtor cache.
> 
> Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id,
> and reuse the IOMMU_HWPT_INVALIDATE uAPI for vIOMMU invalidations. Drivers
> can define different structures for vIOMMU invalidations v.s. HWPT ones.
> 
> Update the uAPI, kdoc, and selftest case accordingly.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h            |  9 ++++---
>  drivers/iommu/iommufd/hw_pagetable.c    | 32 +++++++++++++++++++------
>  tools/testing/selftests/iommu/iommufd.c |  4 ++--
>  3 files changed, 33 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

