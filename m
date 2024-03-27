Return-Path: <linux-kselftest+bounces-6720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D788EB70
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 17:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C812972D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73273131196;
	Wed, 27 Mar 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/Sd2xz+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473E12E1DB;
	Wed, 27 Mar 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557518; cv=fail; b=Eo+jIQCn7mxBNJnErah8m+KJG/hEzhNlLpFyZenVprAvZZ2JENwP5su/LdjNlbhtyg4OLrllmmGRXRr/JGBNiO2fSYp130c8NTryozPvc466n+3KATWl5ToVLIned93Wzpe9+K3caXBnfvtS/ev4iN8IWiUbJWPuxLQ84i6y/TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557518; c=relaxed/simple;
	bh=p+NSFoaPM7iKPHMuShAArA86vs/rvWuH+HfzF9hqIc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7ExcGimdRoxGOpNWAE3WgfEfmq0TPpxwTSjqLEilyc0pBhvf8xTXbFo16T81EW1n3CVAe+5asi/+qI2Tm9KnHjcnRm8pz3B8uW9V5EOWoWUXM9G6Db62FtPn2ABrBMzUuQ/slnra7fn+V0ExA5Bcg3gC48cnkHPrsg+fusFIAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/Sd2xz+; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ilc8DblvEaIHo7dM8CaXTDUVjsR+Cre34epJbRxlPc5SXpB7/kaVLGPuNGMR4je/qFOZ3Ss0B7asUjCDzCgyKIJBBQCGmiFis9fF6hmmLpnTzIE3/5dUJfpDqXEfe2bgWWHqRM0K70NJbs8Z5bqftXxLFD9Q6MR2mEHHpvCnQIukgbfd6qJ0whujQCrAq+rDgjOawjaXJN0Ed362eBEcQww5t0b5fA6+tJbGvSSsNC8dRZ/CPKKDfExiEoGgmpJy6F5BByxWTBtb4alZXgEjAnXAWs2WqzKPU5YRaDrQ7kFWBmZJ3J6I4EjGdplfv71dWEJxUFK73OMpXmTK8LGewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf3h+zQBs3uRgvGNCRBX/G8yV3q6a9rLIIsJHwM9XtI=;
 b=DSRMEmbu8Mkh9q352JLFtFDrp7Yc0k9fjmN8rHaqgUe95xCRTMRowCybxt4B4t0YFGCDw3kH1tAFrDZFsuYgO55llpMuqqNULOilTWoEbneRIBonWA/crd+ElrloKzf7J58Yefzq5dCBWsgOk+xl9nf+T/mRVCgNTtlpaVKVm7AzXm49Ao1do/Ta2YFYila73Qe0JoWZMAPh4Lgelrvnecdf9VYd57I2jMohJtgt1Bu3Fxlfn0NoAisArcmHfTZQpTQDnT1n2/M0pkD64s+IUX1xOOa/TgR/bxiRLiWwtO0OQCc1tPG7r05R6oFgrlaLINcQNqS216WVwuMXHyC1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf3h+zQBs3uRgvGNCRBX/G8yV3q6a9rLIIsJHwM9XtI=;
 b=K/Sd2xz+Wa664+ZbsocOX93B+nRUDHnxgSeP6ZwcUmIu4aPl/w26mqD/3rzMm7oUMuhLECV0X/8ydBiu1QSlvHEL1Rg8Oq067XWYkyTJtdgR0JozcwOufvd9DyKlGfywcSzF06Zs3R/7oYLJbXsnaJgwQjrGeIawLcqtakWGKrADEWgq/hnTKKvJI70WH9jX9b3OyDfZ+dqMwHViADzHdcBKO1/ExFc4aLuBQ1lfNxOb2hM5rnI0MSx+6rJePh0B4ErdZeBCfzxleVr0Tr2w67J164aAWZFH3RY80YjQDSBy9foQEtq5Xl4kXKDQAURpU2LUtb+pMYPBgLDmAJIGkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 16:38:34 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 16:38:34 +0000
Date: Wed, 27 Mar 2024 13:38:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after
 a failed assert()
Message-ID: <20240327163832.GJ946323@nvidia.com>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
 <20240327114029.GC946323@nvidia.com>
 <ab5d2b61-2dd2-46d6-a106-a9aea69b0a1a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab5d2b61-2dd2-46d6-a106-a9aea69b0a1a@oracle.com>
