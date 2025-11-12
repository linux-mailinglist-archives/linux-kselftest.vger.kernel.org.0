Return-Path: <linux-kselftest+bounces-45432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1FC53B65
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6FB3342651
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F09346A1A;
	Wed, 12 Nov 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crI3bkCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576431814A;
	Wed, 12 Nov 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968933; cv=fail; b=pkxUhpy2IzF1+Q80w39DMPXht51HR44mowDhnV/U2d8nXBAptqwVgs40ZOxuUDlZa7brtKcnZC/Y7QYCQ2ifsFDvrPyNfHhh1RCncOBp8C5wIVRnmIPA5tjNACVwHVfl3tT/u7BJpFuqfBLb4TsqAgrfdxG2PLchBt8HvKsy8kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968933; c=relaxed/simple;
	bh=8aqnjt1QINcSunhibwJ9RTZzcWaTV4r/QkUBdUIzk08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kkXxzhwTjaWupU1GcUIULRYQ3IWiewNcq+L+sYDUEt+Yjyz9EzOT2kUn7SsMGvYXdXk1HKVTQiILarnQJZ7RPdm09BAogE/YDGgJd/500RmiTMFjtc/EaH4JaT/RAA/QQ4QBwC14Hy4vI+6XJUw0glNTWHj2kIh0wNLUTNRWy2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=crI3bkCH; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9eGwVEna0dwCTQ0A+/y8/eIXjSiVLiJBMIleku+q7ICyNAd7nHIGBhVQwuFtQ+k7ny8S3I9KF/JIuEQlo7IlqopGpVe7s1T7GK+AnGqKGaTXX0o0rDHNl28nx3oPHc7JpUHnUvKha9GjzJMIWbvoSkXK78nuUlW6ZyDlJFYIqhLWPhoA7S48RogrWWG+RUQoRE+lQ4cMU1tO2Dy76u+n1+EV6Uj2Fu3I/hX2tUaFLQ3fCrKwlQ3QPz3/BVHFVJuVOW6zhF38MYk5/i/y2g04Vrzvif3wqjMU1m4vaab5oqoO998TYSR5BvFsmn2nP7wSKGVVW86wLncqcGYwQwRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DLmBB+uX9yvS29E2/w3Xd8FiP8zUNiusupBJZGa6Bg=;
 b=o5nB828FoRmK9KGaqMqatgYPcQrEkwDiGsEF4LgG0wh5HuYMZsLIiJBLhieXpj3OkEnFjZ/EMSnMcwWTv/po/O078gV54dAfaib9fKXrrKvjN21NbMP0gBejrEAWBhY7l4WX9rT9W8TBT74pjjqWWkVo5w6h+UhoPZ87nm4RF9NcjR2aSTXGbezS/2pl4Gw7c4I0WduGk3Y4Yeei1GH37eIOFJtX4/cIQ5Ax6OKL9G5+f+JUJJG157IcWwb1chONGcwceaUBJc5LnZ3ZQOQqsvemKhElWpFkeUJvkjO5FzcRtwH12vMGVyPCs8Ax2pnQPgg3Kwnvw2WjHqUUrIaHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DLmBB+uX9yvS29E2/w3Xd8FiP8zUNiusupBJZGa6Bg=;
 b=crI3bkCHMfQ0+h5jDD95l9JJkTeVt+qxE8CvIlsdUyydmGymdG6UkZidlb3908OBmly8c0mOydEAtCE/nmMJXpQijOvo71wqM1YVKqYMlU4aP73/pHk465dZfscfsoGQOZNkowVbuc7h+vY3/MEQhxnw+5j3wdsW4VJphVYQ9XzKanIQlDYCdrfrmgIonsJaTM7IPl/Cxuwz6mQhcyTwXQfvr79c3qp67k69xVBgZ02O+W52sKsLELhuviciT1ttltPCYfIsZJ74OaIQLjFEKmu2JUGK9Zk8pDapX9j10VZk6np3H/CwgDXW9smKYkRnSPXurg16mzQhm57qW3Zyfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 17:35:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 17:35:27 +0000
