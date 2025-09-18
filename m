Return-Path: <linux-kselftest+bounces-41854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E32B85578
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303371C84E1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5B30C637;
	Thu, 18 Sep 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f/nMIVO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53830C10C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206864; cv=fail; b=hRV3O14a+IeXlyN8NGE3Z5306xr/xR84sRaBm+/tr0O8JsFZX2JTnHKkF5spUuXEMXZM5zDy0wGuH9l/HwpAdXT8sTdOD9d6gkAgo6Un2X15hs5Tz9W9/+OTAM5d4oUCD/p/RIyYkdGyqhltDxjaLHMMT0+ZGUSJ+VGS4ypeu48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206864; c=relaxed/simple;
	bh=VvvpE6npLBUUb3KUWTp1XUQM3ZuPDpQx7W8QoJ+EDlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oxhD1F1ju3THs40cp+QMHcpv2enLqqrciF1oiwfRFaYwhU9MmFFFdSPZZhbohbqii1cx64M7nXpN0akGE4OFwlLq5BgdcH4NZiGOb8V6fJ2kzlHO4IKsWMunrdSTz0mSbs8t65jxkyL2ypb1JFAqi7zsfBEqk0dnWxmvaDdrVKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f/nMIVO0; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqlAMi81W510LcngLoYygn5OYDDm6DO7081WTw5/tMB9S0yBuk/9gVDlmKefag79nW5PjsYrTBmEAzjDE7VO7c1vEWcjhRHNSMffZ70BMKcs4UISlXWKiaCPDqSdcxVScWz0r9t5L4AJrCfAJ9akC0PgqQbkojKjavrA+r9fUJRsITkmz+bauv5y0ksY1xp/sZhHsSeV5ISq0zCs7bif7/HSmvSFW5mBo5zdHoyu+O6RqLZQPepxjT1kxhhGSPJYPUyLApFlpIvKC+qVbuDvJ2hc0T08jQF1wjWyXJ4HgglfoCMl5RQoLkh8GqN187yMD00DNpA5vRIP8YuLxoou1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOKUmrjA8cqu/RD9x9HDzg/CsXW2wCQGzKvmVP8yavo=;
 b=QSuW8QCvfgopqZ1ZPRTU0spJXLPnvHPFJSVZcaRK7j/UkkM1TCaD/OIC/OYJXfMms+81s6fEyL0rgNxRmMQQWQosZBTetn0kYwZ7bRqjAwd9LbXQRSZxQACXllStzF+y0HJ5E0rH+51ZW+frA2sS7dq8WzKPEQKGv47R1AM505MnCbcq/HidyYkDzuMSL+wpszFfRQE1xT7q5+6LNnQ0VosQuk5xxwkhm236VuhBsp8Urj1WHUljWHOqddNzThbC/ERaC98HZmAblE7qMjIe7QJrloZjRAAKdufyrYJ3lwrRBdU8p0n+64m034I6rkNdQPLzVGK2a7t3Ko1NwWrw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOKUmrjA8cqu/RD9x9HDzg/CsXW2wCQGzKvmVP8yavo=;
 b=f/nMIVO07s7NjmNWxPzCjDjsEuJ198Tlkm2658uRjLnbkbn7/tYSzXQSBV7wBai3y2Ns/nMhCqwtmvK4h6+auXbhBQz2iEux2vz/+vi6vk6KFhhhYiUqxtuOOL6XZS5ZIEKs4litxS5YoXeEBl89UkKsz7+OVjY2mFY18QQSIHMiZZzvb5ZlWcV/MQBzI4b/TV2OldDBK6s9sc8einsE8d27fuIIBUu1DqYANW63Gxduxe9pgS1t36TLgdhTxn5OPkgaEivFgdY9aWrrQp5zCGCBgHNktVbR0/NbBvwvP+4vU03alc1uG8POqvZCWiMZVaDD6gOuX4KI/MGZx/IBrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 14:47:39 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:47:39 +0000
Date: Thu, 18 Sep 2025 11:47:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/3] iommufd: WARN if an object is aborted with an
 elevated refcount
