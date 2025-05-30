Return-Path: <linux-kselftest+bounces-34080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CCAC9470
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DCB1C048E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFC23645F;
	Fri, 30 May 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qou4YHk8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8115D235065;
	Fri, 30 May 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625148; cv=fail; b=eHt/tJccj9SK05KI/Aw522juFdgLth4DuN9TJNahFvSaYJmZZDzOv1Q3hhirQSi/9ckWslciWGgfwx8j9hA5s+qqSqThPGNSuorjpSLYo1hNbKtWIn5Z9dbWJAE/QoL6YKqcD8Y615T5nKNGxfGAywBZxZF73uCK2DbCeVA3odE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625148; c=relaxed/simple;
	bh=E7UhMzs4+mpZ4UhvftqORNtRMlNZJgdAS25/IdqaPkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VDbUTBpCw7IH8YZ4zE59q6Lq8Y3WfvfSLJcGpqcrtRWHdZxt+6QzrEIwtXGccgeKFayz4AJjcZW0CWQmqUxuTkt1ZRdTRUnFtx3+f8vRok+38R/06r+tdGc02bstXAw4oY2+HAQtyyqfU23zGuh11VjdtkOTlW7baXFs3s1fEHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qou4YHk8; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twXjf4GF+fgqbwJNzLHgAFd3x8gA0VFNHrBmAmD0U/TH2cJ1k/KBUMgyanFXJe+2QBDvPh10K2HPTNnHAX3AbGDKLfAtgYncGrHSZ1zpzx+W1KCipN6N5qXq4RIf6ADSpcVGCMQsTXPagR7VceF1c9OgexhWmiF6KW9DjCyAvW1YF+iYRd+TsOzQilfGjeOHMWdQBnA3HBRfR72Z0/VYwEIr+k5bp2m0sTOcmUvCWu4Jd8vub73pr3M2HLLR7DAQULhRDE06OLZZ/jMbH05F/8apCV31QYEAy9LVWLzQNJMmCbvgnttf4rFbeMum4z9Q0fHtxJaLBxz1IRP3AXV4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW7L4fE9+KbllYHJo9ijOMcLTCXv7Dv3wXg8jjyVTsg=;
 b=HM4KxRs2WGJeo915gxAL3Ul9l4aO7A62NMsqdDpmIYVPPh1n/VAbivPTYiW01s4CKZ8AU84AdrrelVnIQ1SKCRgYIXyPmyh3ebFvwO7orG8duqfLu1vpjGTtsOhGETEYmWXSyZ70yh926AG+DCsSknwPElpdLP/T6QQpGf5LnSX+AQ97ZNKghC3M5Vg8Xjrxt/17tV3NrzL3u9ONbnDBpA6oveGG3EpspE/LqZ+T0Sh+5wB1a+WEBnPKpHErUr7cRt4Huwgbd4+KMeSvpSdMmCAO1rbFDHf4TXtJ9vR/to+xGPf0Cu2egYeaVMgh+d/N335FORfSgPsNvHOGADrBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW7L4fE9+KbllYHJo9ijOMcLTCXv7Dv3wXg8jjyVTsg=;
 b=qou4YHk8QH2haAg2fGyOOAfC7R3Yhgyp34vDYSlnPf+3F78kC8XJ1E3yrUVu/JxPnoZDbpgO184idkaLPw68+j3aMBTdOb7QMh9QqJ/dhw/c2rJvUHbQv4s+2PInFHwCFmg3CE7/AHKvnvtDoKl/QeQItTMcsIJwlrG+zHOCzF8npZPHOamkXBMRhNtB4MJl0gHLwjHALLju95RXJEiM/Djmk+i2SuZHSzGE7eOR49oAzFucZ7A8gBgJlStga7qRCBVLPEY0rOMvFN9wo3uP5pYwj275BdNg8Gg/M82DKORiChrjkf5soeTKBZTm8woqxGz0UVgkjb06Nu8nHKvlww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Fri, 30 May
 2025 17:12:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 17:12:24 +0000
Date: Fri, 30 May 2025 14:12:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 17/29] iommufd: Add mmap interface
Message-ID: <20250530171223.GN233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <769a7395def9f68c1ac684fa08a0221957e0de6d.1747537752.git.nicolinc@nvidia.com>
 <20250530162945.GF233377@nvidia.com>
 <aDnj+MD0LexufNX4@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDnj+MD0LexufNX4@Asurada-Nvidia>