X-ClientProxiedBy: BLAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:36e::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 03815655-e20f-493a-1677-08dc4e7c57f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQi3Q1Fpk2qEGvkedzMbaEpQcnwfYk5/UbDffxb3ROuBSAnP0+d36zYhBSyRfQyU6uucFbg1QcdrtwBzbyyjvyLbCjdk95HzKUEgNeziuU45Rs7tj71+9TD/SR31DJs63MJCssf0EIHCxi1Fo+AnyrzbgBOy7cJAX07ExSMMZo+fomb6X36KKWdr7pnzh40vUB40r1FPzlfGjD7+O6yseoEGsLboLIoIAcSlgF5KMIwEeKWbzga/abzoZrNARTXRaCBHm5CtSgN18t8bPc5IufkwA9neQrEYQilJil7FsYdEBdKTWYNBlH4FKFbL2S6NBdgQw8whvMfZulXAiI2YphDb67VgFZSE0yM6a/wAnMx3Ahpwcb/m86M3zz34YY4aI82WUS3oKffi+eaAY2Wwn7RCI/6rB+ZtBIeVspw8vfGIwxeso8/D8EH/OJDOlW1/Rt3veMVmJWmaHRQSqP2foiSrbLYUAxJdpPsmfWV7rRRavgCUJAaPNvwI9tqY7s7sCSxjzYMLHcCNVwHDOi+kEKdJW3v8Ho1N/NwoSNLdhNYkrp31aqEBYPqHr1PjbEn9GZ6mwwHZeEr6sGC2sDgxSpgeHtn+CzEdMQO4eayeUhPbvSC3nmXDsa3muunm8mDmTQbHc5RZpbhyfGaCVlvztrIVlsBzxqtTepo8r06YtOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1R0TzF2M2FCSVRsbzN0bHJVd3p1eDc1OFp3cG9TM2t6eHRqb0hMVEtjNkp3?=
 =?utf-8?B?UUdCZnZGZlJ4THY5V0hmTWsvK0sxbm9Qcml1Q1VNb2llOXhQcGFXNnpFOU5z?=
 =?utf-8?B?S3k2c2xacmpSRkxpdVdVQ1BsbG1yOGduVDF2ZjFhd1kvN3ZHNXFrb0RWQzBx?=
 =?utf-8?B?RjZvZ05NeXA2dWtlaWZDRm05SitERGV2aGh1UVk3QTRvemtvam5DbFBRTXZK?=
 =?utf-8?B?ZW1yVS95Y1gwS09YR3QxdmlLK1BRdWk3Ymx6cm5XT2hPU2JNc0ZrbFh4RU9F?=
 =?utf-8?B?eFFTVWx3SVFHcjVLb2xnZGI2aENyc1BnTXdpTTVXblM1Vk9xS2VnKytpdkxG?=
 =?utf-8?B?WTBpNkNVVzZjdDNxRjNKc2hXdjlocDA0d0FEek5xUUI5bzhVZmFnYmljRGdo?=
 =?utf-8?B?T2FneTZpMUVqNXRWbW1DVTJMQW1ZdmxWN0Q5dXpSNXd5ZWVjaW9vRmNhK0lZ?=
 =?utf-8?B?OE5QT05GdCtVMEZVYW51eHJCOTdLb2FOZUQ5Y1R3MVMzLzJYTDZRdUhiK0JB?=
 =?utf-8?B?NE1CL1RZc05JWDhDcWt1eGpZWU5FelBkdTJGR1l3OE5OOTJJUjJCT3I5OWhm?=
 =?utf-8?B?QzFvT3NmZWtLbFZ4c05sajk5RTV3ZEFBQWptZFZxZWJyQ2FlMi9INHdRQzF4?=
 =?utf-8?B?bjlNc01BU25KcStkL285YjdJUWdBd2J1VCtFUmJVSlhMS2VOYmhST1dyQmVY?=
 =?utf-8?B?UmVxNjZvbkhzS1BYWktRZlhwTnBrOG9STUU0QVFvd0tBNkVpVVRKWDFmb1NR?=
 =?utf-8?B?NEFoNTkvMldkeEtLWUV1UjlzQ0w1VlRzOWZGVXd4N1c4RDRDd3k0ZlZsRzJO?=
 =?utf-8?B?TmZDTFg2WUs2QXJFWksxUUtsWXpMc2l1aUE3R0JIY1hVRzBxUThFdk5UY0w5?=
 =?utf-8?B?dlZOeEt5M2JKV0NMcXhRM0RmSUZqWkZ0YVplUTN4V2h0UmI0YzNXcWt5alJ5?=
 =?utf-8?B?NS9rRGt1RTlpWnVXRWo1Qnl0Qkp6YUVFS1pCRlhaYU1TYWVWRXIrcUtEN1VS?=
 =?utf-8?B?VkcwVWs3cG9xZGl1REhsQmxZejNWc1pkN2dNdEhtR0g2a2hLS05DdWZORWF5?=
 =?utf-8?B?WUhJdkdHVldMdGNpajNwN0lOaHp4MXNTdHI4d3pONVdtSnhUakFKQlJWdXdP?=
 =?utf-8?B?VVlrTlo0MTZUazRyRG1hZFdVK1Jzb1hRaSt3UGFwT1NJekRXU1RLR2ZiMzV2?=
 =?utf-8?B?TGpiakhzendkbWgreXJXR3NIRFRFL3ppT3BGZU1lMFhsSldzRmdseHIyUjZs?=
 =?utf-8?B?Tzc0Vms3RThpVUhCbnlUaXlrdDgrU0Z3NXZSQ0c1WjhqSWp3WndZaTB3eHdu?=
 =?utf-8?B?elkyNTREajdzL011c3R6Tm8wSXVnSkJFMDIrSmFjUFh3SzQ3b0REN3RLZzNk?=
 =?utf-8?B?STVPSFE2U1ptbGhnOEdGdWZydUsyU2wvelBkR2lnRVh3VDhXTENMTWU3N0lI?=
 =?utf-8?B?dkNjb3ExY2dLK3E0aGZDdUwvNTkvRXBtbmdQT1dtNWhzZ0VkclY0ak1SNTIv?=
 =?utf-8?B?am93NHQ1c3JHU0FXeHc4aFBwdWNJMUJQZFNEVzhyazRSaTdPUGQySWRIdzFM?=
 =?utf-8?B?akRDdk9WZmE1T01NbHpVQUhBN083QW9HV1pDdFRtQmFkSEhIQUw3bEJvdUpo?=
 =?utf-8?B?NElyM0piQWdRVGpodTJOQVZPazd2cWVuUmxEZFZtN3ZiL0Q3R09JeUVJRy8z?=
 =?utf-8?B?K084SUFOZ3c5Zy9nV05uUENCbnFyWS9iT2tJTGRnYnpza241TWxLMWFKbit5?=
 =?utf-8?B?R3dYMk9BWC9XWGNhODVtdDQ0RWxyclcwMXF4a3drOWszWi94Q3V6QUNQcllE?=
 =?utf-8?B?ZTdjVkxtOEFKVGVWYkM3cU9qRUErbDdMTVlSRzVhRkI2NjhoNUFyR1d4bTI1?=
 =?utf-8?B?MU5vR01TckRHTU1heWREZ0U0TUQ5M0crVzNMWW11WjVQNXBUWlZmbm5hb2g3?=
 =?utf-8?B?WTZ6TTcrQ1VGOUN5WDc3bWgydWU3ZUNPQXBBQ3dWMSt6dFlHcGh1SnUxaVBj?=
 =?utf-8?B?b2g5WThwZnV5MWtPaFVSVkhQdlI0TWVMTzNwTlE0QmRXMUExNXB3WHZ1OFRn?=
 =?utf-8?B?SzdXd2M5ZDlpNElKNDdSZ1lpY1lWRGwzQittZlRBV1RIRDM5a2tOK3hEY0VE?=
 =?utf-8?Q?gN+7LiqhNrlzqDox2eMHMGPHn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03815655-e20f-493a-1677-08dc4e7c57f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:38:33.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt1iB+osJJeiC44QaFEzvjO4muDasZ5occK8BAY5b72OgCmzOJiM5xlAYW/+Exi8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

