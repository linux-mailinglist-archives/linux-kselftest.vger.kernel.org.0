Return-Path: <linux-kselftest+bounces-20000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA319A2A6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0C2822C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6C1E0085;
	Thu, 17 Oct 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Apdgxe1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B871DF97C;
	Thu, 17 Oct 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185016; cv=fail; b=oMArshFraXvTkWdIxN2HYQyVMr1YfqEmfaLopZeUjJFf3HzXFxPDaSy4lqLhlcjchDOvIkjP3nIYAj3ewJrrSqYt8VpoH1t4quzOd7eTUYwQr0CEBUr05rkYa+C4xC26577UaCslotVEqpfUBJMwvoH6/CWlwGRVmrcDb4h9vEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185016; c=relaxed/simple;
	bh=sH0Z7QUUNlGtZkHda5/3zuw5EdmE9OCLk0/NqS7M8AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FoIAzkCMidnIDQ/fz5IqbgSRNHyer2L256Pwhg3OCbn8wDhsduy//6O5ttpOVdjyoKhT39L8sgQSk5Mvc/iJNrjqIPfLnb775plwVTthj57PL5tEldDl+at8R1eEEhGvfrN7eYNY3sb79e8X6/MnTy+8V/AnwGIen9GbwPs/Ir0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Apdgxe1I; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seciWd3kZ8ioCYdPeF2kQYUQFGlVYpEGJK2A7fF6XU8fbhiLDhX1bD1+m5WAyG56i4Ie+zzf/RwP9V7fhao+WcYCFQuE+zOLjAVxqVzfao3PfZF9GEqIe12UTAWztTXkm8DJOzC8I0Z11drlCIMY2r85micFrlk9Nv1JqYYebwaNdakWm4WcJNbMcpADqAiCCFLAqN9Uq/o4JH3VG9H6FkRB8G73PE7HQeNYuM6HcM8+rM3ZAFVsBorj/tk8+2UPQ4PleU12Fy1pb9R5SCGX3d46OkgaUglkvU7cWk0YB9i3BAszvinqcVX3IqPHZcHbPIzmxFhLj3UISf8Soz5TLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mJYiRHqpoHyxzf+GAdQMP35Mkwb14Q5IGOvP/0ZnDQ=;
 b=VgdKsuqp+ZCkW4nXlukZWGB6kNU6NPn31aVKZodAB5rGq5Wm3eYlTbUEYN11zoaw2puUXVFmKrqm2otJpp2Y2+E2VBntnWnV7NEF+vnESYzLWJ2FP5Po1Qu1D+GBOPUZiCs6AUedhPRGtsHVL7OALLM0yfRhZ1FlJrCO1Q643SFh/YIoPUaidUWRmnQuiPUulTE5axZyWZT3FRXtuNYNG2czhy2viyudJaKdh3W1nKw3HimtASe1WJoCxwSEXukzTni7hsPE10MSd1Aki3fjzREI3ZaMShFkWG8rRq9Uh1Byzi+o2vhK8kL1TWDIeUIGd6OAMO5f9MFDWRTtcpy+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mJYiRHqpoHyxzf+GAdQMP35Mkwb14Q5IGOvP/0ZnDQ=;
 b=Apdgxe1IqNrZZOuo/CJyPMRfjN/hZEYRPhBFCsSIu3YQ5QW1RP+UH+d5TUKjnjnThVkJ0zAbGTCKRtgsUEi88LHPkzQ8K0ZL7+wo79ybti/VK2KeW8kJIahv0iFu44H6NpEZYC1iSUFIDYcsNV5GiXO2Cratom5Oy5IIjyJOCIwcmn5LjM9Wk4vrdEEYasvMto60mI8hsz8ZpneYlgbuXDyZniBBWtcMT3HeL6le5Kh/2godU45oZhwibC4FtbjtCwqwCogTR1JF3hEqmMgT2zPurXeZoyCscfpM8csy0rcUuVmPGPxY9TV51Upq8Ena10PjBpUiW+ArroURFurJ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 17:10:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:10:11 +0000
