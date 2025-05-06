Return-Path: <linux-kselftest+bounces-32508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDDAAC4B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 14:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BA1B62E16
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DB27FD5B;
	Tue,  6 May 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfxEDdip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FC8F5E;
	Tue,  6 May 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536076; cv=fail; b=kGYFvV0zZJ8wWtvLtc+N/Y+pHcgJ9ASu1qDCHy1vq6QnLXgmlz91UJZeaFlOEJXic5RjqxOUhkrnQWLFjeNNn9hmDtmBH+fvuMbxVzAXASKTyzrO26xEc6ndVC55e5T7bxXVzZrlwE12h41t8/HOo4vhUKH3G9xYJwLX1U9qglI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536076; c=relaxed/simple;
	bh=bOXXRYDF32+QcPsQOyv1Gi/Tq0ZNNneXbXxlZIkirwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RyeKsDn0hWnrRVwE98wUdKh9ZpoEbPQTsPEQFwCbZ+S0Sbo/r67jqpmaEC0FPw1V4hfe+FBT3oM/4vqPr4klnOZqu+r2akZt9Cu38yPJKnctJT6C+LFYJiQpBoLUfxjUkx0g0KZ/xpks8Lz7JP0GbNi463mIkkDhp0CxuLFKlSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfxEDdip; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v86btBmyhTX5wDG9PzvD08DyptA8Xc9xTYIp6wpdVwoBQaHbMGTH+n25rV7hvZdh1zahqP9rtnBtybW1eMi8OPMxReksrZAbxj+pGt7RNSYcwqmHp1BAJHtS0zCXDAKxFnt3upV0PubwmZJzA9qZCSkeEaVWj/w7DZotzFoLtl/PZS4UMoFBW3ipjihGJCSjsg7In/U0kD5a52MJdDtLzP1eVSZb91mKzM288fTxaRXYm+B/lPNV5O2oAwjaFAMi24cPfxUITmzra0tUvcgPDQnQSOHnjyL2AAF8h+psxAnAVi3IoDATGqOGuTj8AkHETJZNCVTNzOWQfwLXYVb1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSds1pBsNJ/4WF1sdDZkMCdYYEW6lo/3zPHT0ZfOytw=;
 b=EViPhvNl9L+VE5Db80N7q6CzMEtw/DXvsvMjj9Mviui2Rt3a6B9fdBZ+wM2CbbPQlLUeytEfKVbbdWnTY01BDNNfVTqpDrZEQ8v7/gOsbB7Nc4c8gyRcZTHtgGTi6VKgPg0dnWSIBRkzC7z/S0cspazdel2ZcOghQN/e589HknoPa4/AzckWzY0m2E5t8z97xwd2oJYuju61j+OquY23zi4Sm9X5R+YHOTNutxG0TFKUokUT6yKNyfLvomnaAeo7RHL59c+qM9j25RGlKeeMA+rCNabKpRlV6m9QnRMf2tgAzrZ3ZI06czsPrwqzMZ/O3SpEpeOl2M9XmB/rRY1g3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSds1pBsNJ/4WF1sdDZkMCdYYEW6lo/3zPHT0ZfOytw=;
 b=BfxEDdiptu4wwjRQvktrpa8wfkZ+L/HWc/11uXMVuNU6fab9o1hb4flExwFbs3ylhSI49m8wSWRp0fyBegoRph1fUJbVKYpBc/+ZrEuZ86op4tJZABifMfk411dPxvhcmVkQDueHO7w4DN1CbSfA3CHCxUeOBfqT/WNaqrVW26tvCjwey2a3bQUYS4GGhHvFp90IMNzG6bWHjAk0RgTEvNxjfhATG+3E2qAztwgKpQa/9WDNd9pZs2WVPkQ83xGCDS5sS92nbZiBs0gaWJdBzvWkkjp0FJ2NbV4L8NTyRWFhRDt70tAcS1ESaIM2k5UBjyRT03cx7KX0M9zyXbbyQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 12:54:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:54:28 +0000