Date: Wed, 12 Nov 2025 18:35:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aRTFVzQlph4VwbiW@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
 <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
 <aQzPVuI-dHEfee4W@gpd4>
 <aQ2XBQ4vGGFWaykj@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ2XBQ4vGGFWaykj@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 691081e1-0ff1-4a44-074f-08de2211de69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpql+G4YG5bUMZyjCWSvXyVlVf/QPZD0TVcAy6WzwQJf/A6HLh+KzWB3VVxO?=
 =?us-ascii?Q?rIUKSL5i09bI2QXniYoSIf/IryjWa/Ml13QpyhbCLzW6FlsnIK3gmKvlzuHg?=
 =?us-ascii?Q?tMA0ZQwaawbOgVFlN3w83Zd5+PSnBLd5vOljUOUoWnFX9o5kleleRd5SRCWf?=
 =?us-ascii?Q?/6ZDLY2Ti+D+/WMU9rwvBd3apgz7qItyyrLo5ZUQAFvPZ/Mth/BwPkMjXb6v?=
 =?us-ascii?Q?53I+ypUG5fhx2OR6oAuV9N+325dqU/GX01mvZCAJ6ZLUZsmTb6VQ3cVuYZVK?=
 =?us-ascii?Q?C/NzFvYqwkq9rqOcatXMRne2IxOf+YTHpbR4BT5ZE+sgqKdNDK6dt4+YVtmj?=
 =?us-ascii?Q?/0sHwjcLdqHuTaQ222ulKMqUtFIbiTCOWnqxYolFP6Dcelwh0rS5VQybPq3a?=
 =?us-ascii?Q?MyVY+cegn78G5zJZlbs7lKAbnzvJtdGN2JrnJdZSg14fSdTlIvQGmsfk0QiH?=
 =?us-ascii?Q?Ah2N27zn25a0aSh7ZfCQJotS9b/y3QVwLhDUxqmzyHp1K7SpeSeq5kL4msHk?=
 =?us-ascii?Q?eVvVD4sgM2Uo9437Saf+0dOkW+z8yBvWG/rWJPUlj6S+wLnNNvxkbqhkOGVZ?=
 =?us-ascii?Q?rSy0A2/e8r2SDWZeU6NWbJYH7K+hRlc+3KeRlfQtRTNoSK9JMaoclZHUQ+X6?=
 =?us-ascii?Q?B26PlxMjlU8OD1fUL46J3XFlBtlO21s3uvyU4fQ7rroIKjkOmjdDIfw8UO8B?=
 =?us-ascii?Q?EwuEZ45PrHg5QqzWt2MNvl1dQEvQLbrEE+3K3Nzf4m26Nf7I/dl/2tENOpYG?=
 =?us-ascii?Q?mlmHT0vrd/uDmc+V8508QU/FI6BgAXRNlE2NtgXvdTY50Kt6/b69SDErJlO9?=
 =?us-ascii?Q?m6KOG6AFh2Wae+NExgkNnCY6oP5E2yjc9M8Klr/C0D7h4/XIS+8dVezHb2U/?=
 =?us-ascii?Q?DfkIWwvn0gngmFuD7peq8avVx5ubV9hz2Qme9uEErbhTA8msld7sd6CmKATC?=
 =?us-ascii?Q?IZ3mjI8Tgoz72lZgziuaC0YcdjSMROzearxD7JNgDnE07dzOKnTeiDFEDQpy?=
 =?us-ascii?Q?EHLTKivPDFBR7dfzd6GQl/IgimaM18Wmr91oMQzwKX5IP6RBjrfYocKo8y/Y?=
 =?us-ascii?Q?6cim7LXR3WuZXbnCOquzq+tBSqduubzL0fmOHcEZwR5TBYCxoTP4WmKaK4Rb?=
 =?us-ascii?Q?BvsXtt/zLCVKTGv4jd0Posk/Wk5LO4505xebAXMPzE6NGj0Cgh/lPv/wkd1y?=
 =?us-ascii?Q?cFieiti3w65jX9vcZdQgQmBEU7LsY0UH4sF3LrUlYTQmPKRJZhxXIfXkuEuu?=
 =?us-ascii?Q?/0SvU4mQx5wrsawqrY8tLAoiqEZGAkgKQw7/n5CIfJk2Lc/iHvBHj9Cflyzz?=
 =?us-ascii?Q?czf0xcGwv71w2dcL41rqISJDHznUiXG3Rs5IwjmZbdIcFO9xPopPssp7RNHA?=
 =?us-ascii?Q?GngbuKHVFL/HvyCxnK8tTBQpffq6JYZ2U6MCDqSQug0XtQETQIrKW8U+MjYk?=
 =?us-ascii?Q?+8bvtIGrTVuNU2+gQNUdIYQ0mZe9QOlx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2iB8hMbwdWf+tbXTQY5mfleEj+qThIeSehtUVHIK4DVenNvwqB9QqmVFJtT8?=
 =?us-ascii?Q?7ayLwqnDVrVf+O6m2nBPEp0cC2fnB88+JQWT11sKBe0b5FTvW3SbfC17h2Ha?=
 =?us-ascii?Q?RCs39kANINmfGmd8ptCsiRs6jEAcKWorJVZdRswxxjFKRQyea5BFfHJ+w2My?=
 =?us-ascii?Q?sxJvW42Ow6rhMOSpjOGR6Dm2UaJsBeSXqiA4Si43NftMx1/iJocZ/t5NL5z+?=
 =?us-ascii?Q?VRBI4y7WldlvV7HTzf+Z3yLTOfhoIsqd4NGVg3kjwY/XXaX+2KhzF4aqtzQj?=
 =?us-ascii?Q?BfyQWn5ijT/HtZonOSABOdWY2v/vaCYYq6h3D0y4Pzm862eYA+Ml4ZFvguDx?=
 =?us-ascii?Q?yBlRie0B39RzCDZYEt6yrWWp6As24WnCdL1Go9jIcQ4hqyRWhZbGmopUNm2m?=
 =?us-ascii?Q?RQBBXhVz7+uYNY7+vwgGuYBd3f1l7HnSkemQEpnJ6kCsyPKeefRE/n6mx/4L?=
 =?us-ascii?Q?eDzhLbofpfcr4PM4KM5B65P1iJD/bFIn7sx7KjBoSTfSAQeL7/Az2ALnmIxe?=
 =?us-ascii?Q?EIEJ3SEzfyI/0IWTJ+Xvx0NgoM5S1Ao9WYch6xxrnxIshXdFWestA6srB0C2?=
 =?us-ascii?Q?ZEvUns2vB7KX+CRt1mUpRtVAUOB18R7Jf80tUKXb6ewsixiG+g7VDHVRQvEq?=
 =?us-ascii?Q?lk2GpIzHFUQDxn2yQLuO6WbiIwtEEuip/gzdfQCtq7k1zpGSrDOml2oz/URY?=
 =?us-ascii?Q?k92TefLtjV92CfW7pQZqDlBVw/lymtexxVS7MAQOz5UOTIRP1fExyxaKNI/X?=
 =?us-ascii?Q?Rt7cWAh89dFISwU21plSqEtmvyCONMF+IjK1Nmn/T5bxJpARDdeFq7CXyOXd?=
 =?us-ascii?Q?fAsQdELUWEHsSOMrklZ4fQ+a6DnhWiOb9nW0HKW5QI1fB3/2eXFpTpm1w4e6?=
 =?us-ascii?Q?Dz1t8vXjSr2BIodA8vRxscTUf7j+a9qDwGMtPq+gneGFebTHcYHPtPw/E59M?=
 =?us-ascii?Q?GJuiJEDA2DkD0OCaOA+dRLtR2QuxK0/HQ37G6jwN4YENhD+irWH04a7OvTK1?=
 =?us-ascii?Q?6KH8E/vZ63aR359f2hUJbdHyT566tON/VQGG9CPvCcfwVzg6MSSxlSKhGr7g?=
 =?us-ascii?Q?fhmY5XYYfRqwV3AFkJCNOcBDgxFYj82pjUT1jI76Zz9YF0+ssGPH/bUsBOqO?=
 =?us-ascii?Q?ljhup8ZCWFhwvd7F4GB63wmR6ZWdVmyLd6h11lzI1HuXAd9OyWNJcTDDkYLm?=
 =?us-ascii?Q?u+WC93vtX7qYhDShgBL2tNmmiAuHYZ92pFvRLxo9pZqRnmXRykWYy6OZ/P/M?=
 =?us-ascii?Q?ocAE5xDOkH3o206KPfGxPSgyMV1hIPr8n/pu7leznE6BEfxdIzkCoJPRV5uK?=
 =?us-ascii?Q?qPMcEA7IL5Yi/QOA+WzuFvN6SboVZzF94EvRuWr/KoI1tKcr5uOTnCZRZt5v?=
 =?us-ascii?Q?Z5JdQKT9psB04oEQ/8htsLs2zilevPh6eR10s4x6zuy91xb6+I0QKBA9a7si?=
 =?us-ascii?Q?CLuai2P63O3U1/qbneboZHkHGvcqFsxY/s1VqjjANuTa/ylPNsXyLIRrV7mC?=
 =?us-ascii?Q?T0djlzQSOwVdDIn/8WljTx0BoArRwzaE8fxiCiHuEOm8D2hPB7kVAwxPaECu?=
 =?us-ascii?Q?ai4ShD0PGEGNvwmkXGasdhaVryWAMODTSYPdxWdB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691081e1-0ff1-4a44-074f-08de2211de69
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:35:27.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBE6sxxdqsJFlHIqpIaJNTh/y1kP3FHsbDagzY1pJy33K6R8H25Hqw2QYS97bS/c94/i4LImc0bHS4cz0oRTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633