X-ClientProxiedBy: BN8PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:408:70::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 7299448e-6ca6-416d-fc16-08dd9f9d256f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJgNg/eaSo7UW7YT8agA52htzU7dvhWCxuJLiCXqBB77l2XhIlF9fPWynB0+?=
 =?us-ascii?Q?cs0O5tIzZN+wM7rPFAFp/kUXMMs96AGsGW8FdrkHjc/p04G5mTi7jqu5uZ69?=
 =?us-ascii?Q?Aq17HpXz5wPBfA6yKGt/KLkkeBw4ije0xk/2LOyXVMTRnIriV+tPpPZH8ASW?=
 =?us-ascii?Q?SFdvitY4FHYZLdnfDhKtdhY36JO/KsFLYCELW7YyUh/ErmFS3d0Stuz+6vz5?=
 =?us-ascii?Q?duMq/jPB4Dg2vUmZXC+ExnFH/JuFFj9xNPy8lCJCpmiUpyCq53lQe8MjzxGY?=
 =?us-ascii?Q?qgfTzd6++zYcqo5yIHdIR/5+g06peTur7fA22TvADQFrDzwNNNuaXViojMvi?=
 =?us-ascii?Q?zcNIRw2gd76b4bW5+YuxanRCHxRSyGYuM1/m6Cra+Esaad64hIo8ur5tWJVo?=
 =?us-ascii?Q?1wOIIxzJIbLgFH40gA7+vO8XAUGSH+xFmKelX3lcG8RFLx4E5ew2EBn0RFhI?=
 =?us-ascii?Q?CsLhQ5VxGBcbs9OhIxY0szZ4Px6jEH3ITlzfd119iO7VwpM/eK9OnWjq4IY/?=
 =?us-ascii?Q?5StHrS1v7HRqj1j8p+UjIPb7CuiOJiUF62gsQTaDJonJ0Rs5IVIVXhK+FPa4?=
 =?us-ascii?Q?JWQUCRmopS8zJ7TtrDS1irP0GitSy/3007pN4UGWMQV6GIKwj/BuPt1PDvc5?=
 =?us-ascii?Q?BkHVF1UOlT9S9bf9yYMxZawVGuTK1jAsrJlhnAGJnIm9LilQZLLpB8uNOxX5?=
 =?us-ascii?Q?/QQAH1m61h/dsRnm6L4+AvKPZVVfN+CtWV+UG/3IEQ3vpJv64voRi1tWDYFq?=
 =?us-ascii?Q?e2t8f0v9m5UGklPIAPv1NrAJMxS2ePhRDLGDkO2snz5JMgI0W0vhwEo7FADr?=
 =?us-ascii?Q?Gz3SRvrPrjIzLJO/t9pJdgHVyzUH8veT4kLXhYX3UP+3x8A8BFs+NlF/5pl1?=
 =?us-ascii?Q?l7Z0TlCUPrlNS3TAkKPxotcyknbmZAgq3qdQAA/FZ6/tIjAQyr/iQPcLFH0E?=
 =?us-ascii?Q?6aS9h9RVIs+nasDlFxYE0NozKjudK+UJ6I60Addx1HHBpflqpIX/kljuLwce?=
 =?us-ascii?Q?suTzet0nu/vandVHkOxhhBWP6Ee7rGZ4wa+VHF3Xv+T2lGcTC+81l/rt3q/d?=
 =?us-ascii?Q?1gmiuczmYrjqRApjRv3kWh4iCSuO3mQm3XInYX3v+DBT/SWBXpxlFj15rZI1?=
 =?us-ascii?Q?iwVsNlXYdBgzqUaUZM2b3ehZFCnleR3SzdqjtXliPc1NCsALr5VAvZeiFUMY?=
 =?us-ascii?Q?5vHn1/yCKnMoISVn5ONhVXp8ZjQM25xUWolzcdc2MIEb6KZCwVI0qMUw/Xwf?=
 =?us-ascii?Q?apnIOGl1N+enrDV5Rq+hTHT2pZOnncgO38+F/DPiOQg63sBBc4aFK6kwsQxr?=
 =?us-ascii?Q?Id8cNdP07QRVGUXLe65Mpzd8MzEAHi0eRCn5A3LPoKr6HhJ0XOPEx4DOk+tU?=
 =?us-ascii?Q?RHZZ7m3lYvrMzeRQVhqDCAZirSW5F0JnXAj5QvYqmqYJUsd9VB+VJawB6Gjo?=
 =?us-ascii?Q?3PtLXo0JYwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mv0R8ER4KYVTD4DaptH/OTNVBTwlg5OuEhijsdk7VZL0FZ+IkkhNLgNcqtbq?=
 =?us-ascii?Q?2IHSZmp9wc1w1i84JhKti+amK8uwn/E+Lf1qXxyQVZqGjBWtZbjKlNnDUyIE?=
 =?us-ascii?Q?V1AQzWqIuX/9ItfJs4OACq6+Rnt8c24GfIQ+IbomWQvIiyEpcfhVX0X4Q85Z?=
 =?us-ascii?Q?4EJPxS3qpHSI0jj+ja+14TXl2tT1tE1iJ1YVBh7GGzS8a9gMKGpu7CCn11Nz?=
 =?us-ascii?Q?/RaDctqR2mZGeFNVUZK5BTqRz+QMCB8jt8cwu9NzCHeCdp12y2+51iAMdNCC?=
 =?us-ascii?Q?wplMhPKoBYQ9X5uDnn7Mngoj56zv8wF2LJCTPjbZWYU/KgWaV2fCCJLl5sH7?=
 =?us-ascii?Q?lJ8q/N9dmbhYNyFwXkbpaDbeMp/dR3hCqUJ+vlMIyal3IPX/mfQZm1xUl6KL?=
 =?us-ascii?Q?clxTpbVW/RBTOrvnojZHpBAr69NSg0qMzfuKmR6brYR/WozvHvF4BE+bAx5Z?=
 =?us-ascii?Q?Qn0s6jZOARhQnJV8BbdBsiqKOqhpZg3beiIaBb8Wd6rt5yw9Objo15nck/7q?=
 =?us-ascii?Q?Pz3pXz4sBVSSCunAV+dxDoMq6sc0snGawGVR5KtgnITHBAZAljEskhdeec2u?=
 =?us-ascii?Q?/9Odn4bl0wvUxiQ6Fd4Ozb9Q5fUAwI8nkw4/vXtIBJS/4Wa44PqjTpF4AKjx?=
 =?us-ascii?Q?S/RipBQ/DICjnHNHa5HiiJyseop4EDbnZJRZ9lSA/LluPGn+wMg+CZWYkpIN?=
 =?us-ascii?Q?KV0fjiHtIbnR3kQqN07wVz5Pus+yrNv6i7xms/lY/fZqKHk8M6ccG6I2MsXv?=
 =?us-ascii?Q?4EDm5/MxGxnETZ4u7OVRTZeGKqza5rJLMYz1ihFEyrQ9D4RiLo2ekT1N5VXJ?=
 =?us-ascii?Q?QPZ10plumc6+rzdVlyfidptYEp/8oloedDo58hUiyn9dCE14p9RWDJEimoMG?=
 =?us-ascii?Q?K7/m/XDxt8w2i3NRYRFloZ3ioIGfgwT8xPBXtzn4jIpCAk0HByS9bSbmOWmB?=
 =?us-ascii?Q?yYgxzEGjFbPgytwyW3F83Zfu7z4SWLsSE0pJrhX57L+6ZtrQkONezK9KMKjq?=
 =?us-ascii?Q?P4Rdv/mudxagtQ5LOkvdoS6xrDYGtbB01QF4KEUKV7pwLsWB5caS/uRN17DE?=
 =?us-ascii?Q?7QAVQATnmTZvqNJsaKMt5ZEAdMKaQCWVEIuqkGBc4RZ3m22xAAE8++wF+Nu0?=
 =?us-ascii?Q?EhJdAwI8QNQytwoaewvtDnPkXllIeGSsCI8L1avRVimap6m+1lxRbJ3oXsTA?=
 =?us-ascii?Q?y1Y4G7K9QceCDkOFfi8bw7HizdyFYyfrLstreWaGgshnDrBpz961cSzzZdhr?=
 =?us-ascii?Q?f9RLG0sh5k/+cWji4U81K//Awv3ZhlKoWWuH5G+cWAl0jzfgasDNY7rabmOj?=
 =?us-ascii?Q?NNCoJKxpLePEAeoGK3HJfekDvhE4bsZ1NdF+LEeM3GU31cRosMowVcc7SeXU?=
 =?us-ascii?Q?RKFHG3jenR0LeP0iZu22ltDAHH5S72r6Wg0NfZOJxt3ncwAOxgm4DYbsUCLd?=
 =?us-ascii?Q?SxXZhVlwx0m2SC+dl9T2RvVI0TeslMbwtS4MNuX8bssd+J98fNlh+ebBp1AZ?=
 =?us-ascii?Q?VKFwqLcfMJB5LV78lyfIEPqjzXPs8LrJYD4xrkXQoA0t9SoEuAzp50o9ldPB?=
 =?us-ascii?Q?1VcUax4HwNocG/y2fahKsnfXzRZGVZ1JAiD7THVn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7299448e-6ca6-416d-fc16-08dd9f9d256f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:12:24.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0eWDso9HWH9n426osbG6WxbU8Hj15/MPnpmlhd7W586QCqcXOSsoqXnKfjJ2YDY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