Date: Tue, 6 May 2025 09:54:25 -0300
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
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250506125425.GX2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
 <aBjzf9PrYnwF5uZN@nvidia.com>
 <20250505172813.GS2260709@nvidia.com>
 <aBkahmXQGxFC0Fdw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkahmXQGxFC0Fdw@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:303:86::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: e43cfc32-0019-43cb-6fcd-08dd8c9d22dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HDDyEznw1CV1r1IjnuRoQrJvczMnqfFz36EFcVA0WjpvBzcKCapgmsFZM2y6?=
 =?us-ascii?Q?4kKayK6Jqum+aFEOC2jLHqcc2oCU/QNM/UQ3c7wg6McwNQ0MCP3T0YpISZ07?=
 =?us-ascii?Q?XyfrKdNYmgGfjUdKTPkIlT8IqhNeCIP3Hj+bufGEDt7XY0POfEZ5lej5QN2Z?=
 =?us-ascii?Q?wRKaD2g9UxmOgWCC+jWZF9GBYIF8iAWMrDb4dJAPLmmL6WI3TEiYUnfSTJ9R?=
 =?us-ascii?Q?3Wt1dlHXyUqII0o6WLcFwQBGFNztUyQN/o48s29X62ApxIxdA7MYoKhKYH8V?=
 =?us-ascii?Q?0s/ClwKkyhTvDCF84ej+Rea312KPlzdglRxLFpeJkkRemEfT1+wkohGxYihu?=
 =?us-ascii?Q?sXtQnEyq9LrwfLyU9MCwas2gtuoqz/JeAxHkjbNJJcv9P/69z3iM0u3RIxau?=
 =?us-ascii?Q?zsy4QRLOCYjtRh4M9TQc9gu4ddx+2r8e9041RYR18TguibK16gJbCUQRvamM?=
 =?us-ascii?Q?y62f6zPI7YGDV+6TLBnGtUKPF2CFzyFPG3jDkGtsiMLYVY420n6wW0HZcCXO?=
 =?us-ascii?Q?VyDNzMdoRdgj1MpcQzF9k1bOYK6O8A9Y0bfLT4DuR7nAJ2KyFbr7yCdw+2jp?=
 =?us-ascii?Q?L5xWHiZtI2Xtr64BPgTzfQRW5ZAOG2FxcUFftmJkPm6oMRBmCcmWpfqJAK7c?=
 =?us-ascii?Q?IeDbii0VvRBnz0ESKTV9JeSGMV8DNECVqx0tL5w6/3pNOXijo7PZif6ysGDK?=
 =?us-ascii?Q?eo6WMWIhEIb91FQKId0l8l0oUWDdQeQJXDft65WKiV73LVvx+aT3C90eHYoV?=
 =?us-ascii?Q?c2CtT5RY9bv+f9MhCNPJ9DCITuqyV2o1VuSwerVnie35uf5CYlKP+qDG5Nul?=
 =?us-ascii?Q?wrU/W7+pczC+GTwGbs7gAL6bxiQpyAHD1XHOYDFf6zlwAEdVoGZuVvjBw+a1?=
 =?us-ascii?Q?YCgoRIsrbpyD9vcRF2R9Q8S7W4QakZUYA9jIf6GGfgmjY+I7V85b0SIMafdZ?=
 =?us-ascii?Q?lHfmeH/E0DvB5Rx0NwCjMc4vKZzh7CRcUqwRxKvHXir/SBBZhPI+Ev7E0EXU?=
 =?us-ascii?Q?BKVaejYgAkHmmKp32u9CXyqG3xFU6TKRNT1zrbxkU3/V+MXQQocUOhoAKXa9?=
 =?us-ascii?Q?53b1BOm/LqN2Y5AY/gBb5VT8GJO4gCtRPW95qmTedSu/aPPEompp4K1O4OSO?=
 =?us-ascii?Q?Qas5xFihH6H9/iB/0OMIUBMAi4EC2Gx9wCz7u0wYbT1G1tz2IkG8Cgscs9iq?=
 =?us-ascii?Q?I+65btOi/kgy+V3HELAZBNcEGKBE5qrzc/KELKOhW30cIdOalzYZro93+UD9?=
 =?us-ascii?Q?wXddZmN/uW9QXKQK9m7VfuCXwUEr0J2d2a+AuzBipbYtd4JqlA1+DY5Ht46v?=
 =?us-ascii?Q?rwDiurztHUIIRTM+CjBHivn+WL8J0lwqZY51pTEAgUCZDbezOKFfMbqSu6Z5?=
 =?us-ascii?Q?+a3K9dOQNMAtrDFj/FMoVBmDA8ysjFUodJr39n/LNi3zTBmcWKWDBYxmpLbk?=
 =?us-ascii?Q?ywtDufRj6Lo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xkCeGw5pOAZbCx4UP5aG0W8auTsq6Hrm5G8LcvgYCAoSxjcBo6jDUBST6Yqn?=
 =?us-ascii?Q?VJTSwTb594ur2w+8buyMpugq62FmWnWV5S/30FW/hD2uS/6mmuVeO77vJ7bp?=
 =?us-ascii?Q?vq/GmtHWpzLkdGQOhyMV6gQk/zfphYlf7XdVaFEbrgCM68xDX0hE/DbgE3AR?=
 =?us-ascii?Q?UN5ULM9bdQhR5dik2arM/nsDZqCtv3ooN4N0txmy3b0DuBQkqswZMbbALTqw?=
 =?us-ascii?Q?RrfCkNotpRzllMfzEwo2JdAObfeBeTcb7FVpWqExx5e9xZMUu6SrVp9pQkUB?=
 =?us-ascii?Q?TOrisCKHpun6w1v49c4O6caoKROOEQw43lo1H77BwLeUxok9CtHS42SHj+Aa?=
 =?us-ascii?Q?xmu2lLmL17pjOeZ6ADjHWLnzE5yXuX1w4HyVvDxsl2EjvX7Cwe9piEKYQD8C?=
 =?us-ascii?Q?yon09575zSBEoOftIWiLzT8JpTta4Dd2bSXos5WT102JUyVLJ30cOFj+1Qeo?=
 =?us-ascii?Q?DYt5hLCkuXObDKa39ivoy0C5+X40PaZAwMplrHhQ8qXPzMYxYMhRfiFQkHdU?=
 =?us-ascii?Q?oma3rAyvJO6kWqqMJRiWf3QwzRd65OdzWr97PjbvGeBe5vT4coC3YrQpOqgW?=
 =?us-ascii?Q?Bg1QYUHzpSfKFCy7g4EK4QVhNctA009vmQulbORo0VQSBFp4Fm5ifSN90P2n?=
 =?us-ascii?Q?F0IGQ4o4hOBypYXD9P05bI3OqMo3gQAEocr0d3hlp/feFi0AREa+3zJQN3Um?=
 =?us-ascii?Q?slu/37sndYCHjC1UGKqObx5n5Mspwe2OHb83iIZyS3wjCxa3ka74FlraxjqT?=
 =?us-ascii?Q?Veg6MLOi4FtcY5GB6IDuVziMsfw4elzbHDSVKmgRDntscdLqe3WG/51y0PLC?=
 =?us-ascii?Q?xjJJV7ghnHhn12YRHf1A37MJ4A9F53YmbnefnTEWzcFqMhQfHcb2/vMmfGvi?=
 =?us-ascii?Q?c9qric3zjJfsB827mejtQOCEw+xXNyr1KwO2irkzpBMvQBNpqc7jY5Un8LsQ?=
 =?us-ascii?Q?V9FIHw9sIwJa/95ar5om9b2E4IQ17PtOX4JJlFPk6ohewiUowinA0FnKYZ6k?=
 =?us-ascii?Q?Oflgh8aYyhgL+rZpIVM2l7PnKQB9HfDZHR4+19xnzeFgDMPKG7XDyABwxsBU?=
 =?us-ascii?Q?tHMN+x4ZL9kk46cK7BX7A24pSLMpjjg6AMNvkfP2RZlMADNi0fP1u6D2r89k?=
 =?us-ascii?Q?CLYftNOgrcqsytagNAxFcRe0ou+iRNeQ7qfrFRoicPoyZnW7QXo63UHX5ImE?=
 =?us-ascii?Q?fpQPTSntnvFly/DffIHzEPcQ/oyt6S7t6J+TEHZXHGk/u2GM1aPw14nNP23O?=
 =?us-ascii?Q?5FdnfqlbngTFQQX22UqmphC0CpKgyQIe4cXtq3IzNTbVNUk57netoMe8bqW+?=
 =?us-ascii?Q?XNOvckL+gDPSfKV0Atrzxy5Zz3uQB+fibuQMpn82YRgOisar+yocbWC586V4?=
 =?us-ascii?Q?EEI63W+YkMBiYUBbu7S6BXY0LuLbaT8Kx+GaKMBmoUnom+h1NMqxryLqSsaL?=
 =?us-ascii?Q?a5Ct4R3cVtBUDBHw0uN+/sLXlTU03qx0BqqWyU65F8iW5OpA+qFprGE6jD7p?=
 =?us-ascii?Q?b7Bz6yu70EdnuMegtF3pNHICGouyr2lhF/SCYFMUQt/lizdJG8SJq4WT+EMz?=
 =?us-ascii?Q?l5v6DxmwQW5NstzEju4owoEKFD9MPPmbGtpam4iv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43cfc32-0019-43cb-6fcd-08dd8c9d22dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:54:28.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0EsBVF7WZVgI2u8IIh1CFXlC6GMDgJSKaSHXPlNpD2dvqOv/vyRXuMusZ/+82aA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

