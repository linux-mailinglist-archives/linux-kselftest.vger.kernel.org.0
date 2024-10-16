Return-Path: <linux-kselftest+bounces-19892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128789A15E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3234B1C21AC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379DC1D356E;
	Wed, 16 Oct 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uWJ2/B6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F7F9C1;
	Wed, 16 Oct 2024 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119124; cv=fail; b=q1wAUcwbfighK+/VyTPgsUO3D0YjbuLHE+MgUfm2bbfFFzF9DI39js4opQyxG0aFNwrdLII4Nq3BZ6hl0IKzaKmO28BM7ZP9gY1B/FQxoAQVRx5O6iEkrrOvd9f9QODuEcQrXpC+lxfUfIvvxc75l/Nq2bEFkAP5iXms0qxU7ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119124; c=relaxed/simple;
	bh=lJcchtt1JcN1yuL9Wj0EwsXdJj3His8Hoq9nB+NPvBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W/lwQXX73xtPq9y4FJKI7o1YoffBWzKIGQxrzym7g3rTsHJOuH1V/JzDdFHmsZu+ngPa4qKcI/kN62F0PibSntvzGxBZL3yQUYw6pXUHh2negBCzVNFUCgXet9FBfBAVYDbWL5NureTuZA1X8OQbympOGzakToxdgVqoCqYUU2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uWJ2/B6w; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx6qFMrmGEaOGiso2IsQKSIte3xqtfUjI/6/4r4C6r1WNabdruEA9Hx2bXEopKG2VrwLFpTm6s0tT0pKn0mhTRL/BqyrJY+rfcUB2/Zp/Sk0VGjy07FTf8kpjjAlmmPeIbL2Q6yhX4LjaFRMj9m9iTcXx4RZFSJgtWdiA9D3jkuAgaBHA8gH0qZazZYdDTmg3GJywhQOVHGdF+mjkfG/sWIGNdlQFUDCCxDvP55yZz6svx/5x0Qrff/ZqU1I6MQY3NVRMUm86Bx1ZdNsUnRk3ZkSLqWrzWrP9UY23ux0WHGK+DHmGCCOPymaud9ORE55uweEe/iU8zBlh+oo6BJujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrMtYFAqXAG/p+3Ih3XmKzDfiU9QV6n+DCH6JEvvvdc=;
 b=oAPpSUSZu4JfaCuzDClkWUNp+iO7L0928PB85Ct1WxJKGHZHGNmkeG1WhnuExNtpMxJc5pwskTVlT7cHvA11vLZ308cQleo32KO+54PfmPZNl6KmU/ADn+RJB8euGylk3odJBp695f6f/21wEBgL5Kply2VBICCQNvPOCCzVIIw6QiILMzziJ5jpSzv1wKqcpA9311zwMWzgQOlx5L3+lYW08FRafddDSUuc/3utZaiMT/XnioYPrS7bZ4UtgrYebmzA9oe9MKcM+uNQmIEMANlfA3P84yWvIKplmj1ctlRjwDVnPhOEuPMsMVrCsXTbh0An+Z5r4jUmWmKqzdPOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrMtYFAqXAG/p+3Ih3XmKzDfiU9QV6n+DCH6JEvvvdc=;
 b=uWJ2/B6wOTDNT2k90t3hR8uWWCiPXNKHQAFiUonEBJwMaRFbNC2NNsfLrrWkMpllJGtmyElpMwc/LisVuXtg7hEppyn/jzX+qr+V0JD39NJXbRa3mN5gRpcL3Dol6Be+HDfSIbO1+hdWyA9HVd9r50cjPF72GeVXZ3EaLyRm1tIA4BX2hl0EuKl/w82S1Gfi7icrAnokHhAYyRb2HeZzxi6aJON/4Go4HykV+hccsJIYFlrKYcpX/FvxACE0aG1dn4yZdpfzC/sdjl6mbvFL+ftpUpHQBI+zAeaHhRHEoYDKjs1kYHvB8g1/CmqhJHWFq2f+eWaboIqpy3ntv9Cg/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:51:59 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:51:59 +0000
