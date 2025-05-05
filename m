Return-Path: <linux-kselftest+bounces-32390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F7AA984C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026D316A08E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7025D549;
	Mon,  5 May 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYcBjuws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265704C85;
	Mon,  5 May 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461162; cv=fail; b=pk3S8UbcR26VIxljJboTlhrmjuleqgPvRkNNYfiQ5g2NywbgQnK2bMUsUHgwH6CNlCez7+XtkcNx52hezTxujHHn8x4R/B/U4K3xB1OcjqXpZvDroXyDDuATeysJfZXvHu4OucFsef4G1rDe5da52pTkxGCYPupXPGnC1ac1eEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461162; c=relaxed/simple;
	bh=mOZAKbxJRBjDnamJFHAFliH11Lt7yu81jUgt+Tt+yJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j34e8kJ7eYwF9NyFRm+qNBZBzDAdU0m0vGZgB8jvBlc0Be1F0SlzaqiiI0fDEjZYJRGfPSJgQcXBSXyasjJf81Zz+Ks4r2SdVUWYicGbjYXIWdUhGWLJYD6huZ8e+jMVU1PnXUQ24mB+e3ng0aP+fakjEMdwk1fTBiIbXCxnSDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hYcBjuws; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5T7FCIQ0SYMYQaKqFylAgj5YHEM2gqYnV7X9LUSTCtrJzC08Hqd5+uRl+3AoBDOtl51twizCuQ5ZIlTQ1W8qOij1vjnVqmk/AE8Bymvdd+El7YzSr61Fp3LRaSNO9wAFjgy1+1rVa5MMtfoNQbqDIwZ+Zh6hnvcoesDlyDF43he/gNeAN5XeUYnvtMU8BD0nKIBH0+A2dJuN9x8ii26U44okJnH2aqwAJg7gnUJSpA4RmfdhfTkWFMtJ2Ch5NMNb+lT/RIeuwINFfqG67TS2EUYYydQvquk5y3m9l3yzKeiwrhKLPI9mw2jq//wXLf2x/ILCxeRPupqcA8hVs9gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RxfuUEyilpvA1aiw1AHmhDx9PRRCPN5wkKDnNFLQ8E=;
 b=n1IshCtepKhg9vB8QeJfhkPQ4Dhj4v9VL9Vv9A+dpMsrBo9RqnEoMLb2p99B3WGNUi8fpqxvcXF7P70ltNu4IszzjB0F5vuqU9FWBuIu6B9JA9SOhsglOKtyG97bzi56ySV+P7u2MEgVupWgTg8Isjy+qI7fTRGfqISfApsAs3UHb7D2jGMH/yQZVc5d2HDeKHyaxwHtI1nt0Gafv9zPray2DQk+EPwii2vSqX4gUrLKrZ3hxJGxyX853lBBaHLNqgw80CszopFyxeDWK0ugr2BvYy/h9qSEzx5c4rVsF9vBkcJyaPQL653lKgB1IDp7eb0J/39UYwNbWcmjpdOhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RxfuUEyilpvA1aiw1AHmhDx9PRRCPN5wkKDnNFLQ8E=;
 b=hYcBjuwsMFuXWsn9A9EjAxvMeZ+cPKXTKzpDWe5XUm6bXC/8Q/2BWbohvcWtKCVO3/uIDzkwzJZRC/rkatWlUCT5U8qVPrrGO65NgDSXbIUvwufTKsSFqCtdcuvdG3+3pOrq+PHCnvCxr76maAO1YQKPlKO/YXUm86FRbfG0tgRU5KtMWsc/ptW+z65lcjqqLKNpPYGhTERcuG2sWpxuBlFIGpWDR76XG/VU9EkaVtNefFF6IKWnXKSqYjpv+H2a2T7Cc0niSi9+huFE9zqF2SrqYwO65/rk6eQ6RWxF7rDye4bfgttucGjXjGwD+aQLtulCHOhzDA2lGj0Vj6ShwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 16:05:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 16:05:56 +0000
