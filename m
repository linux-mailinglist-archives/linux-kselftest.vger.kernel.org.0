Return-Path: <linux-kselftest+bounces-21644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCED9C0E0D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06EA1C22735
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8A2170D0;
	Thu,  7 Nov 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z60tyCoN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2D213156;
	Thu,  7 Nov 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005223; cv=fail; b=iDDEeleIHKXzYPoTL7N2QcvT2Ds8Y0qBc6Qgr5FONMGOg0xfZyQ9DUqXHdZLXbPk1NP1V7i6lREW1qfhpS4g0wWkFhf6aGw805i7paQz6pOB5xJ9hq1T3y6Yqhktb5YAQ3iaNFinDWm62tWvcmN92FBo9v3bKr6PI3gJLAokM3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005223; c=relaxed/simple;
	bh=Syk0ZUwgS7vyAgPGJo/Kyf80oj+ilx2cAgMxntUC1ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEJzbn4puiSJmkPB4qzmdeELbTpUlWw7JxBY8eabXhDpgantqLBGDvbGmc+ytWxareap+w5ny+KsZs9rqCIhv/Atnm+Ioj17WFOELnskFzu4z3pRY/W/WXjPIk3GHVSdIQOUxHM5Ml4H/c4iAXu62jPznhPRFcwU2FNeq7E7xnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z60tyCoN; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jElxKYV4g/TLj5EkZbc+yHPhcoPtRTSGMZJ1BHnyyQJcIvlCSfARm2sObXJ7g7Yrbg86yJ0vg7iWuJPSfWn/9c5lOsvUvKtnIFNALo2XyiZEvgifHRMcccxuYseWa+eQzPuw7XXfcBwIGg7HxlZgTQKduYNLS6H9qk0HHlN8HYBRgLNvUZUO8+pc/aYMrQ3Kikb2+xIhjeTkOsaqYv7zXtC9mq3Tq1hIuobB6BfNmRTLDQCC8MixCLRjoZlmtpFUtU9X1z1nmZO3fxNLFqGnzMlErS9pycaxw/Awf575In7bczoReL4SCDLdqetpv9x310VKUVR3PElrsZJBhGOsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhn8fB0QUAj9CI/979E0PnyuadX26hiaU7HfF8yu3j4=;
 b=QFn0Ek9h3j+DMPKMFqMl/bRZMqOEYdJzBbtR781CdSGuos5puK8KMlkAY+0fixethsmw/KQ7F+cUonys0jktww35kL89L8x1EeZ8Of1xbLi55OvzPpbj9W7Hi+iHLfaj7b+7KE9MAoOZ9NjHuBEr+4Bbb9rB6M82q7Pe9Br06/SdZv7rPi6e3DxQLNEF/3ZowJGqAq8HUbTQq0uOtujKfGByfCgzS4XND4aGs4rVqySRbzGjNl7ZSn6bQ0IeT89mRW6sGKl8lqG/ybLYwr5Q9jLy/Dw+IZ7meMrq7z0TrB/z+F12Ca23oDwETLN56bPe5ZlVoXF0gOP9Tt8DUhpepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhn8fB0QUAj9CI/979E0PnyuadX26hiaU7HfF8yu3j4=;
 b=Z60tyCoNos40y3Bbn0CJgt/+dQ3qLziNh74pv6uB/EGlGgW3T733v/R+NGZafVIjjNXbHa0Fvkaix+wW5LW6IYcbx8ex6xHDLgi09iu36nd5o3aWrDWj39QFIEx/s8OqYVUq1uoRJmudUr/P09n15VWyHzpkCiw0LcvpP8eXGK2gC7cKxQEly356K55EV5876y/pzQQbHALt7HUl0jG4xDuBcfuwHsvwhXM1RR/3AFQv0T+Vgseooy4fFYhLAOfPVy4Ga1dMQ1/uiZLlvO3dl4qLyGGx8VbevBbvY6zR0TU5k92d0vh/OpNlK0o+mNGT8ouuvsYJX9cnZrOYMZOaWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 18:46:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 18:46:56 +0000