On Wed, Mar 27, 2024 at 03:04:09PM +0000, Joao Martins wrote:
> On 27/03/2024 11:40, Jason Gunthorpe wrote:
> > On Wed, Mar 27, 2024 at 10:41:52AM +0000, Joao Martins wrote:
> >> On 25/03/2024 13:52, Jason Gunthorpe wrote:
> >>> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
> >>>>> However, I am not smart enough to figure out why ...
> >>>>>
> >>>>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
> >>>>>
> >>>>>   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>>>>   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
> >>>>> PROT_WRITE,
> >>>>>   1748                    mmap_flags, -1, 0);
> >>>>> → 1749         assert(vrc == self->buffer);
> >>>>>   1750
> >>>>>
> >>>>> But I am not that deep into the source to figure our what was intended and what
> >>>>> went
> >>>>> wrong :-/
> >>>>
> >>>> I can SKIP() the test rather assert() in here if it helps. Though there are
> >>>> other tests that fail if no hugetlb pages are reserved.
> >>>>
> >>>> But I am not sure if this is problem here as the initial bug email had an
> >>>> enterily different set of failures? Maybe all you need is an assert() and it
> >>>> gets into this state?
> >>>
> >>> I feel like there is something wrong with the kselftest framework,
> >>> there should be some way to fail the setup/teardown operations without
> >>> triggering an infinite loop :(
> >>
> >> I am now wondering if the problem is the fact that we have an assert() in the
> >> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
> >> other kselftest macro that). The expect/assert macros from kselftest() don't do
> >> asserts and it looks like we are failing mid tests in the assert().
> > 
> > Those ASSERT_TRUE cause infinite loops when used within the setup
> > context, I removed them and switched to assert because of this - which
> > did work OK in my testing at least.
> 
> Strange because we make use of ASSERT* widely in our selftests fixture-setup.
> 
> setup_sizes() is run before the tests so it can't use ASSERT macros for sure;
> maybe that's what you refer?

No, it was definately ASSERT/etc if you hit those in the wrong spot
the thing infinite loops. Maybe that was teardown only.

Jason