Date: Mon, 5 May 2025 13:05:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <20250505160554.GL2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
 <aA+92fNNbDI3Qowk@Asurada-Nvidia>
 <20250505150109.GH2260709@nvidia.com>
 <aBjc1ny0Zs7K7gDX@nvidia.com>
 <20250505155505.GK2260709@nvidia.com>
 <aBjhUL5/n79cJ17f@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBjhUL5/n79cJ17f@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bd920f-9f7a-4da1-4dd9-08dd8beeb7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29ZperVogAOcK1l63Jhic+/KVVJhG0UYtYNIAftJfgt6nXVt2u8V28fVPSAa?=
 =?us-ascii?Q?fD5XDfmFfTK9kbQKwl1CWRZseVX4ucu9ySxUaam6LDaxUiHktVOnQ+VwYzsm?=
 =?us-ascii?Q?ykj0MtbtN6qYPcAMJj7m32vZkMqihGXW6VfOLi+IYcmSXOaFLhAfAznxseeE?=
 =?us-ascii?Q?C2ASTz/21zU1jYVIhUpxgRKt/Lkid+BBFyIuz5xrKP5Dv4eKTPHP8lFDsWGW?=
 =?us-ascii?Q?BwiTAkYGD4N/J0QaN9S2TDxnoP71ff5nS2aYUi92mTNPj3TOq4rNVtNgpQ20?=
 =?us-ascii?Q?ed2YJoghwuETF0nxxUuhl96sAHjkOFOlTKCfFXYN0CFyWhLRgSPej9sa1CoU?=
 =?us-ascii?Q?+GcxA+FgPawSwPzfd6HQXjRA43Yh/L89tPUPpA7/V8vlim8B2KzN8v9H0D7q?=
 =?us-ascii?Q?Dzk+T7MqQSbpALxVUAz3eCFKJKa22a08g1XJG9PP9nGcpLFUMLWJjspikRJ6?=
 =?us-ascii?Q?ICuyNqs1yJp4zDFcDqqhWO3I8dGG3igg+j2v1PpCQDw1sFPrpTuGCW2VlihO?=
 =?us-ascii?Q?9A8TpYdcd+RtOzQQrMr4QhZnbGy+i/KYitWOpjHkHZnZhtVC20AiZqi3topG?=
 =?us-ascii?Q?jnkkl3+WwngXWpJzyf1JbiFQBlygf1zH0AtP5zFnxmoyI4oTvPsHIgqzfoUx?=
 =?us-ascii?Q?sUF1+YrvcZj5GFHh3ICAnyQvsLPk8Nkop+NN8eH3QSUqD7Y5mYW/En36rfgp?=
 =?us-ascii?Q?C3XEA68Qb4BeEiQtVMJd5C98Xvj6o1D5bRlHvEldHbCnsf1NxcOuzLH/lx7L?=
 =?us-ascii?Q?Np0BDeALXdtsO/aR/58xbBeD2HKZkDLU2i4wNJNwcWHcmOoJmyX6882Otdph?=
 =?us-ascii?Q?FUNMfFTUqwN9ITj/jQcPY1ixu8vRfzOvS0fg7ixucR/15kNyL01JCRU5/g5W?=
 =?us-ascii?Q?oCFb+K+ywwFbYqro/W4+9KV+P3H76/vwB69WbFQEq8BzRcK/Bk74QRlcK51r?=
 =?us-ascii?Q?oxwKuFolnzict3/qkhvhct7pdo/VourD9qb7ZVnE5LYux9bX7gIawLvh/8wU?=
 =?us-ascii?Q?keViCKtw82CDtBLNOt1UoSGMqEPNyCuuBqH0FkJ5gY+k5Sf/u8YuK3X5q1hv?=
 =?us-ascii?Q?5fEGvn0EOKYajrtoA6m4vyH5y4ks6bgI0a0eHEXX/NtP/Gt/kqFfcTj4WYzG?=
 =?us-ascii?Q?HeUfXdSa8acJJmGKV1JiqP0S7H5jZYcI6rfRjstkjHGytzUrbOhxZmGf+LNT?=
 =?us-ascii?Q?JCC8GSHsit42faaFFjJLJj2OsTuLZ8GI9FOvQ3CM5ImkkOu53AJaFw09fD4x?=
 =?us-ascii?Q?DBCQwoerTOVFbFlIxFCaS8hUlV9lOZcXIRYQ0cOFesBukalsgWlsvKOacMlh?=
 =?us-ascii?Q?mkPu7f5Sz4AhmzCZ3GB/WP/rRxV14tcHYydyUlqLJnNdBd3qzfEkMP3OqGG5?=
 =?us-ascii?Q?fJuwAspG02xrO2QoW2KNnaHq4MXxpWRVLHsvq7ama2rDZdftQz4CkUXXUlaf?=
 =?us-ascii?Q?yy+7eQrdmus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2Uph3dM+p+VOPdtl/9Wic6fS55WgsFVTdzQXYagaMYoLijYqJSy5WIogjgN?=
 =?us-ascii?Q?R/bPPWbM53JhxssmPi4Gs1tFu/KlSb3j78W+hW8W8naVFB7iBPU/88ArXHiK?=
 =?us-ascii?Q?bXw/zwMTEzOfbNfvx2MMqgXpaSzfmWx5WKWbT5bez1TYY7UxTUsJTXfdfDd/?=
 =?us-ascii?Q?iKiEo1ewrjHj99VHrfAvD2fiFft7UtOa9BHsJ7hPJyW8xEj7PMy2bSsVEPL6?=
 =?us-ascii?Q?g1IjR9rB9tod3VIDic1SfD6p15g3Y2kTK3vjLDv0WNnMcsGKJrArcaIONt+y?=
 =?us-ascii?Q?IAdRsS+CFWE3IE95FdrqwNXprKe2z1mWvqib/WCSTxNorYkhKkxfzGrJgTpw?=
 =?us-ascii?Q?2OftmdwpfXf6L7oc5/M04QLDziWNUC7dK9kBFqQV3WBDcNkXIu+g2Rf4kzD6?=
 =?us-ascii?Q?8KsiyUxM2Ehk25yXDqS7H+1OgXJ439mT4Zradf72pMQ+eM2OtWzWL2s7Zjyh?=
 =?us-ascii?Q?O5G9gJzvaIFEoEcX69ppvgsc9lHCySkr4NFUU0GSos/ATnjzRPc24qtnsR72?=
 =?us-ascii?Q?EgMSPyU2lyKVtogjoIlDQ/5Iz0iylnuU97GpWktmAOBFKPr6/di6qx979XSu?=
 =?us-ascii?Q?EReea+zv5tfWaojk5pBMF6adui/os+Tm5BuMGMl1o9WfA7xCiY0sWRXASevu?=
 =?us-ascii?Q?gbDr1G8OtjgkttVnMoxpEOdy3aax1bZw4xdZHXgmGLMJkJs6xMbj0JFLmNE+?=
 =?us-ascii?Q?5rSEkxTZIfc8OlRSC8zQWjW+ZFOXvTZv+ztk/DS42KiBoLGoinzuXdstbP3f?=
 =?us-ascii?Q?IvLuCoeDByfS5qdVAiDvTcJZzTz/I6dbfS87MyIZ76CLOQT7FKT7FD/fnUT2?=
 =?us-ascii?Q?IUQdwrIJtO7QNr22quDNd3+BiDhMcVAWZtRgJUx5RbKJcwSmhf/5l3XB8XFo?=
 =?us-ascii?Q?2bzmxLd9Mi2xV3jJVrO7HF7HFYW2LJ3Ix5UBnxxJ22n9SZTNtd8iNJCultT1?=
 =?us-ascii?Q?Ssk6NrmP5sIZJ5T1HqN33jIcIzRBwQ2P4SXv7CkHDXKKc+1x3+t2ZOycqaHg?=
 =?us-ascii?Q?VEi5hs+o/2jwbDC7uvWy6Ad1WDo5dXbe0VEXyLzQPciZfORUzTFXTthvnRDs?=
 =?us-ascii?Q?OMPp7wqNTmQXK9cG7WsIbQdjzC5BoxJdo7Xwf5/CzDQ7XLUnovJtfRN0bRG3?=
 =?us-ascii?Q?9VuYlx1mmTKPlN/uTV0q++4DmJaMWZNM58wAu8xcqIJLySFhsJN9D9WmGz5Q?=
 =?us-ascii?Q?59zPZ0nugpu17KZRJDTc9nIRD/Ifw94wz6UsX3M1cu5PiiSkNn4UjDJYnq0D?=
 =?us-ascii?Q?pCeIAg5fuJU+6qz4gnFFXT5y8oRKli7WpV+EbbNZbjeCJ/2lhmz/askM/jai?=
 =?us-ascii?Q?b0Gl5slqh7mzn3Z5K2RKwHJUhIE/kWaB+vSDJBBSOAqgRaEhkIq3PIJE29yK?=
 =?us-ascii?Q?fLvURx4vM3+7TaCK+wgKbeB0mo5V0IMHA1fe3y/1PZXLU4w7RwiOZ5qYxU2P?=
 =?us-ascii?Q?FhqFplzu1tD2CahJBFo8WJI8zCWirV3SbcwOFWAGe9ojuIwnJMxki44Ysnqd?=
 =?us-ascii?Q?TcoBu6uKxnUXTE8JEvePnS0TXOZ8HO9kzAafiy6ex0GUE8m0tlZquKBEYzIR?=
 =?us-ascii?Q?sKkFpzf3qE0IUTKcom1owrJgkOcwtVKC5lsCkK8Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bd920f-9f7a-4da1-4dd9-08dd8beeb7ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:05:55.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZloAT/4oMbMCj6QIcr10b+4AZNr//5IzArn0PPa1ZCzCdy+VjqWYD2CyyqYPl+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

