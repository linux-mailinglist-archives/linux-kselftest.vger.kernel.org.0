Return-Path: <linux-kselftest+bounces-2610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16CE822D59
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 13:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4BA1C232AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFB18ED7;
	Wed,  3 Jan 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWQk1+rH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E719447;
	Wed,  3 Jan 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqTlkbfy16t9pURMeKZEePX45h3C7rpJMa2r6wjaVqL3kX96PK1HM43xH9Zti92jzL8rdSJ0hy0wNFFRgyITy4kVXXhXWtXOThfVJYX4jVt15hnqbZqo9xj0CwjLRj8dyKK+NGwlfj1hoiTIYC/X2iCjsiA5ZDxTRB5foV7UDe/6S4S+DtWwcW6NL6rW03GXdXhLJkyWEHyQcfIyzDszqLBbyILHbMq4H4zf85BRl3IIdvZlx4tNticiz2HKX7Bh7kChApMZ9HbBgwjMCL1mka9OFGcH1NqJZJvNCNdtCljIvrJhC0TLpL4uarjYPJ2mmu5Fc9gxEyHoLOti2PkNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Z/1QumbsaXZ1Otjyeou0YVuNkOzpo14wR2XD6mmto=;
 b=f7tGOKBRIw4EM3ZG02FaTjCjkARVKYBcONySqyK23ec3yOP8wpJldtBPId8a1OL28UYtQkrmioktVRtcWXSFwqTC+IU28DJ7eaGBQ1B8I1x5ba87FoP0cBI8NNfoYjTXX4NfQVqu/U/uIRQKqj9WSwHhscjn/Ovc4onYU2swCMvZhPRwkfF3h3wivcBwuLM6BaDboUlHNUHpaATRUGhbfxyPgM0yeUjarAwWWUV4KTG3lQD1JiFCtux8Ge4Jehbk5Lm4agIxEY5y7Njmeegqh7WWBA4MGXI1j1sj28FgJmCWBFnlu9XCUDlagt7EkNgmBCsZVgGfjzyIJg2b4K3DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Z/1QumbsaXZ1Otjyeou0YVuNkOzpo14wR2XD6mmto=;
 b=ZWQk1+rHEYNXdIcnkPjCwKzuRjdRi6qrm4lZCLIWsSj/RM1/XJzeVGYDCB+OAx8jNOaM+2vgYIPAp/+VKsQl1TjigxUpny07cDBNvWXlwQArV+yfh5OOyxI85bdSmGI0UQzZt1kF1Phn38jxwNQD8nSVvxxMlhNKPFl2dXGlTYk+FVOKjzNVuHYSv5Q6zWCy2wkRpv6/kWrVAZHfUzQ4fIufRxasr9Dn9HU1z0rA4DrmiYBtIRZvjToDv+kbB/q4e+tYc9WG22gldNO1IX+Pn8NsKGOC8/spxRkgwzojJqfuIsv6mY+vY8FI9XQRlNUKHKEwbzR+eDIW2UI51XU2FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 12:44:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 12:44:04 +0000
Date: Wed, 3 Jan 2024 08:44:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
	alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com, j.granados@samsung.com