On Mon, May 05, 2025 at 01:07:34PM -0700, Nicolin Chen wrote:
> On Mon, May 05, 2025 at 02:28:13PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 05, 2025 at 10:21:03AM -0700, Nicolin Chen wrote:
> > > > > > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > > > > > +{
> > > > > > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> > > > > 
> > > > > MMIO lifecycle question: what happens if a region is removed from the
> > > > > maple tree (and is therefore no longer mappable), but is still mapped
> > > > > and in use by userspace?
> > > > 
> > > > I think we should probably zap it and make any existing VMAs
> > > > SIGBUS... Otherwise it is hard to reason about from the kernel side
> > > 
> > > I added in v3 a pair of open/close op that would refcount the
> > > vIOMMU object (owner of the mmap region). This would EBUSY the
> > > vIOMMU destroy ioctl that would call this function.
> > 
> > That's no good, we can't have VMAs prevent cleaning up iommufd
> 
> Hmm, would you please elaborate why?

It would create weird dependencies in the kernel that become hard to
manage. If we really need to unplug the PFNs behind the VMA for some
reason then we should always allow that to progress. Requiring the VMA
to be unmapped first is not great.

> > objects, the right thing is to zap it with invalidate_mapping_range()
> 
> Also, I can't find much info about invalidate_mapping_range(). Is
> it a user space call?

unmap_mapping_range(), see how VFIO uses it.
 
> I do see a few drivers defining a fault op in vm_operations_struct,
> where VM_FAULT_SIGBUS is returned when there is page backing up the
> VMAs. Is it what we need here?

Probably as well

Jason