Message-ID: <20250918144737.GO1391379@nvidia.com>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <aMuiR791LkEybdAa@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMuiR791LkEybdAa@Asurada-Nvidia>
X-ClientProxiedBy: YTBP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: d5db94c9-728d-4527-7ed4-08ddf6c25085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdrzBExFWNbh1XZXIvjYZedEO1wr2fCJ0iyp3hKrzr5mJ56eS1TUeqJtK5XD?=
 =?us-ascii?Q?o5uq2vdMkCzz0UkoisCgIzpF+sS+futGqH3RqBQoCRBz35mOsLeGwCHpm0gN?=
 =?us-ascii?Q?ij3SOLSSkZ8Uft1ckB3Us4nA05zM9RknjAo2aYu756qcxkny9m94W2HtBd+S?=
 =?us-ascii?Q?AhBs8l5AeIrr44+jlNwI+T6WZlocDECtau87DAxV3e+t7jYC4C6t7SVjqVYk?=
 =?us-ascii?Q?fV0KM0MQvP49Bo/m9ru6CJwSJzAyYRqwO/wahzsaxjkMbLwMAyhSXA8aDSRF?=
 =?us-ascii?Q?KhHqToc3fLMy7C5cJacRa1QijhKLy9TiLSZ//nEPgT6I33riooCIwI5H5oqK?=
 =?us-ascii?Q?dYD4/45PiXqbPWHPf6y1FUpk29SGbilhv4J6aawojWJ7pRdIl0S3gO8x6z33?=
 =?us-ascii?Q?zLohoVZcRTxAYv2FmdmaBm+VrEHJoWh3qCkOHcmIpymr6BLU156//eGhBWfh?=
 =?us-ascii?Q?AJM1f9igt0a4v5wrkZIDF2dwqmkAmADsmHY20xfITQgVB+yY6krjDp4KxbYX?=
 =?us-ascii?Q?Jm5kcZPXqUfEXjxPedEVvEK5DaWqa+cUvgaOZTY84p4QaWI74IrjkGBV91we?=
 =?us-ascii?Q?q9YHCfOQIibZGsHeRBgp3lOXDeasnYnaKeV9EocUedGKbsfv8fCxNPodaqre?=
 =?us-ascii?Q?IEpesnKJIlyoxUs8YtUV804/pJKfH+jShqpBAdmq7143gNPMybc+IaoJcjKS?=
 =?us-ascii?Q?NEmdWguSQitq0DJcxVrJ3zppVc0qFMEP54MaJnlEl4V71QSdMIJu7afqZJZ5?=
 =?us-ascii?Q?CV8CgxqscNAurGEltrz1NBhs0d2l7uAjv+kUXDanFuEih6OacHyL/0IBj8EN?=
 =?us-ascii?Q?fmDctJOh/hjzwc+A/1u1QTTkvHn2Z5RDmDw6h2THyzHqVeZY2dhV35jY1geb?=
 =?us-ascii?Q?lX9jxO9OR6gunTs6XwTmOlRvVUTo4w5anqaQRrGSP3X3YcFspyv+aoJwkw2j?=
 =?us-ascii?Q?Ih7r7S7WK55TTwfphz7liq5f/evIiWoDD2Sst2jPVd/icBl/3d7/jwrRLrBa?=
 =?us-ascii?Q?zbvjwyVp+IaYxkgWlkUHEn2JMM5Bujl94GPtWPtIF1QZO8zJZ6W775HfP3Rg?=
 =?us-ascii?Q?lzb2F6h5Tr6UvQ407qY6SxbnZDm2yXdTUFvAJThd6tEXZLiPp5mRiObXlp9K?=
 =?us-ascii?Q?/7E6dVpRgwTwyx84sTXsqxRw/6U7nBU//zUSF+rnQMVn/RLvnmyCPZVYHX2B?=
 =?us-ascii?Q?H4s/TwSEXlbaf9yYt890hS7h2lc3644thSrrmZXkfeDW5XvSm/eZ8bf7El/Z?=
 =?us-ascii?Q?OTJdCewJa9Gt44JlY0lHP3OI161U6nrAgKJum3V/BvTNfMe3qchQ7aVzdRBE?=
 =?us-ascii?Q?s5NfaIxaVrksxHT0Tnz+47IH20yV6EqaXfK1gObPZZ9RwfIp1jSQRJYXs6wq?=
 =?us-ascii?Q?GIxDUClb1exesTV0kq9nwaqx5HH6D+DcmXtH1mh0jGKstCHAbKEbKWAX21Yo?=
 =?us-ascii?Q?MGLseef5B+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRiX2MlSvcXmOUhmp+TP9Dr230LeC+C7sIjJWdBGsIcbGfNkmmgFjZXkVSWW?=
 =?us-ascii?Q?kHuZV1Zir7XnAepR9m7WOLgGeZ54ZMj1RQg/xivw0Hzg887FIgQrBkiGE//2?=
 =?us-ascii?Q?7ZR2T8LxNcvfojVFxMqST1L+GQfnwfBHfNErXwRRD6aOb18In4YeA9V/KSVb?=
 =?us-ascii?Q?3gDqAxv/+Nlx1OUgVV+lOEvTobq5wcyhCKRvdygAfnXHtYd/f76qCUVcadlh?=
 =?us-ascii?Q?H69wQjaTIXnSDnx/0/r9M4FLRgtAxOEeu6XD+Ac0kv+uWYGHwnuMpBW0hWZk?=
 =?us-ascii?Q?dtncDt0EQUH6FU5xwtaDb6vOpVzul6WeqhvaxQS7yJgrzzgYce2VCNSwQESg?=
 =?us-ascii?Q?XaTL5URaAa4aU0n0MIFyoRqP5bom+gpvl4OoaGBJJQgZb6kWvYuStW75rdtc?=
 =?us-ascii?Q?YfqVJQRXHBpFHuN1oRCPUeiDdB1vEsD3Un4CX7lftqBu95z7Gx2tEQ8kV5BD?=
 =?us-ascii?Q?jRsi//LDf5ZNaq+za7Uh2Q8FD4hjwlynJEGTkNjV6ILTyK3nLK+xsbzM8jzR?=
 =?us-ascii?Q?PbzYEswFMfMnAvad2NZBLlvziDMXZd8Xtu0a5mRmRV/4xBTSvRqzFpgW62IA?=
 =?us-ascii?Q?89Tda9rgX5FPJXLyxFnKYQz14r8qEVOXCKFmJUmPKOs527BgjvzYv/6OQkAT?=
 =?us-ascii?Q?OA/M623CCSkDz6YV0v/uRVz+CN2QAv8kvJoLLFHtM+RSv/0hzAjV+D9fRIpP?=
 =?us-ascii?Q?Rc+mIVGwvBs6wqDUq68wIU5SYPQGH90/oct8r9hHEYS3ivdC2IcT0uK6933y?=
 =?us-ascii?Q?zD0jPPfA1hZxBi07wm4NSW7nXlTxKzlYgcCzi6+adE3+dyxS84rPin3hSBtf?=
 =?us-ascii?Q?nswJle61aTAFYie+xtLTRMKqPIoMsXDEqHXk3zek6YmU9jYe80qoIV7dSJPd?=
 =?us-ascii?Q?YkvcPFPq2Z/MhAQSyq7dD2ezAIPDBqI5VVkHjc1j4f6+sCjxhyvPhSLe5Bxj?=
 =?us-ascii?Q?0hFG7ZMaZFYiiWjPC7n4vGjkYMLGq1X3ZafqzHdrQcd1Dro/5TyDWPLLXnTf?=
 =?us-ascii?Q?vf1BMMbSEbYwhcKdS/UtwE7vBNYJTvk3Sd+gfCbBzwPqqfdtk39KYCNhpevn?=
 =?us-ascii?Q?fmC4o65IYZORp3SAmM9ASNIo2vGPAaUpWD2dmmqZXN846anhcyrnBO2Ft2G2?=
 =?us-ascii?Q?NC9x3hHQaWHT9Pf4S2aD1N9g44C7S7PUPcNPluYhvpumpnd9Kdoc8Q6T+EXO?=
 =?us-ascii?Q?kvYaKKZLDx18Qq+mRdDq89Zn6PTD9XoYYAFuJDOZehCAJhyEXFfUoxX4OgXs?=
 =?us-ascii?Q?Kv1b5P9HVJFr9pI+0wt3UovErz2y/eqzyYAwiiShUqwHKbBEoEvOx8kcxr5n?=
 =?us-ascii?Q?WzB4sJLWwbbVPMngKZ3xGfUYtuW3F7QCIrXuT/07r7QcmH45jZZDcTClaR8D?=
 =?us-ascii?Q?jBqMWQpLDDU6tlvvPUU4PRjlzO6cpiMihVPAtlGO1jaA33zhx0Wf2DGkRS68?=
 =?us-ascii?Q?7lN8Mq9oZ2QyQWKzF3AwB6Jtz4VQEGNq+ZhHeEA6i7GO7JenYC3u0rULbmXB?=
 =?us-ascii?Q?JO/uR19WSseQ7vDlpd6ndaKusWetAGesuG4kTaBmQVGDw/RSsV4YZHIk2z5A?=
 =?us-ascii?Q?d07bpr49QRatGm5EQpc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db94c9-728d-4527-7ed4-08ddf6c25085
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:47:39.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGDklIosLyV7of/55IzabpsiNdB5uOWClM216k/l+YTCO9Upf5JXOx6YTG99tSBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