Subject: Re: [PATCH v10 10/10] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <20240103124403.GM50406@nvidia.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
 <20240102143834.146165-11-yi.l.liu@intel.com>
 <20240102184422.GI50406@nvidia.com>
 <ae271e08-f390-4ce7-914c-63668a46bc4b@intel.com>
 <7486492a-d6ca-425d-9fbe-87107dbbecea@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7486492a-d6ca-425d-9fbe-87107dbbecea@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0141.namprd02.prod.outlook.com
 (2603:10b6:208:35::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f164f7-10d0-437d-cae8-08dc0c59ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UTmfAl0T1YsXPMJsrH6HuCE4qlprhsRV/N3Q76kYKA33vpNmXMYWOtNhGj/ocT5Tu9VN5tJq0FGk5lOAqWGQZ16oaoasUfQK+HU1ZXkCVp07Y8/VNGPOO/9UwkPKBYRWikZLGqLZhJ5ZZ/9XHfTogIS3qaAfny6BrayPtwmlOygeHeYyGAJ9/Js++gV5HWMBtvBZvWtruPX0lqdLrck5YS/3y2b98VtdesqJoNh+eI51CIj/fLP4HwjxF93BP5C/1OTlT0WhExh/QFXaq8knlSlJEfzw+sdCnDlx2TmuLTt6Qt6i/il1jFwUV3adKpmOtO6hNRCNhnbZmBcURAkAAizWwigY4s35qTsoeRIx4sBC4kMBheNN0qaukKkajdoyU01ujbjwqWKNQd7LL53Ac87Ix3uBMNZW6YpUPf/2PvB0K5o5pC/mrR6770cI1G/NzrQGjHnQfPm54lU0xGCUQGnZr548DQIwxlAj3v8nHFaQMAGCwNuL7iXx2WAh8FsK1PH4XHhid3C0kCZze19OdWZjQSPLte4rwZet6VJhGnTaTVwqoVBxtPbHnhgxzXh/Jx/Ak4Sax2+IsVNUQ5q7dv11tSoItCCz6wUroPVEwUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(1076003)(83380400001)(26005)(2616005)(6506007)(8936002)(8676002)(53546011)(5660300002)(7416002)(4326008)(66946007)(41300700001)(6486002)(478600001)(2906002)(6916009)(316002)(66476007)(66556008)(86362001)(33656002)(38100700002)(36756003)(2304002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGpCeU5DVlZYcTJOdkF5R0RkenJudWlPaUUxeDc2bm1yYnM3VnUrYllWNDlp?=
 =?utf-8?B?RUtoL05RVmtGVWlpcnFuSkU1UHRYZmluTmlQcUkzWHd5RlFYOWp5emNzdzBW?=
 =?utf-8?B?aXd1Tit1R0pteC9Jc1FweGQxWHVidnRJTFRiNTVaS2t0RFV4cGo3MHlrMUdD?=
 =?utf-8?B?NC9kdGl2V3BxUWdoeHRZQXdsVXNYeU1LU1UzRHJZTzhMdXlMT2tqSjJ2Nmgx?=
 =?utf-8?B?WU0ydysrMW1rWUhsaTQ5QzVuZnhzNDFrS2xvRGlMeWR6dDVHbGI5eDltRHFD?=
 =?utf-8?B?R0lrSVNnaUhFUHA5OXlPSCtybmVEWVYrcER1bWhkVDlnU3B2UWhmRUM2S0VP?=
 =?utf-8?B?VElZeHBvRWlUSng4S2REUEZNQ256amRlc21pZ3R0VW5uMi8rQ2xBUWJsNnNG?=
 =?utf-8?B?Tit5ZUtqUzhZVSt5aW5uQnM0VkNKUE9jR0ZGeVIxaUhrTERGL0h6RGxDbnBk?=
 =?utf-8?B?NDh1ankwZ2RXbVNGSUJ2WkdTZy9KdUVkUFlTWHBLYzFCTzNxMDBWZ2pqTnY5?=
 =?utf-8?B?SUFMclFSTDhCQjlRcDNsVEFpNzdTWWZOVnFYeEJnVWxTM0VhdkY3Rzl4MXhQ?=
 =?utf-8?B?ZFE1aTFsU0FIeDF0ay9LbnQwYjFGdjR1RG5EYlRrTVJUVnZBWkRiZDVKTHNk?=
 =?utf-8?B?bTJrRVlBNlFEdmFkQ0hLWlpqampDQzBqRmlaUVEzd3RMMVI4VzBsTnJrODVI?=
 =?utf-8?B?L1VYUWY5UUR6YmJ4Ty9QN3NuK1h6aGVFSTE5bzc4SXE3TU1VNVpTVFNKaFlV?=
 =?utf-8?B?ZGlCc1I5YVNxVURMWDg5bmdsRkoxcnBVWktOT25qeTdEQmh6Y0haYnA0dFhh?=
 =?utf-8?B?SFN6VkRTR2kzOTlVSHZkNFNJYWFXQ3V2K3lnMXRFRHh1MG5FUWFvY09zeE9n?=
 =?utf-8?B?blBqZUFuQ0VhanI4VlRFL3hLQWNlMnI5MWF2UWtwcGJueXB2SEJxOFVYc3ZI?=
 =?utf-8?B?VlU4eU9keWI2UVFnQk5EU3F3UDRQN2ZoRmFSUlpoY1FvKzllMExjdXUrVGpJ?=
 =?utf-8?B?ejZZbzQ1a0E0MENGZU9mMTVRUGx0YmhvaExOcDBYTEFVbnhXR1pVekJvQVdV?=
 =?utf-8?B?TVdTZDk1cUtZdHg5ZTBaZXVWcHFtSEVGUVltUFEvVG9jQnlPdGRmczlpVFRY?=
 =?utf-8?B?WWNuOHBoUDFRcm52WjZIRUsxd29rTVVLbnRGUk1hTTJaUEZHNlBVdzhGak5v?=
 =?utf-8?B?TlpscUNuQnA1Q05sL09hSHV5YWNFUUVwQUNYT1AwWi9SYmJFMUNPVG5CRklU?=
 =?utf-8?B?NURFT0FwVHNHLzJMQjF1WW9PWGhyc3RsNnU5SWFSK2lnSlc4cGV0SEFEU3JH?=
 =?utf-8?B?YUczaG1oR1YrMHg5RWZRZzVraDFRckpsZHdseWkydG92M0kzNXNpWGM4OWIv?=
 =?utf-8?B?MjU4eHZObzB5S1prN2hDR0daRXNLbHlyOXZ0VmpVWnV5VnBSK3RhMklzc05T?=
 =?utf-8?B?OG52ZEh6RHRxTEk2QTZiZzR2dnF2bTk4and5RDZkRlA5Rm8yWnRWdGtQNTNm?=
 =?utf-8?B?TUxra1RUMjRIUDIzK3d5QURJQStsNVQ5TmFHaHFVdGtrYnlEQ3h4SWRLbFZQ?=
 =?utf-8?B?OWdmZmtRbGFuSGp2WTdTcml5U2laMjZvQVlHdHZrWFNOb1E3bStFNUR6UU5C?=
 =?utf-8?B?WE1LY09xbWdPZ001amsxM1J2UHFucmZqY0poUDE2NWJhcG10L2grOEZPZlo1?=
 =?utf-8?B?akxSL0ZlZVhoUzVnQVBRU2ovcUhJT0dYSmFaZ1diZ2RhV3g4MHhZRVVtV2xw?=
 =?utf-8?B?SXFRcWdGNmZCNHVWc1BUbnJYcEtHK0lsUmNOV3V2NDBYWXlqWlpnMWwrYTE1?=
 =?utf-8?B?bm14WjBVSkQ3ajExMm9TWEo1L043OW8rUWtpcUZ0UFhyRFZoeXUyUUJCaE1T?=
 =?utf-8?B?aGd1SW90YWNMVUxBVzNqMTVXeE1aVGZkWDJabWx4TFltTjFmMlZLeDMwUXpS?=
 =?utf-8?B?UnF2T000Kyt0VDZnQmFUUFJmNTlYZ0NYYklxNjdwY0t1OFhHOXdRakp5MEZ6?=
 =?utf-8?B?QVRUK2cvK3FLdzBtZmY1dW0rUmhwbDAyWGp0YlYvK3V0S1F1OGRVVTFsbWxU?=
 =?utf-8?B?MExFcmZEcURmYmY1NDJ1b1VjK0tyNHZyeS9NMXFteHo3b2s5RDRES3FPa29S?=
 =?utf-8?Q?3wYqJhhPqwovutf4eZzPV8Wxb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f164f7-10d0-437d-cae8-08dc0c59ab08
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 12:44:04.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nyUeDQfD5YIKq1slgrJZ6kVH54YvRlhZFTAm/vsxUgpIN5M000dpEBc6r6P2bhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

On Wed, Jan 03, 2024 at 11:06:19AM +0800, Baolu Lu wrote:
> On 2024/1/3 9:33, Yi Liu wrote:
> > On 2024/1/3 02:44, Jason Gunthorpe wrote:
> > > On Tue, Jan 02, 2024 at 06:38:34AM -0800, Yi Liu wrote:
> > > 
> > > > +static void intel_nested_flush_cache(struct dmar_domain
> > > > *domain, u64 addr,
> > > > +                     unsigned long npages, bool ih, u32 *error)
> > > > +{
> > > > +    struct iommu_domain_info *info;
> > > > +    unsigned long i;
> > > > +    unsigned mask;
> > > > +    u32 fault;
> > > > +
> > > > +    xa_for_each(&domain->iommu_array, i, info)
> > > > +        qi_flush_piotlb(info->iommu,
> > > > +                domain_id_iommu(domain, info->iommu),
> > > > +                IOMMU_NO_PASID, addr, npages, ih, NULL);
> > > 
> > > This locking on the xarray is messed up throughout the driver. There
> > > could be a concurrent detach at this point which will free info and
> > > UAF this.
> > 
> > hmmm, xa_for_each() takes and releases rcu lock, and according to the
> > domain_detach_iommu(), info is freed after xa_erase(). For an existing
> > info stored in xarray, xa_erase() should return after rcu lock is released.
> > is it? Any idea? @Baolu
> 
> I once thought locking for xarray is self-contained. I need more thought
> on this before taking further action.

The locking of xarray itself is self-contained, but once it returns a
value then the user has to provide locking to protect the value.

In this case the xarray storage memory itself will not UAF but the
info pointer to memory returned from the xarray will.

I've been thinking arm/amd/intel all need the same datastructure here,
and it is a bit complicated. We should try to make a library to handle
it..

It is straightforward except for the RCU list walk for invalidation..

Jason