On Fri, May 30, 2025 at 09:59:36AM -0700, Nicolin Chen wrote:
> > > +/* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
> > > +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> > > +{
> > > +	struct iommufd_ctx *ictx = filp->private_data;
> > > +	size_t length = vma->vm_end - vma->vm_start;
> > > +	struct iommufd_mmap *immap;
> > > +	int rc;
> > > +
> > > +	if (!PAGE_ALIGNED(length))
> > > +		return -EINVAL;
> > > +	if (!(vma->vm_flags & VM_SHARED))
> > > +		return -EINVAL;
> > > +	if (vma->vm_flags & VM_EXEC)
> > > +		return -EPERM;
> > > +
> > > +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> > > +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > > +	if (!immap)
> > > +		return -ENXIO;
> > > +	/* Validate the vm_pgoff and length against the registered region */
> > > +	if (vma->vm_pgoff != immap->startp)
> > > +		return -ENXIO;
> > 
> > This check seems redundant
> 
> Hmm, I was trying to follow your remarks:
> "This needs to validate that vm_pgoff is at the start of the immap"
> https://lore.kernel.org/all/20250515164717.GL382960@nvidia.com/

Oh, right I forgot how mtree_load works again. :\ Maybe add a little
note

/* mtree_load returns the immap for any contained pgoff, only allow
   the immap thing to be mapped. */

Jason