On Mon, May 05, 2025 at 09:03:28AM -0700, Nicolin Chen wrote:
> On Mon, May 05, 2025 at 12:55:05PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 05, 2025 at 08:44:22AM -0700, Nicolin Chen wrote:
> > > On Mon, May 05, 2025 at 12:01:09PM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Apr 28, 2025 at 10:41:45AM -0700, Nicolin Chen wrote:
> > > > > > I'm uncertain, but perhaps pr_warn_ratelimited() would be a better
> > > > > > alternative to WARN_ON() here? WARN_ON_ONCE() generates warning messages
> > > > > > with kernel call traces in the kernel messages, which might lead users
> > > > > > to believe that something serious has happened in the kernel.
> > > > > 
> > > > > We already have similar practice, e.g. iommufd_hwpt_nested_alloc.
> > > > > 
> > > > > In my review, a WARN_ON/WARN_ON_ONCE means there is a kernel bug,
> > > > > which shouldn't occur in the first place and isn't something that
> > > > 
> > > > Right, so it should never happen from any ioctl path and syzkaller
> > > > should never trigger it based on system call randomization
> > > > 
> > > > Is that what this achieves?
> > > 
> > > The functions would be still used in the kernel path. So, I think
> > > we need to retain these warnings for that. But given that an ioctl
> > > could trigger a series of WARN_ONs, WARN_ON_ONCE is something that
> > > wouldn't bother user space a lot while it provides the kernel path
> > > enough info to debug.
> > 
> > No, it does bother userspace, we must not have ioctl triggerable
> > WARN_ON at all.
> 
> You mean we have to eliminate any WARN_ON in a call path of an
> ioctl?

Yes, not one that derives from user information. You can WARN_ON if
internal kernel structures are corrupted but not if user ioctl
arguments are bad.

> We can drop them, just that would mute any kernel bug.

That maybe the right answer

> Btw, IIRC, the destroy ioctl could trigger some WARN_ON in the
> remove() when the object's refcount isn't correctly decreased.
> Should that be a problem too?

That is kernel data structures being corrupted.

Jason

