Return-Path: <linux-kselftest+bounces-19897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9B9A1647
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 01:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D86A1C21D57
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF11D47C7;
	Wed, 16 Oct 2024 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHaEdJE/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA65282FA;
	Wed, 16 Oct 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122871; cv=fail; b=tyEshHdtQvbsDGU/yTz38G7ZVojhdKLeh6DZE5U6jtqH0pefb9P/8Lz/kPH+/GroQx7eXhUgtDPqv4w3qL99H4PRScxxR9lHaw13aVOhHFc6gUP9IwlzMqWL4179aM9LRVNsbPOijNzyd5WMKzQQwrY3O88cVr35GcCrw19fCg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122871; c=relaxed/simple;
	bh=ZeYsLdZFGZ4ecd2PVFGtdy5qMHpl5ZJufAXMkXFGtcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CiVI/hgiTLfXQVCNEuRV/he/N755UXmCAi9N+BC1X9gHx/pzIYhy1Rcpv8M5L2oFXTXOQRCDChnAdVdqAQkmU5o2dqeLHj1hPbxAKZTNqSdM5zY2x+aM3zk/I7VcrxKuuggiXWdONhqvKPKWqB2memKZbOUsDSYR06eeL/yJFNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHaEdJE/; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/NjLTcyoTInNSfDBcqFIqNzjno4VWTQN8EOchBsjdMngHBGi0wtaVNWmh2MEb2paqVQIAw2BJ7eEN4tPnRPyxgG/+ZoaUNMZhRIK/NIiJ13ZI9vWVCtBoPkjh0Oju9jAV8D+g21pL7ODE9a0DOa8unydV9tTSVGIKyRnI0IdAJLjsBhsqYflbmW5RY4ZBx4iyojlOTOMcomMza8zjfALVnTIzL9BtzVDojiVkAF16nlR7tvCsAW5ihvKCp1PVOcub0Nyy1gwRuD3YtFuv/BYyvDmiJcBnavDRz++CZpR/TCYx08csIoTmjJmiaFB9Shn2S1142Vd3Q8TXhbaA+GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTcP/zM/gmGud92nuVz3xacQju/xm64brzZyP+wC69w=;
 b=yc+N50NIKzgpAnbPRV6vqlM804DwNK5sWysniVWGJFZ91Bjd5u3ZGapIH72yOa+E0yCgVMxPvO7WV4tH3MbRIxLoA5MtxooSaJZ4Z9jNTQYZVujRevVWaR+4rPAPxkGAqtmVcegjFTuQhlLuSl1APTs8ClbGC3C1HbQ41r8usopBVso94731Nhb4VTBAzaq/k6MQ9ESJO+IsJTweEfDlxOyQpJFVLOsN/DslUcELaWkpLLEetMGGv0X+9V24gdO2aJiiQXo5YZQPl8+V4nHNpswN9YeIrHnlUel+P+ki/FiTYgk7KdjSi9p3ZOmjDA4JgUCK6kaq6yTVnz1xps4y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTcP/zM/gmGud92nuVz3xacQju/xm64brzZyP+wC69w=;
 b=cHaEdJE/xCNZSU9lVhzrUbCaCdAJr14dZK7jV+n+03JHzW5EtD30DsKDxNHbUTYwrGur2W1rHdCue8vzUYbdFPvFu/nf2BVi/5x7+GL2z4BezZEiyEyTXuhYYqnY29tUt1e17KcEEw6wZAuRVcH43ZFUPI3F02ZgERr/Iq98uG/UUngNqskMa36CIi9ttoV5irBVsU8g7Iqsj43Hr7MvULzT3ftYeGyGGl6IA4n5N2DOJ6dhRMQvno5wJfuHeK0An9vqFz3NmVQSBaiKC6zumIxFNgxFct2iy7HyzGWPAAJ3G2ZvGJY1IrnLOhSzXh1TJxcPuT+A21i7lV/O0kYUwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 23:54:26 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 23:54:25 +0000