Date: Thu, 17 Oct 2024 14:10:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <20241017171010.GK3559746@nvidia.com>
References: <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com>
 <ZxFD3kYfKY0b-qFz@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFD3kYfKY0b-qFz@x1n>
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef4e594-39f4-4e5c-c3cc-08dceece8f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WeRlXssjNXHk3FGnynEYuvvLrcmjFVUM5WbwZbDxLhj4Ue7A6UkNCqgoMpmW?=
 =?us-ascii?Q?hcmmp0P0Oj1NYZNOSQa4qZc554EhVVNVI4kObYiDaB1nf9IG2bcCSEFBQ+yy?=
 =?us-ascii?Q?OS8bDyli/x/jrsLNFd3AttyaLHR07JDTJ1nfplu0qp7DAmOeTq3uJn21gq09?=
 =?us-ascii?Q?7SNznyPXo4W9+vLBnUYdjWOZXeP6uR3JT4bBqO/+ivWsKT58jEoLttAAn9OW?=
 =?us-ascii?Q?XDBsDS/V8+8Ion6QXJywMBlFVJPvp8Z1OPhkIdCBvP0T8P1g6WyFxYUNLcOV?=
 =?us-ascii?Q?bS7fe2UGpt33Z8N4l469DLo+UI9a/Eev+k8/aM43qSnA/5b5pL9C2sQkfUVS?=
 =?us-ascii?Q?fos/4gXeQSjb4zS6ymgtrUKMrCNrXtpiRC8DtesB2506z3JnslqloKnobIQ/?=
 =?us-ascii?Q?4obh50856Z+E9FrkpNAYypqzSo3r2x6oAnL+cdvdO3zrtbX+lDCw2/kAZa3a?=
 =?us-ascii?Q?z6GwoxfaOC8mBEgUfi1dIx59IhG+V565drvVtFKiM3nfnOdVNSJMymJBz0vH?=
 =?us-ascii?Q?c6rXF6pNsTv+pLLYSXf+1mKjY8jM4hB3D5U5NZtVWO15kM1pz7lTs4VzGTXF?=
 =?us-ascii?Q?3N14cRtI9k2kby/bQMt1VsISCVwaLK0A/Syygtorvj9Al2XbSYCCr0ZFcelQ?=
 =?us-ascii?Q?Vmyj9h5XYkccJiliYfUD2WJD66bn7Vfs5lbM1If+aq7HUKMQQnoc4pnDVrmN?=
 =?us-ascii?Q?1UYG4tUCJShmVU2ulDKH8P8FY26IIfImV2hsvzTPRNibMte6X4ODQtX5g8io?=
 =?us-ascii?Q?fh+CE2JALGFS72vHYsPKBR9ORX0DnZz+iVnoj8ZX3SJZvjC6y1kl9MmQV2eB?=
 =?us-ascii?Q?60j2cLhkdL0gc9JT0BAmqhTCtnjnofDT+kwKSp4yrgXpRIBjRAkY2RMHF1+V?=
 =?us-ascii?Q?tTCaZU4f3+MnAzRz9lzJUNy5pFhj0xoSBXO9HLTS0YZR+DQ/6aWaJc7uYKvX?=
 =?us-ascii?Q?VsviO9LXIQUfKw29u5oUPf1EhlrqBATydODRd+W7SIHj2sJUDvtByhmDi3kh?=
 =?us-ascii?Q?iTpwp6AvlUVTQqm5Y07G2eQTi2ceV2/SYd688+h1pjMSUByUgzK5b3kjUpsu?=
 =?us-ascii?Q?cj5lvfzm2tVSNSs4wTjADP6hGVYZ1ax8adKJIM/uyxO0NICTCFkAWanAjvNF?=
 =?us-ascii?Q?Bkh2ZHvTbHgq3kwR5eau+l7Y+rLfPLTmrvNyqvqbeLTRtoeGlHjGHDVzcfW1?=
 =?us-ascii?Q?ZJaiVzHpdWT7nQ0piszMR2jXEjvEWVOghyGsXBE3bFhnMr+xc1deMSOPYhnR?=
 =?us-ascii?Q?EkR9CLYAhf6Nr2G+3y5DAD3PhSnbO2jEtWKY/lDAx7yQrdW4YKNFBxZG03gh?=
 =?us-ascii?Q?WWLjps8p0sFwhD8GI1MDXX8W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQK20RZCK7wf8ub0PlLqqW7tp/ltN8XMHi/xmlVS1kkTfQgmx7BPHknsMtcs?=
 =?us-ascii?Q?fbEMWmWRH9ozoHgYEMV2GQaKDn+l3wubw7KnbiXoFnWExO2TKsC6suv0Q5Mz?=
 =?us-ascii?Q?tZyNl0g/Bq303X1WQrODSe/UZhU+pV3RaSpq6Fe9fEvBhXW58CfAEDq6JhvC?=
 =?us-ascii?Q?BVbhdHyQpQQJD5ySbz58/e2cmN6uWch31g/SrcYc9ahuQzVURjnAwopX+5UK?=
 =?us-ascii?Q?CDTLBD5X0uPidTKVV3wXjg12NezQ8L+OUoxv1YvMDWEXcL/C1GIFz5eetr8c?=
 =?us-ascii?Q?XfRdFUjpGPQEB693fU8HUdPA2BHy7KglJj1v5awLPTdtETDW5lcyi4semlwY?=
 =?us-ascii?Q?UIc7aEf9jTMBBbiCMi0DEXv1PEogX3OamMFLw7vD00vWa8hsvB697cgBEddF?=
 =?us-ascii?Q?7BGCLq8Vq6Px2vQSKQEEq9FqQY6CXKOqPCXU+6s1xLNvjt0QRBoOjs951dzx?=
 =?us-ascii?Q?bYcnUS1Rc2dfT9QcEm6WaEl5W26M4w+hHGIh/NDTykdA0QCTCwcvWp78CO9h?=
 =?us-ascii?Q?0zylGnJhIZLoLYTgDEeIbum977f1zx1lMelWTNsWcxXlNAyR53FArSG2jSm/?=
 =?us-ascii?Q?8lnO1q+3PZrfPCc20MlvGnB/eQ6jH3YSgOdoVhOIOfmvaPxmWuwL1wUc1USC?=
 =?us-ascii?Q?0pQPe31aeF0uhitX29hbAI76IJnPdBCvloRQykVanlNRgQIJjBMqsHJsFpl6?=
 =?us-ascii?Q?Ge57/+hGcZh9DMvz5gdRZVkBQ8Z1mhfua0/B/SC1zwaWPttpq+UopXNGb14e?=
 =?us-ascii?Q?hB/N+n/NoWVu76n0KuFn6BagKIiZqnHQPapPxW8NwDxjppJabwJcH84CvWxR?=
 =?us-ascii?Q?nvJFVx5nY234lX0y6EPRh9x4xd9UGA/ORzPtyXSq9RGYGO60jcEfanX/wHSy?=
 =?us-ascii?Q?Q78Tke6BzdDDYAMGudzpA5rIVJqc3AdLnHwqdlB3n8W/dUZFfiq1DIFYBgDl?=
 =?us-ascii?Q?tZTZ9ia91OvUdTMJWT704hwbj+pGf8wQRNrmUrnzJTOpv7fKP4TL/RJrxc3L?=
 =?us-ascii?Q?P+JugWftpqvcy2ZlzgT/0tTbOzD+c2ppCCeIYHhGLMk0nz7SayZWJ617PLmN?=
 =?us-ascii?Q?q5VF0vR9kjYIqRhz1/cOVGuv1KykEKw8g1JqB6IstrS9cBBeVgUmKVAT/QFs?=
 =?us-ascii?Q?94TCPqGOBwyEjOKAdVevtzaXFK1mx22UHsiB99f6B2FkDaIADRIHzFWl7FI4?=
 =?us-ascii?Q?KQhfGYoYyr6I72zlS0/gwe05WqtnXnoYzL3Lum7/oLXYiRd3IU4zJDP2zCT7?=
 =?us-ascii?Q?Fmq8cjEBcttQRx9pFj3ceuEWYJxvtMO0HRuOCS96brIlPECQBZQxX4u1gcKu?=
 =?us-ascii?Q?vJcAroKjWAuYe0giUOhqyy0q1pMnkb3j1n+Nj4WNibm+eyYi+aOc86M9V1d5?=
 =?us-ascii?Q?G6L0gOIePv3IC2uvqR0xTlvXao7WL5e3ifXKvaupCnJ6O+wuiS44i7thGhYh?=
 =?us-ascii?Q?I4/fMoZgWfZKamNBdZlaak0VzhXjl2vyUSRphtg/Rdx5C9Ggz0uu4+wGy1iB?=
 =?us-ascii?Q?Jn58iTyIAHg/nAMqyBz0NIrBBfICBalwi/76k72M6k91KSk8KsJIRBgB/Had?=
 =?us-ascii?Q?kb9jALWghSNn18upT6s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef4e594-39f4-4e5c-c3cc-08dceece8f2a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:10:11.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7NyHd9ojNiaBMzBXBmlHh4LEwFSDxbkvvOOFKpx9dfroE6CHoVEO5idjSNLexDZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On Thu, Oct 17, 2024 at 01:05:34PM -0400, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 01:47:13PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 10:58:29AM -0400, Peter Xu wrote:
> > 
> > > My question was more torwards whether gmemfd could still expose the
> > > possibility to be used in VA forms to other modules that may not support
> > > fd+offsets yet.
> > 
> > I keep hearing they don't want to support page pinning on a guestmemfd
> > mapping, so VA based paths could not work.
> 
> Do you remember the reasoning of it?  Is it because CoCo still needs to
> have a bounded time window to convert from shared back to private?  

I think so

> If so, maybe that's a non-issue for non-CoCo, where the VM object /
> gmemfd object (when created) can have a flag marking that it's
> always shared and can never be converted to private for any page
> within.

What is non-CoCo? Does it include the private/shared concept?

> So how would VFIO's DMA work even with iommufd if pages cannot be pinned?
> Is some form of bounce buffering required, then?

We can do some kind of atomic replace during a private/shared
exchange. In some HW cases the iommu table doesn't even need an
update.

It will be tricky stuff.

Jason