On Wed, Sep 17, 2025 at 11:10:15PM -0700, Nicolin Chen wrote:
> On Wed, Sep 17, 2025 at 05:01:48PM -0300, Jason Gunthorpe wrote:
> > If something holds a refcount then it is at risk of UAFing. For abort
> > paths we expect the caller to never share the object with a parallel
> > thread and to clean up any refcounts it obtained on its own.
> > 
> > Add the missing dec inside iommufd_hwpt_paging_alloc()during error unwind
> 
> Space between "()" and "during"
> 
> And I don't see this patch touch iommufd_hwpt_paging_alloc(). Is
> that the iommufd_object_abort() part with the WARN_ON?

iommufd_hwpt_paging_alloc() calls iommufd_hw_pagetable_detach() so
this change gives it a put that it didn't have.

> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 0da2a81eedfa8b..627f9b78483a0e 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -454,9 +454,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
> >  	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
> >  		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
> >  
> > -		lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
> > -
> >  		if (hwpt_paging->auto_domain) {
> > +			lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
> >  			iommufd_object_put_and_try_destroy(ictx, &hwpt->obj);
> >  			return;
> >  		}
> 
> Hmm, this patch doesn't change the scope of ioas-mutex?

iommufd_hwpt_paging_alloc() now calls this and it knows it doesn't
pass an auto_domain but it is already under the ioas->mutex in its
callchain.

Jason