Date: Wed, 16 Oct 2024 19:51:57 -0300
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
Message-ID: <20241016225157.GQ3559746@nvidia.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAfET87vwVwuUfJ@x1n>
X-ClientProxiedBy: BN9PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:408:f6::18) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2b9d2c-c089-478c-6a71-08dcee35247e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0Px0LC2M3Sm49gVVs3pqst0Xu9+mnxBC5olf/dJzMiwPYqhwNcCJ/0iM5Nn?=
 =?us-ascii?Q?sEy2cUZ6RgrXIEe4tpLZBG4I4UArd9LV308NKu6JsaLZoI6cadbZCTV0oFcW?=
 =?us-ascii?Q?CqUim6sIPfR0Hft7MeBtVRna5Ulb8MBhoLR3zRd4RfGkdgYID8lk1SHVYxSC?=
 =?us-ascii?Q?Uhd3Td0O72Dj/j2AeQOKEgNTApmMifU921WvRuE8/jzcIZe34lzmtF2PXIQg?=
 =?us-ascii?Q?3ti+zzH04dq9jyGSRkXy0HmISlA4ZjA79Mb1oKCbLBVR6vXZXAbTpXN2OfDF?=
 =?us-ascii?Q?MhAaEJ7bOdu/sz7YL8gx2JFD4GDVLj+Ivb9rXyAt4L2xDIo3ZREULwvsVYQJ?=
 =?us-ascii?Q?kH43FIXiSyzfpP/s69QilZ+9qJMDLXi52JE/gUlI0F6U8wpoL0TuqXEbmDFa?=
 =?us-ascii?Q?iUmO6YQRiwzY3FsJg2/1GZ8wCglkyzcrqbaJiwm95WKiQM7peuczis+ZWwr8?=
 =?us-ascii?Q?5LVX+dlcO1+2seFoeYVPtTCZra8PUHJey1SdbPARJ3AlscJJ/V3jjnk7iC8c?=
 =?us-ascii?Q?fsIQxE9YTH/YNTV1aQiNrOXvev4lrfPnWyut+sHvpA0hWncIwlYIiswo5REB?=
 =?us-ascii?Q?xCQ+G+CVb81wSKHm1pI99cqjS0AgGrhVGUXqWyzeHKSisuch5gq5Hmz/biqG?=
 =?us-ascii?Q?ZN1R9mXcfoNEEobu72OCOqhXO8ilf1tsntU1au5kFT9J8TlnuwcTZy/UPr7u?=
 =?us-ascii?Q?pLCfTSS1xjZ770n4MtYlJ2viU6cC/04mSrrFzkbMzgmCltx46y5qT6C/k5V/?=
 =?us-ascii?Q?niJLtq4tceF1y0PHzEOXku5ZtPQOE5WsSd4Avwh1bAVMiN5IWPRM6vS8AAFw?=
 =?us-ascii?Q?gzB+MuhgyOqgROMkQyFRCLE0ZdWqNS3+eedJTocZq2ffgijKNRmmBbWbBHiC?=
 =?us-ascii?Q?T1y6YlzQvoDRcqsho0c7Zbw16uofJKT1S3FrbPEwpuVl9Eppz0GNEzI9HuvW?=
 =?us-ascii?Q?x0CHk5zU3Xzk/3gKQiKoH08rnY4PFkXa4ALFl0yAybkhpxicGBlknhyv4jwt?=
 =?us-ascii?Q?dtKFdn9DGcRap4lcoxXGER3lZUBtqeiXoOKihceJUc5EAKhb2PyjW/uJnKnR?=
 =?us-ascii?Q?CX1cbc7KzWT0xOxMQPoKlhncABrIlzqVpUaJXHfg6dge/sni7Ape1MK0GB0L?=
 =?us-ascii?Q?caCP1UuskUSOkCBErPoKQBIWYhyn+NIIKbkWJnfZzArwuOmf4nOS7uxggMP/?=
 =?us-ascii?Q?6yaGyHs8HeNqDYPPHfTCMA3EbWhEPqyUtHeLShPl7GSFCMbaE5fVrPkOrzwb?=
 =?us-ascii?Q?mArhgC/zoOsQGsPdSAk1nNNa0Mv/xm/QzFxXMvBrYnqDnoozGKQReaSpeIpl?=
 =?us-ascii?Q?nwxSNgL9xpJxhR/T/wy+MSsw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSVXgeqBmR2jy6nTaa4aPIhRF3xncrvSiPpBIzPe4pFz/pZ7rQjCYhl34D8Z?=
 =?us-ascii?Q?36wAAtFnBKjSgniWvxm9wjTHYAq4+Pb4wKTVkgiBmXcBXOL7v64ebcUdBHUD?=
 =?us-ascii?Q?t1EG4LDbhe4Q91S8IqZR5LIHgPNLlMZZrq9Le5ZH0s5zGhanXpVJ/Ul2FzXV?=
 =?us-ascii?Q?e0p1jy/sXMY4O2tYHYGE6WZ4apkNsuPa/71iQX7N6iLBbcKzsNVStJ71haMD?=
 =?us-ascii?Q?V5qrnz9FTlIDpTiPNHbULDEd4nKInvaxjQjsXLq9GKbEVGsDmTAipMAniqHn?=
 =?us-ascii?Q?ZBrbutgyRJVwaPmmWldYxXZrn7nR8YOjYo206qQQq0YH5wm8hm4fJDurOEkR?=
 =?us-ascii?Q?ivTb/0dCwZBtIqe5QsGYBGvY4rwGgjIOR3FmmtcPMNINIhtWGMDIAkzs5ieP?=
 =?us-ascii?Q?nwujvbJrMxiYBRaQb7Z0EyuqJiUBuPA4KccFIIIeCz9OBnlJaKIpUSOL1F3U?=
 =?us-ascii?Q?QcjmAWSV5GC2tbcGgPi1R4VAY5p2w1r4HCzCaiVp/V31NQJcp5x3grVkzpns?=
 =?us-ascii?Q?D2nL5S1oCWQ34v2gSnPKTvy/Av2lQXewk34aZzG9sO9Ku/uF28s8M2zIgluz?=
 =?us-ascii?Q?0/QnQjNvMQX83VEsbeBuxgMKxB8M/sQ6HZ99iOLX+n0Cuu5fBCuoRXkmDUqH?=
 =?us-ascii?Q?jVs/6AVaN6rUYOdkcihBhwWmxQgYFJZdyqC4XorcffonA27RCab0nIa67tsE?=
 =?us-ascii?Q?mfnPTrBx4hGtu1Q/TihF052VdswhHpWgP3o6p0Y/84wOs3JbKUSACHOEaC2I?=
 =?us-ascii?Q?48WiRcGm4brOA1EU+xkfc2amxnEBROHGS4sGOjSs36BXdpwKJmDTMM2j9l+G?=
 =?us-ascii?Q?5LJ+98gnaChn7gE1dH/pyGhEuzTIsfigA7eNvakJpFNWzaPHFczU1RgNttKn?=
 =?us-ascii?Q?tgrv3eN+wlxYuou5mj7isU3Nj9pjbhHs9iDJmgFs2KMvCbQVEH8Tn7r5Rtpv?=
 =?us-ascii?Q?W86soRzKmuDKfzdJ6vPpvCYNbUkFLg3+3dVEukcTcyaeRYvEwKTFOIv2o+Qf?=
 =?us-ascii?Q?C0jYAm/0XBU1JzR4Tnt835J8zRDWLB7E7OP1OeN9wpMSwdSBUuBEf26YyCdr?=
 =?us-ascii?Q?Qf5FUWv5jADLEBde1vA58H4hc1rB6lNiwS+Q1iVF9VbUuLhX+V1hfy3my8hV?=
 =?us-ascii?Q?Mdc1kH5HAC7uaWvkH2LQLCZ2AagQhrnXYpJaXkVK7fpTIHs+BQDMygm+CNSu?=
 =?us-ascii?Q?1IdDBzS8ggfNTDDpfXvMtgjUHTt99DEf7f9XlHtX0XaAvT4ziMROxBKQCTNn?=
 =?us-ascii?Q?E45B+bJIGM+BmYrWN2eFSwk3Xhe0ooYTNEYRwQAv0B6FqpMInuNC91fpwzTd?=
 =?us-ascii?Q?S2/I/FmAfW2zBuSPxdBlqrZKZ++XVG17mTJ7AoIjYixnfs1gC1I4lFJL4qzs?=
 =?us-ascii?Q?KZVri2gsyJPPFJB5+gDjwfqwV2aa/U2dsuITI3zkUWE5NP6EJCqATnvOVxYb?=
 =?us-ascii?Q?rpGVUt4u+y2IazZLQTaSfOw0fQu72b1n/w6csuLNrRoaXsj/JF8Aw1gXFzfL?=
 =?us-ascii?Q?/HvGKbzvRggQslzbss+OsEPA4eQA5tNGQS0o8sZqcWwrqmkY6c9V/6T1R+nR?=
 =?us-ascii?Q?VRWVHVuyQKZOqslcK/E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2b9d2c-c089-478c-6a71-08dcee35247e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:51:59.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqqAQJUzNUz869fklmZzBVlThNn3F7bUtAZQL+vwX45CTKGihC9HKXxYvk4/1zJ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040

On Wed, Oct 16, 2024 at 04:16:17PM -0400, Peter Xu wrote:
> 
> Is there chance that when !CoCo will be supported, then external modules
> (e.g. VFIO) can reuse the old user mappings, just like before gmemfd?
> 
> To support CoCo, I understand gmem+offset is required all over the places.
> However in a non-CoCo context, I wonder whether the other modules are
> required to stick with gmem+offset, or they can reuse the old VA ways,
> because how it works can fundamentally be the same as before, except that
> the folios now will be managed by gmemfd.

My intention with iommufd was to see fd + offest as the "new" way
to refer to all guest memory and discourage people from using VMA
handles.

Jason