Date: Thu, 7 Nov 2024 14:46:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
	shuah@kernel.org, iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 05/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20241107184655.GB539304@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <5d2efe229821f5db7a832d9d6be84217289ac3f4.1730313237.git.nicolinc@nvidia.com>
 <40c1587f-a6af-4851-8632-cb02adece66b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c1587f-a6af-4851-8632-cb02adece66b@amd.com>
X-ClientProxiedBy: MN2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:208:23e::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 91524c1b-b30c-4ef4-d4d5-08dcff5c8dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8UmmQsdu0MZPKUdIY322K7Oz36fExXh3FOQAyFLP2gtwXU8g3Qo72/GBM4E9?=
 =?us-ascii?Q?ZSvIiPyHihUpNoe4wHTVsfBL0TxWlJk9aYpYDK0joziyhg1F/jdqx4nNYhfg?=
 =?us-ascii?Q?5PbsU+gtpDInZmLvOpMLUMDUvN3yGyHm6H51c8EbdEGVd1erCg+m75eR4rOG?=
 =?us-ascii?Q?EYRu6RxihTphKI2nL9Ux9aeVuNeYLNJUJXFeeNNph66UMrpzMH5lwn512Qvv?=
 =?us-ascii?Q?aZZluQLfLTg33WTNlL6vFVIZ3JJlQ/ASkmJyT31YtGt7H3FiTUa8WpLiDhCE?=
 =?us-ascii?Q?mlnnIqC9EYRhLecmN8jBT8ya0AgNUKDxgvB6h3ptNUEg2FbmgICqv7DnqySn?=
 =?us-ascii?Q?wUS2Jl+6HO9QQaizTKwEvXQhy/rvF+1vKYQwRbm6oBCeFlXpVzCo+rR0PWeY?=
 =?us-ascii?Q?BfArIutlg8RJkEONqPum42e+CZ1rc8ZeczukPsd4/GmZB9+FiJHzDMfB576l?=
 =?us-ascii?Q?pys6vU5QdM65ZzNwtUn1eVb3An+C0GCCt9NtYbkzUA4rjxEAZorCVFG4904x?=
 =?us-ascii?Q?fzk82dn3FANtsJJA/CcxW1llc7EDMNE3pKVFLvMx+ryCeg69nU4sae14Wf19?=
 =?us-ascii?Q?rSDTujyvQEa53dsMnyyLGI8/yQGvbs6XGQus8DaSyOc2UKA/ge4UrscxvpBJ?=
 =?us-ascii?Q?HqS2gfOnIuWqVd5LpbR88i/5YDuGPJPeAH3koCnFxR9My9Mg7aSngbodQq5R?=
 =?us-ascii?Q?oiv9O254HG8YyrfG+F3ZrUUtVJzWx7wkPE73m5T6a18tEZVrG7AnSW0rZFsX?=
 =?us-ascii?Q?UHrmKxfguE7ra1pVOqHoxD88EEPHmb2Ds5NHELRKo3H4RkNmHF3z1Pe2NbLB?=
 =?us-ascii?Q?H1vS0wPrAYyWiK+OhWuzx7TE08vPTM9c7UfuEFoSszlssUyNQMmWKN++uaFW?=
 =?us-ascii?Q?HacMxuLw8muFbJkPs2USarX8wiWn1kzY/v92z1ZShffaqqHT59Yyg7Ew44Uh?=
 =?us-ascii?Q?hb/M72iGgODnuE2x96WhnMsX9h0IlbDVIf85b7hZzp7hkCzSMSWnqc9gCD0i?=
 =?us-ascii?Q?Oz28DHLMLA7F05mW1/5e2qbqla2EoKDRE3Q2hW5RbBiFOssrvssejXL8q6u4?=
 =?us-ascii?Q?vACc+Fp1wiDmSSKo0nIaQMXZDne8kDTX2qdqrhjDy/i9vdDNpvcGVDKV8TVc?=
 =?us-ascii?Q?atjuVYhIm+iFCQMwdDEdJmMp7/IYTqGjkvPZaFysWRKX8AGUXLtKxSYunPjc?=
 =?us-ascii?Q?v4v+yyD4rrDtk1DVZTn4+0l3A3sB0vbKvr6WdcZIeFT2ZbSek41Zz6RSuMil?=
 =?us-ascii?Q?5BIM/E3XRAPh6Lj5vnt/MT7SXECmEhVfkTszVPfxnPF7gyWv5LhVUpQs9Jan?=
 =?us-ascii?Q?hoNYb9KDhXoATAvK58ICS86R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZrI0p4Qjng5f3hqYCW9qu+wfRVqxklL4edHNvjN8JjoZvv/8tAQZZfrzKv1?=
 =?us-ascii?Q?XW7fhqE/7txrR4hYcxcbT/A7LVwkL440RGbKEd8o654HJURj0vf9igE5pScV?=
 =?us-ascii?Q?L3BZuxtS2fvztinHYq/8ZCJxUhIhPulMZDLJ+B1tVOLKDKES90zbWiW1aPrp?=
 =?us-ascii?Q?uTFRnuJFrDNcTHLVCd1r88VpElJmhUWauMlsFzmcNT6ZAaHS/G/2f5NJyU1C?=
 =?us-ascii?Q?FKKABqFsxMsNZQ/UH71uqlaS0aYk55koBRycTWGyHlxnlj3qOemWC9luErsE?=
 =?us-ascii?Q?c7qfsR+Q1HAPjEgZOFdxoUtoUN1NzN87KZh/P27H+lme85qTpqEAZ8U1zEMy?=
 =?us-ascii?Q?dutfuujFzuyYK7JMMeR44+TMgJUZwhmA+jf4VsMpBy6EwEoPM3F+nlPNAjjN?=
 =?us-ascii?Q?gsGwzzZ6d9DarHoil0gY+KpUw1UAdrFUuSFaSTKjfBrTqsA99rca7r9+9sZT?=
 =?us-ascii?Q?miTJfmCfbOCxpcKQsfmfEU2Stc99iOmqdrgTbW/a02mILffj+n/gJpBFl8cS?=
 =?us-ascii?Q?ex5Nfm+fPMEQ8TwPTJerkvk2pNS6lkQruN5x+C1f/fhu3ud4cTzA4yUzfSUq?=
 =?us-ascii?Q?Q5w3qdwheED9RyNBTdhNGUL06UQkMC2RG0fuDYl5Nt5tTc77OKFBD5dCH1c+?=
 =?us-ascii?Q?zNjYI27aRfaJ75UlNREChDknnmqXJUuc0lPWF++oTuFnjbmsAP6ibP0mlm2I?=
 =?us-ascii?Q?JZcKHcdT7KlqgZ4JGs1NLB3HvsORp8Wjx3zHLohUyGhJve3jdFJlRtBalDas?=
 =?us-ascii?Q?PpEFPJ/YdQDDxoM7JirSpeHlq/ebKPVIpd0pC0y/6sY/UND9PFc92CEwTEl4?=
 =?us-ascii?Q?Ns9j5ndN0sASs3eiB72R+9Ptp6yzIyOeG2X3wP552JiotjxI3Wi2o93VNB+n?=
 =?us-ascii?Q?0hd+B/6Kv0p1cLrztM3cLVjRJO89dZU+fu4hhf8SbSn9Ri+D5KBw9VfZMuH0?=
 =?us-ascii?Q?ud9PF7bv8Z/6E13ayrPN71fHh2nUtRARaBNOM3gXsPHURJJRMbGzaieRRhgC?=
 =?us-ascii?Q?uaSCmARYSh77Jf4rZbLb/r9DvwuD/xymHKmi8DCWf9k6ciH52iX9Hj1PuxDH?=
 =?us-ascii?Q?41F8GeJ8WQTSCKlKZ9gFJ1VBbw36PAzgPf/DWb3uPSRvWLINC40RFYQQ3qD/?=
 =?us-ascii?Q?vmtTUkU3UywVr3XH4CAcU7+Np8Pko5++PVk7WhxTngwkIeU4qoJDLE+K9VBm?=
 =?us-ascii?Q?Q1wGcEsTb3UNIXn7bpCt3WA/3TvC94j2SFt5Cet7mfO0yYlbZfNTZ/eF6ZmW?=
 =?us-ascii?Q?x95LQ9JiRbkF8DJh6mrrkx0eIS8T/yIsYkMhBFflRVKckH2SAUBXUmtrJULQ?=
 =?us-ascii?Q?3Bwf83BZ1cT92AAaKuHCpfttFr8tl2oWAEYfwcE8g4shwz+TV7EyvBgJq+ri?=
 =?us-ascii?Q?D7j4gaOP99UxoEyZOXor33J20zwU8w260KlTArsrYPe5iO4d4HpXOTTe1z3v?=
 =?us-ascii?Q?NhzJn7/mq+lrGKbhR2fggj3qWJ6TBfQvt2hzyiLkn3VvvaociM4nESDZNIRu?=
 =?us-ascii?Q?bFTgeU6hmMGaVHUCqfzFDxY2acq14zuKiykvKXmE4l90atjiBSbj4Fj2MdS2?=
 =?us-ascii?Q?u+N6NflWgG1UAfzCQ0OVCe9vc4GO+gsn7HbqbJSU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91524c1b-b30c-4ef4-d4d5-08dcff5c8dc1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:46:56.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+VCx5qHarrrJqbiaf2GVXL485retQQj7EF8paX8z1ix09QGy15eopTwImG7QMwG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

