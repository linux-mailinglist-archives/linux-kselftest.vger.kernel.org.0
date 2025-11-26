Return-Path: <linux-kselftest+bounces-46522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB97C8AA9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38573A9F48
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABAB339714;
	Wed, 26 Nov 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GaF9LNPR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263730CDA6;
	Wed, 26 Nov 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171206; cv=fail; b=DJzuvj9QAt1V56LPk0TVDD8xjCct4t8XinYyzfPX91b01thdlF9uTgiFGm+hjPZza06FlCh1nAmPwZfIr/Eu2OuFAWybhAIPtT+NjgSZieKQ0V28M9jFQYjfhUilKCoSmuCSv3dvl1euXiVjmzZjKW5u1YC45kjV2uAUzPOeQn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171206; c=relaxed/simple;
	bh=F60l0fm21OfwKPzLoiBkWZsGTmss7jS0vEtrWFT0PgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a1dPbcluT4euHR2hwFEVrS7HGG5MdHOEMaK9DqtWNUFZV6WvVknhhiHDh73dLEa1gkA+uwVXA0NvpG9wYQNpVLR0Jh0QxNFRwNtoPuAt3uIKEZwJippv8x4ac2RRWAuMaaaJ1gdK+3GQuaqjnAa0lV9nRbMqb2rcFrFJjtwsBzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GaF9LNPR; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H47/066lEzXX1LJF94f8aQuA4+9HQn+r3VYbF0UDCpvwm6UtsMvmQk+kasferDbEHwX8dEKauBzvptdaerPqsxt6sq5Ha6ZmTPRiF9eQu+vhv3FeLYjr6W5v+3LePNuouRtpL/ZHdhQC8UrB+HCN+O2KdZyRaBXQHCBLKQ2yQYESTLtgCKLvl1jdGI9ZinCN6zilvil7vwvIOtPJp4DdpAXpADxJqjx1+VYQx5d+BcI1pvGvEfywbXe5HARk2TRjKyRtW6HQ9Rll9FZ2gSt64OnlLk/s/i9QW+r+SDvqQC+DqG9biEafJhw3u6RyyIFdANp/dIYOZSCCkr8nofZl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSU0y8tQ53AvAN7k/HCQaXelfDyBqUGLymfmuxNHWhE=;
 b=wYWjqv7w6ABLeiMMt8nGs44SmM6VnETkDTmx9AFks5C9A2UiRZGb7TI8LYcVIo+aJ36FEtjpaimHpS4YyJQzzMphx8+xlkQBsVLONox3p8VP0okNy/focXikJqd3X+2FDromXs469VIRdReGSyomEMb3be4W5G7t5YCPwl9JmO0OUKwjQ1bimvxm5zntSfc6RP8Nrv+0YswA4aB1Gf5qowGZowqPtswMzpHAjqH5+V2N8cebR1EoDPXDO26uVMDtFaHBr7scfHPoFU4BPmk80f0z/SloMfVjI5oJEvv9J8lEucGx2azx9SKtKMFQ4fI2wvmuIxx4dFqGneLqLcFyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSU0y8tQ53AvAN7k/HCQaXelfDyBqUGLymfmuxNHWhE=;
 b=GaF9LNPRQlhOUwK2h8x4IA+9pu9wTSyOekB56/MAMjkjjhVsl66yT2qRmLxwxFz1ZQ7my5Ei/hJBQVDaiDfsWnw5KZbL59igJ+gTasj2/de5rXBWdDOrYWCUPSdkDibcAXBvQYy3CW2o3rzLA9jgsQFrNiIJ9dqtyix/YckHvbpEWwYWgm1Vjz5lZla71AAS3UoPlJSJiFGPuwetyoLf5a9LiSUzo+kkX/6sW3yejZdIn8qlZzwVeP62KSBcEa9DkOcc7cLtcctDCyOAxuElbZWMD7eBcaicWmZi5mJ6KTeQIqx0JAuaKageVV9Vbb/zJD8EncXFEiexVkeKvJtOAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:33:21 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 26 Nov 2025
 15:33:21 +0000
Date: Wed, 26 Nov 2025 11:33:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 2/2] platform/chrome: cros_ec_chardev: Consume
 cros_ec_device via revocable