Date: Wed, 16 Oct 2024 20:54:24 -0300
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
Message-ID: <20241016235424.GU3559746@nvidia.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxBRC-v9w7xS0xgk@x1n>
X-ClientProxiedBy: BN9PR03CA0501.namprd03.prod.outlook.com
 (2603:10b6:408:130::26) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 017ee359-bd86-496c-ac6e-08dcee3ddd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wl7H0vbMocFnP7xa9VJb4sHC47BMIM+thkirsxRaobFpnurqYCplzslN5u+g?=
 =?us-ascii?Q?9uUi7rMDu/FjxdW+zMYzR2UdopvNS7iVxuLsN0B/Fqs/vnWGG65WxxaN/u6W?=
 =?us-ascii?Q?lnuQ2rQsUQCQViZ+EAkuO1I4UTmP9C2mMA49dXddZm4XR3Z/LycpGaREF/4t?=
 =?us-ascii?Q?wtnM053vM1fVcu/kiPvalJOldIGHBWh88XKPHVGYlyKQOLyIurmoP4+x6Rn5?=
 =?us-ascii?Q?mLXcdiOCEllOiwhG47079QfpK6mPqJ4JusSobI2qsgqJ5aW6NCXgmhGDtc/8?=
 =?us-ascii?Q?bjLt2o//igQgbBZmLPkAvHGPnfg0B1eN/7IlgiXG20okPBAzi1Gi9dI/tCl+?=
 =?us-ascii?Q?PGOBENuRrWDiOQQXOty25MotloPpNwQE7eg/KLdyt5NmVSVeq4QmlWKqIwtY?=
 =?us-ascii?Q?VNU+qhDe8DiTw6d/LNkoLg02GNvdEWB6S0AuAsOo5InHOyFYzl913lO+pbqL?=
 =?us-ascii?Q?83VewTAUleq+49cPG0z0pv61+iMPImwyFpUzjuXmn+Y0FdvHW71l0/f6X6CK?=
 =?us-ascii?Q?U8RjQAM01ppkOs1Xr315nCdJkKTGutsIXdMeY+NJmucX05Nre8qOx+55kV7k?=
 =?us-ascii?Q?ivgcthRr4i02xhlLkMa0VO1iHvoa5n60OdbCppj6W31Pw0Db2SB1juVbWaf8?=
 =?us-ascii?Q?ZMBEFq6EJGbtkotcfBaHB8WGfHk4prHK6LJY5c+7Hl9OORIr34pPjzJ8WJF5?=
 =?us-ascii?Q?Urhm6ueXzUUcAh1uFOmkAOVymviQskpGiuOTt4wRubCzXU8uP/PX2UksZp+x?=
 =?us-ascii?Q?8rl1X/IOLqxcuDlhE5Hx/lnAviGFuyx85JxiY++h8DPAB3fj3T1RnIhhc6xc?=
 =?us-ascii?Q?5A/7RVuNU1WkhQONui35smAzYw7nVQ2LIqCj0EI537FN1tHk6qv499uORPMz?=
 =?us-ascii?Q?hxc7pc+20/aDbrjC6iZxu9YFlY+AU87e3zhvKgnRSuoU+0SzznVhzBIWWfQX?=
 =?us-ascii?Q?b6yEZ8YpMLdMiOoWoVgz60n2ZiXwW42AqF4dVR9pwWF0QGqxkZRxyGK4rQ1j?=
 =?us-ascii?Q?xQ8BuDcV/hsWM1jlHEVnbWYZtfbAUMSFnV7eLW0pEet7SQ4foDFMB+xCXMLC?=
 =?us-ascii?Q?TuOAEZIzfXK1QPiieUn2/6BA9lPvp6RZcH4zN5TGGUJqTz8d10ah6w1Xdcgr?=
 =?us-ascii?Q?1C3PWRacv/lxDqEMK3FMqauDcNezVtsYZ6zJnnFOkiBvorwep1cmu1kaJnmw?=
 =?us-ascii?Q?2bbZWEQxLEDNsCDjxB5bwpG8cdB2b4achuFKROzUa3ew8vEIMUIzozWOmRN+?=
 =?us-ascii?Q?E5WWaGdny9dnXGGWRjZxBsSfTAZ6XxR7I4J3PwhX2NiGFEZruyRZMHYngV1y?=
 =?us-ascii?Q?+/eOOhYrChArIsyigdlZ6r+h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IiFto2VPSNqobcVogs3FiTAjt4Dh4+QLTZQ6s9tXp6YoJ7EuFfiifEP2vuAB?=
 =?us-ascii?Q?nU8fdNT8z0QIW7u6xGFXCGy3KpbOCv0kfZVi5WcfmbM1A4hklLeccqrPrBK5?=
 =?us-ascii?Q?j2+5mV/W5FLGEgPclnIXgj6RSfL+ZDFv4CZmzuqW3WSqhmYFzBtRxrPE4VBM?=
 =?us-ascii?Q?gfcHHbywHt+XK8fApfYjKIF+TM/TT0w8wxo5Ofm2oog4H2pDkmdTqq//V17q?=
 =?us-ascii?Q?riLtgYCBdwQw+w9tIQIKuFGaMSTIcYvC7ksoqtfAfPWtLiymC+O8jfWY27Kc?=
 =?us-ascii?Q?6U0hwXC+NogaYoIo3Y/bK4kip9lRGihNPDekdilM/nyk2yGc3RtqNcS4+GLE?=
 =?us-ascii?Q?cMTJFMBCq9aBfBz9G9bWyWa7MhWZpQ3YuPBldcFu7h2g6hnG6QCoEPPpgtXS?=
 =?us-ascii?Q?GG6LYPDnF6afbQ1c6vtuI4s/2A3IDvZcrQPp0C436AsX6eqizWm4Q0gQ0hd0?=
 =?us-ascii?Q?WgjuuI7ZmiPYBAQRp4U76qxM2QQTpWkKdHafsCtQJvvh0xVKdqW0sef9Avn2?=
 =?us-ascii?Q?vBVsyn07ay4Zsa/wzXh/s7dlm41BakEl/aVOZppwY3HqQL/ZUQbEHeRvS8Vt?=
 =?us-ascii?Q?1jieD5x0MFB5y+m8YGPHKn4r/ooK3Pj/A5/wuExLflgAzZuWaSgQqWUtCyue?=
 =?us-ascii?Q?+C6b246ET9mro/0C1JIpxLyObjAkZl5AT7EokzFCWz+KzOm42LrH6VLjoXaM?=
 =?us-ascii?Q?Ir6j2fhlW0Ysn9Vqi4A9nGTbPeuz7DZXpvRnU8MeNpKiRaMCYVEQRimqKe/v?=
 =?us-ascii?Q?/86nazjG3iMpxuSqxkQZe6YOz0D/i7gFSz7tgxqMqxut19KM921d9M2+piwu?=
 =?us-ascii?Q?WVXFbXd/QIF8beTJrTYtQRJ8HCNf03hv+GkHkXrNNdsTP3sxSKqCP5rnHVGi?=
 =?us-ascii?Q?rKeRw2HJQfnat7M4El0XK5sU+1hU6mWF8QHgaoIrzlKou6dnjxR6NNbN4HNW?=
 =?us-ascii?Q?NpGnNXjPVP3h2xuZKIzBXdfDrd7x4pI+hldewUlooDIY0neHI3PXm/d0Xu3J?=
 =?us-ascii?Q?eOWS6eHK6wgUtG/ZDzNdYQ9y7V6/SEF2MzOYg28iwl3fdrKCkq7zbxWhqwf5?=
 =?us-ascii?Q?hFSVPtaHS7u6jlx69tleENWPeNE8TP7SfURZGf6QXM4l1lvf789sQIFCt5TR?=
 =?us-ascii?Q?94YY3nptiO6nSb7p2F/1lCOAWmhUy8wgcrCORwlKfihninLupQWMMy4d+xDz?=
 =?us-ascii?Q?BGLQUuJAzxoKgdvr7ksF+W/hV3TM6R6/HML5ZJy6DscdlGJZnTo9nZgWP/r+?=
 =?us-ascii?Q?kYit7xZuGxh77kV8qQxIcWH1+cDv17C/R54fDaNFjwDrYBN6keM1zj9s1uWI?=
 =?us-ascii?Q?bclwg2/HSWww+sP9q6xIErsecSwYUWkwVQ3pYMqGZpxgDZqNrlca5iswdknX?=
 =?us-ascii?Q?m9FjOuPLTWjfm7b0OSYKmItLmKqoBNkrp6IaSLaQvDLaWivyY4fr/3kwTZQc?=
 =?us-ascii?Q?g+lOtK0kt3y9eJ0ZNKqgHSeTccJQngK5q1CAqfNasGZ+NNPXhJj/2sxuXoJM?=
 =?us-ascii?Q?gU3gZXWRf2MkScnYOBKCptpaahSs4JS6l/BJITozpno/IB9DMwLEAVzxZzQT?=
 =?us-ascii?Q?tVkQf1GOIk+QSq+w2ZUh0iqTL9j9w7ayp/lw3etS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017ee359-bd86-496c-ac6e-08dcee3ddd61
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 23:54:25.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFGEwACqtSLXwWHj4A3D049543WYIFeGg27qTIHCo/wMJigauUfKDPSPjWomiQt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

On Wed, Oct 16, 2024 at 07:49:31PM -0400, Peter Xu wrote:
> On Wed, Oct 16, 2024 at 07:51:57PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 16, 2024 at 04:16:17PM -0400, Peter Xu wrote:
> > > 
> > > Is there chance that when !CoCo will be supported, then external modules
> > > (e.g. VFIO) can reuse the old user mappings, just like before gmemfd?
> > > 
> > > To support CoCo, I understand gmem+offset is required all over the places.
> > > However in a non-CoCo context, I wonder whether the other modules are
> > > required to stick with gmem+offset, or they can reuse the old VA ways,
> > > because how it works can fundamentally be the same as before, except that
> > > the folios now will be managed by gmemfd.
> > 
> > My intention with iommufd was to see fd + offest as the "new" way
> > to refer to all guest memory and discourage people from using VMA
> > handles.
> 
> Does it mean anonymous memory guests will not be supported at all for
> iommufd?

No, they can use the "old" way with normal VMA's still, or they can
use an anonymous memfd with the new way..

I just don't expect to have new complex stuff built on the VMA
interface - I don't expect guestmemfd VMAs to work.

Jason