On Thu, Nov 07, 2024 at 12:37:59PM +1100, Alexey Kardashevskiy wrote:
> > +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> > +	if (IS_ERR(hwpt_paging)) {
> > +		rc = PTR_ERR(hwpt_paging);
> > +		goto out_put_idev;
> > +	}
> > +
> > +	if (!hwpt_paging->nest_parent) {
> 
> 
> I am trying to use this for my so-called viommu which does not have this so
> this fails. My viommu is only visible to the VM via paravirt interface to
> populate sDTE (secure device table) so no viommu device in the guest or
> nested paging, nothing like this just yet.

The purpose of this is to define the translation underlying the
viommu and the VM.

If I understand AMD CC HW correctly, you still need to have a
translation to make the device work - so you should have a
nest_parent.

For AMD the nest_parent is simply a v1 domain and, with what is in
Joerg's tree the AMD driver can quickly be improved to support that
allocation option.

> Is there a writeup somewhere about possible uses of this
> IOMMU_HWPT_ALLOC_NEST_PARENT? I'd think one pass through device equals 1
> IOAS, 1 HWPT, 1 domain, 1 viommu, even with guest visible vIOMMU but it is
> not the case, is it?

It is intended for HW like AMD that requires selecting a special page
table format to be used on the hypervisor side. Ie select the v1 page
table format.

> btw is there a way to get a snapshot of all current objects in iommufd? They
> all use "dev_id" and not file descriptors so cannot look at /proc/><pid>/fd,
> and there is nothing in debugfs either.

Nothing has been done, a debugfs could be interesting

> For my current hack, I can pass IOMMU_HWPT_ALLOC_NEST_PARENT to QEMU's
> iommufd_backend_alloc_hwpt() but it is... meh. Thanks,

This is what I'd expect, yes. Qemu should be allocating domains that
are going to be used as part of advanced virtualization (viommu,
nesting, etc) using NEST_PARENT, AMD driver should accept this and
enforce the v1 format.

Jason