Message-ID: <20251126153320.GI520526@nvidia.com>
References: <20251106152602.11814-1-tzungbi@kernel.org>
 <20251106152602.11814-3-tzungbi@kernel.org>
 <20251106155951.GC1732817@nvidia.com>
 <aSZ_HXjTVbf1HKWr@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZ_HXjTVbf1HKWr@google.com>
X-ClientProxiedBy: MN2PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8319f2b7-fa66-4b1a-deab-08de2d01215b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4/9UJRsrjJygxNIn2ApCl+Mi3Y5lY7TqIqA+M9uV0w92PehGdKqMnYpEGP0?=
 =?us-ascii?Q?121q37fMFAhttYgoc+6vCpZIFn4sWJOLQOyxNwE8pjFJKdzNo14LHes6x5U5?=
 =?us-ascii?Q?RtfHyOMPy+u+Y6FJ60KOE1VuSe6Lb2b/7HGUFoZN4pt4oVWWd3+4nthbQQ15?=
 =?us-ascii?Q?kDc/PEgkGMpFQwV62OU4Po3/PQjdY5pNHLYwGJ8ZDh9Xf2RWNkFEO3+hERRO?=
 =?us-ascii?Q?9vih/VJA4Ynh2NQoQJfCJzyd752B0AMjuM32gB8SlDzkqFH+VeOf32fsNpfc?=
 =?us-ascii?Q?Befk5Wobar6IeOrBG0nDXfrBSvLNvhzCeVeYF3CorAZLrTxa8oD+/FIN9Mdt?=
 =?us-ascii?Q?Dce6uNL6pwEbztAdN3P5pBA1fF8aluq/QRoqWHYs4P5GI8t/rbwt0MBnQqwk?=
 =?us-ascii?Q?BTlrxAr+DHMsWRLojlmLuUEE6P26XWXfKtCuNi5wLoMlJyqsY98bwk9MSuav?=
 =?us-ascii?Q?I1aFDDpMUbBDs9A6c7SYXOx4jWW58MJM1uZYuqaKSm1p3A7ewQn1INO/m8Tu?=
 =?us-ascii?Q?m8182Rs5IQjcgaaimKxxVbTjpRLsyQ3QYJHEUuW2FkXss7gBqbrQ27jtSBps?=
 =?us-ascii?Q?4QIShZxma7mzbymerKZG7I1ndwEsFmx9IxjluH2Eqc8zl48G9seCnTPd6+w0?=
 =?us-ascii?Q?CsklgJQN/JxuPql/Rj/bf1wD22hgQaPlRnBr5amO7XxC4HozyEZiEsLIiBJ9?=
 =?us-ascii?Q?uxLIJvNnjP9VBFOlrp/12zJmtISj/hYMRgbFIdX6zreyt2PtYNTnLxt2ObP1?=
 =?us-ascii?Q?veW0p5BllJfr3gEd/vRmX8DV8a2DjqchOz+p1S21bKvdXxSbGIXgc2/G4YNU?=
 =?us-ascii?Q?JcSb2k0CvTnxVOUzgon8QkXUCVFSN64mH2/0RvpIvqjZz4LQEXNQM3PmO55+?=
 =?us-ascii?Q?yJGL6/2BxnfruU1EW634c7QpHvJTYgSmmlPb+m0+v6YcII3VjPAPrwevUQER?=
 =?us-ascii?Q?t1+9+creCym1l79aTiSNfmjjweEn9yGJHdfgfbAHAHjrmIS3Ho1jQb4g673V?=
 =?us-ascii?Q?XxBN0NApGi2Zu4XjI1aMLkxwv+MWtpvGbKs2tooARDUoksSgH4PxzC8qAJDj?=
 =?us-ascii?Q?yXYdxlNBU/Ojq25f1e+gP/CHdTsEqFcX6JQO02/dzjKuTa5X8NLwr0tuVxkC?=
 =?us-ascii?Q?FHzwpxJ7+yHIEELKxoWzU1PcV41dBjqS5ykDUUotWDy7zoKlBYsbzB+iZblf?=
 =?us-ascii?Q?5MGk8t/a1/zZdo8LzxOff03qbqfai4sJgia4rB5IUrZytzd3TKQtiqsgav6Q?=
 =?us-ascii?Q?WrCHhgB87t5wreobc4m5WbPMgZKKDUZ+ohhhDEJotj8el2e9SM1JhpDDCpCw?=
 =?us-ascii?Q?yNFq9ETaQXdA8hKelwPUtGvDGWSxjUTsBm5Jnnr+l9bKf3AT0MTuS10pzqLV?=
 =?us-ascii?Q?3fklImZLaawgYtRpTyO00MAZO0OnFfG3OKuUkXKyyFmgTXgLYJkEdDBfytGP?=
 =?us-ascii?Q?Sg7sNJhGKlWgibofSS1Aj0KXgL8LO7MU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xCyA5xOtVxNBV6wW4YGuaZgWWBZ1pIcW3SQ+/u0LqXmKOhOB12Pt4kg6Z662?=
 =?us-ascii?Q?UnM69Lxn8K/jdfQMEa6D++tSxKkL3+v4mkz5CUwP4d7Re8EyQSmWlGG1XfVJ?=
 =?us-ascii?Q?mi872YmsG5nXM071zmgS5OuAqv9WT9BVqGt3RGDppmV9Rp3cgFzKwiGqqKFP?=
 =?us-ascii?Q?+dldcVe42hBU2qSRrFlNFx1ZGM0GDGILawSl4cK3WBGR8HhHpsO2K9VWyvTg?=
 =?us-ascii?Q?8ZoHud7dKDU+emrfZet2fyaTENpP5/Bn5BqzL5UKGBUMD3wTglLDKzQMFRUj?=
 =?us-ascii?Q?RdbqjJVbsD7fm0zhfLQZU8YuAmZCAuFHkmRpNiLIACs5lp3V9vH+z4+zquOY?=
 =?us-ascii?Q?Jb60Jqqid7b8z0GWDCOq5ySD08UAHZszn97h3s8OF98iV8mVb2iSTKijKJfF?=
 =?us-ascii?Q?pBG0DtIhgZwLHRMyVOjRbNK13JQaVEXpvzzHB/d/CZ6jb0ZrlzlBGR50TdAG?=
 =?us-ascii?Q?Ul9FmX+BI8SSlAHejOrpKG7u7G4w/4vST6JA2pE8aEmFikfc0tLbJFJbyF4h?=
 =?us-ascii?Q?lwp//B6OlAHGzRyaTb1Kl74VWF0lITw7JczNI/l4TpFOxYHDoGOx0hfebg52?=
 =?us-ascii?Q?UTPihBvM6ot1KJSNnmNFWPTNqeiXSWCOnPJPWhPP+D48gOUIYS4tTAM/nWIJ?=
 =?us-ascii?Q?maonutJt6wjdcT4KJTBSD+tr3gGZZx3Z6eJ9nLHW+AEYP9Z9kJfHSCIJ2g5U?=
 =?us-ascii?Q?yzjqd7hNfOEInQPikHVN79DBjouWbxtHd3qkgVwjUMIYhOdR3gaOEjMmAKGh?=
 =?us-ascii?Q?UVgDG4yYoKxQ6UfVwTP77b18auDSM/7QSIcOYb/BQzj8F5T90Tg9OZrWd/2B?=
 =?us-ascii?Q?2IO/dE3GRXuH+R/zgnaYqxU647mWLT8uTC2e6A+35FcMj23moQmms0ZoBN/S?=
 =?us-ascii?Q?2dunyhXvKkFaehJtZdkED30IMWWxbfa6KxGOxIJeR+fE3Y9zgWh5cEVVVzkm?=
 =?us-ascii?Q?HmrFu5fOHj6KYRHW+4pvwUmsLrJMXoDupMR/ALTew8IPQ3FOvzimMvCnmyu6?=
 =?us-ascii?Q?G1fXJcMb2O4Ii7+hTqui/L/TNEF2MF1ea0zXOHcMaNiSXSaxxAUGFzfzn3B8?=
 =?us-ascii?Q?qBZFG3rjYH+PsWPQsXQZpT03gkhqeP+AirWQuy65Bn32pKnkW8Y9mh7dzIyD?=
 =?us-ascii?Q?XvALH+j6NfhLXFZQrbOe3PdhOHYR2OdA+bJosgbcdA97pR/UGfzK66vsRdXK?=
 =?us-ascii?Q?KBBa1SyEkFaGGoNufAMotGmr1Ki8aSDjLTnuEweqE6T0Igaq+q6HjV8+QyBp?=
 =?us-ascii?Q?GIgTs11s1FCDFo+bxCZWHbrQQ2IcIMUNpMrHKM1uKnn0ZSqVddPjTXW00r65?=
 =?us-ascii?Q?JGZnyX9w3omwfg3J3/EkJx496UFTCfhxJdrMHAhe2lorieu5HRGpj4pJ/TP9?=
 =?us-ascii?Q?CNa5hoaPPRJ2EhXV2KHcitE0tdFiKt5yVwA0+Z3qHpR+0XCdA0WURyiT9d2J?=
 =?us-ascii?Q?eQcrmuEaZRbQNAwcCD7spkVikIOHs905XGRV3uGJEimO9SJoPVYsodxgmNOp?=
 =?us-ascii?Q?JUaaB/a45vMbiETlBHcfl5n7wkkr9p1uHCnJ/5eQUqKpOzDUIGdn1XUX4t7I?=
 =?us-ascii?Q?daVj39Wgtin0eLZla2M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8319f2b7-fa66-4b1a-deab-08de2d01215b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:33:21.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRuBMvmkwPTQg+DI4rlCCMJQc8lqdr1tus5TWfpxWTVD1kAQoyk58CjwvNOhJM2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