On Fri, Nov 07, 2025 at 07:51:49AM +0100, Juri Lelli wrote:
> On 06/11/25 17:39, Andrea Righi wrote:
> > On Thu, Nov 06, 2025 at 08:13:39AM +0100, Juri Lelli wrote:
> 
> ...
> 
> > > > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > > >  			return  -EINVAL;
> > > >  		}
> > > >  
> > > > -		update_rq_clock(rq);
> > > > -		dl_server_stop(&rq->fair_server);
> > > > +		is_active = dl_server_active(&rq->fair_server);
> > > > +		if (is_active) {
> > > > +			update_rq_clock(rq);
> > > > +			dl_server_stop(&rq->fair_server);
> > > > +		}
> > > >  
> > > >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> > > >  
> > > > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > > >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> > > >  					cpu_of(rq));
> > > >  
> > > > -		if (rq->cfs.h_nr_queued)
> > > > +		if (is_active)
> > > >  			dl_server_start(&rq->fair_server);
> > > 
> > > Something that I noticed while reviewing this series is that we still
> > > start back a server even if the user put its runtime to zero (disabling
> > > it) and I don't think we want to do that. It's not of course related to
> > > this change or this series per-se, but something we probably want to fix
> > > independently.
> > 
> > Should we just call dl_server_remove_params() when runtime is zero?
> 
> Looking again at it I actually wonder if wouldn't it be better to use
> dl_server_apply_params(dl_se, 0, dl_se->dl_period, false) in both cases.
> dl_rq_change_utilization() deals with dl_non_contending (inactive_timer
> armed) case already (even though sub-optimally, but we can fix/change it
> later), so we can probably remove the special handling you do in
> dl_server_remove_params(). The WARN_ON_ONCE(on_dl_rq()) could be moved
> to dl_server_apply_params() as well.
> 
> What do you think?

As you said, it's probably sub-optimal, but I think it's still better than
missing scx dl_server entirely. :)

I'll give this approach a try and check if everything works as expected.

Thanks (and sorry for the late response)!

-Andrea