On Wed, Nov 26, 2025 at 04:16:29AM +0000, Tzung-Bi Shih wrote:
> On Thu, Nov 06, 2025 at 11:59:51AM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 06, 2025 at 11:26:02PM +0800, Tzung-Bi Shih wrote:
> > > @@ -166,7 +181,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
> > >  	if (!priv)
> > >  		return -ENOMEM;
> > >  
> > > -	priv->ec_dev = ec_dev;
> > > +	priv->ec_dev_rev = revocable_alloc(ec_dev->revocable_provider);
> > > +	if (!priv->ec_dev_rev) {
> > > +		ret = -ENOMEM;
> > > +		goto free_priv;
> > > +	}
> > 
> > The lifecyle of ec_dev->ec_dev->revocable_provider memory is
> > controlled by dev:
> > 
> > +       ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
> > 
> > Under the lifecycle of some other driver.
> > 
> > The above only works because misc calls open under the misc_mtx so it
> > open has "sync" behavior during misc_unregister, and other rules
> 
> My understanding is that the file is available to be opened if and only if
> the miscdevice is registered.  

Yes, through misc_mtx.

> > ensure that ec_dev is valid during the full lifecycle of this driver.
> 
> To clarify, ec_dev is only required to be valid during the .open() call
> itself, not for the entire lifecycle of the driver.  Since ec_dev can
> become invalid at any other time, the driver uses ec_dev_rev to ensure
> safe access.

open can be called during the entire lifecycle of the driver,
misc_deregister() is called during remove. So this is a meaningless
distinction.

ec_dev cannot become invalid while the driver is bound.

> > So, I think this cross-driver design an abusive use of the revocable
> > idea.
> > 
> > It should not be allocated by the parent driver, it should be fully
> > contained to this driver alone and used only to synchronize the
> > fops. This would make it clear that the ec_dev pointer must be valid
>   ^^^^
> ec_dev_rev serves this purpose, not revocable_provider.

How does this detail matter? It is still created by the wrong driver.

> > What you have here by putting the providing in another driver is too
> > magic and obfuscates what the actual lifetime rules are while
> > providing a giant foot gun for someone to think that just because it
> > is marked revocable it is fully safe to touch revocable_provider at
> > any time.
> > 
> > Broadly I think embedding a revocable in the memory that it is trying
> > to protect is probably an anti-pattern as you must somehow already
> > have a valid pointer to thing to get the revocable in the first place.
> > This severely muddies the whole notion of when it can actually be
> > revoked nor not.
> 
> ec_dev->revocable_provider should only be accessed directly within the
> .open(), as ec_dev is guaranteed to be valid there.  For all other cases,
> it uses ec_dev_rev and checks the validity with revocable_try_access()
> to determine if ec_dev has been revoked.

I understand what this does and why it works, I am saying it is an
anti-pattern bad design to cross a revocable between two drivers like
this.

You want the driver creating the fops to revoke a pointer from its own
fops - not span across multiple drivers to achieve the same thing. It
significantly confuses what the actual lifecycle rules are.

Jason

