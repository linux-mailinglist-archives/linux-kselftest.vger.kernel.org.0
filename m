Return-Path: <linux-kselftest+bounces-48019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441ACEADA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 00:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC6F30038E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B528506A;
	Tue, 30 Dec 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uX1E0HKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB9222560;
	Tue, 30 Dec 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767136375; cv=fail; b=Mc6sPn+0hfTalg6Ccb6gN7qOkwJB4MEcCfA/et+vFuj6P3uan3nZ78NEaMecVNQn8zXBCrJ8YH1YTn1rt7IipskwnnDtPrmd51LPhluHSOBZiR7KtwibhjzDe0GmxLt3gQpRaMl3bgH52frAM9jaV5m/873tG55ac5DLcbT8l0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767136375; c=relaxed/simple;
	bh=zf4ib931/lYGWDRhTcMLr/U2URSLrNjrehcoXDYUkik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fVP2HfyGgT4IhJOcQi1sPNlY4au68taXw3nOZOIQxQQiV3uJtI5uf1rG/COGuNBUFcRYTn4WNM0lUIknq1QPQ+gtGiw54CVQbid/bDc46Tw+/QGqpvZLvf1I2hkNDvpHOBNIc3NLzrQTLzKt+/pdPnttzJZL6bB+SbefkQZWGzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uX1E0HKz; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOhqQJAVgwpNylUUlTXQkay6nEnLvP50bvu3NpthUD7lRK4YVd3q7WpKupLB3LuNJTLzV7umJ5Q2XS2M3eMsSVovsev1rYXxwL18iNNLU9V/N6CK0tXXVoJatYW9UVLK7SomY6yCbmDVkIHMrDCBoepXmxPOpEY45m2Enao+a71T8qIkrnT+Rgm5Dxy4GsT0tKex2q2RmwoieDo8wjc9s132kd70nFnHPUKTZwXDF2Uo199hXAgAhv75T/jA2do9b+V+qC0AyqOdLgD06FaCsj91YIwC87VRhVxKadBKwg44zk5QCSNsvvP0nX1etfCpPmcSIEM0Nk9UcY4E5HTMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pw2lNK3InnBiz3n+2IhSbcQFNrhsG1iAibWLXIQ3Vw=;
 b=kj3+KxIVdfbDW8DYg+bpB/kiDsz7egpxPEB8MNeUWtFYgaHCvBPRS/1uo7ZiVDaOz/UF5kBJwGTzop99BMB8ybPP1VUmagXNx2CuaF9ZEX9zuAHfl99e3ZbiXXYGoMtlTKnQH1cRB2V/dArc5SlDPaS16b81iLGS0etTlaYOBqsviFhkkyGqOJDiF7ATBZydaaTYqY4BogKs9ybX4nS0jGhqAeyhwkBLGOvGuU415Brj0yHJcA9R06FJ0JP6hdmcEf8aJ5jnMhQg5pZiYj7nHEZpxrofF2DhtnqajKynmys4MiPT5JU1S16sRkjDQ7pHSU1oeH8+w8qu1vKkN59/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pw2lNK3InnBiz3n+2IhSbcQFNrhsG1iAibWLXIQ3Vw=;
 b=uX1E0HKzeT43Z38WbQswcj5tf4VTQmdWypQHIQIrfpiZzoGZRMr/k13AljKCKUjVq32oe0+ISi6VCXVAKPDtVKm1Sfzr29/s88MRCc7/Lp/wXhMX1BCc60Cjmha2oeclO1wQJb6kj3jfqCkkeU7DpzSkhCII19hE4vfarrrS3ycG2q49EWvGoA9n7mtLuvecsAf7kG9mUgscK5HtuCMRba92UnkhQ6RN95H1YrXUuPSFzU5LsIE8M8FaguLlUWoK2uRjWLYNf08AQxZpeWoAawXIpr06n8cg41MhjoaNFfmr8dSS4eSdNGsZEEvhIj9zEbTHF7oO9ysEc1+OC7sygA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 23:12:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 23:12:51 +0000
Date: Tue, 30 Dec 2025 18:12:49 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] rcutorture: Prevent concurrent kvm.sh runs on
 same source tree
Message-ID: <20251230231249.GA2601559@joelbox2>
References: <20251228220519.150179-1-joelagnelf@nvidia.com>
 <24f4df13-0875-49bd-95d1-4bf1a400ff15@infradead.org>
 <3a6bfd87-570d-49fa-854f-8d5802549f6a@nvidia.com>
 <20251229113917.1c9568c4@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229113917.1c9568c4@gandalf.local.home>
X-ClientProxiedBy: IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f8fd43-8260-421d-bc11-08de47f8f447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGNyA+pg6Qxj7klAJDRt1yu6Nmw6EXNCmblLRKA8btzVb2IY+WpbMdhyn6hW?=
 =?us-ascii?Q?hjvcnqK7gnylfP0fsv+9XI3Y5/Q7e0gsgmjkdQJFBj+jtxkIE6gWB1TcTK+u?=
 =?us-ascii?Q?toSEuL/rkaylUn9nzGjp4ArC8DFC4VI5YRW+ImfeQ9PhTNUfj3VwYC8TCHEH?=
 =?us-ascii?Q?O6O1xiiHAkfl5/cp4MXyzm1FnKusIqeDGRUwcBBvMpTjgMgDrG3Dz15A0s5a?=
 =?us-ascii?Q?elFauWa0Wj0B4mDb1Mk2Gl5fHrPGGZIEgBxLYSkxTnUtZ4yQDe1yEeVMzds1?=
 =?us-ascii?Q?4UnHnYH6ay7ShgKpWZvgwune7271MpaskMTehv1o/ZWC9deW8zxBY9LNwTku?=
 =?us-ascii?Q?ZqQpHa1vBJWnemt94KNWy8+uc/6FBgg4S2DnZW7hFEyN+w9LbYNn0H2SeBx6?=
 =?us-ascii?Q?9Bs0tLytmaK9qbG0oBHAb6+WbrdfwTKWKeKsT7QUGdbxwKVOojO/kg+7hVp0?=
 =?us-ascii?Q?vpGZyp7a/vibb/ptjTq3KLNfBQ46G5w33rA/znGuRoH9Es3SAdTuo3kaCJ08?=
 =?us-ascii?Q?YeKbvCeDU/8V2C2OY1/sF4+K9lj1W1Yiuv0X/pbNtiTQ9GQPMB8p68MFx40x?=
 =?us-ascii?Q?7tYdsO929uqQVt9wsoPXQq7T5vY7kKbGiQBoIAhOxJICNuElD24K7FuQ5Q5i?=
 =?us-ascii?Q?8VTkvxRt98GH+T8ov3sxGpnNbrD5gkyj0INIKSLOP0DvFbvVgsWLUOpgxwd/?=
 =?us-ascii?Q?rOVos/AgefRXgCBlgkr6jhkLuXB1Nj9069+Q6181cWgHr6kH9MEG583k/ig6?=
 =?us-ascii?Q?acfI3CqGqRzTeCzyPi4zQfd9mOUu5H7cv5s/U8qYPHHCEzFuyxdLAcVu5fVA?=
 =?us-ascii?Q?6wsTl6MBUGfLCwcDG/DwtuRubKhOYRJ+gyEr8n2EXwPdOCEu4AiM+ZLQRDoz?=
 =?us-ascii?Q?VXmWg/dIa29MEp80/21aKY9RVc68DzXQGrYMLUphvcQAXfnuhvl4imHeHD59?=
 =?us-ascii?Q?tPOZSWWFuWQ4K4pX7BIFnjQksfGE+isLshbcVknjiFpP1QWr0Zfc3T/Ltt3Q?=
 =?us-ascii?Q?PlF5Epea39J5rqfhwB9VQCfYEfEz/lOdvfOphgyJD9Lpp1YCbYzMzhvTGlvJ?=
 =?us-ascii?Q?eoggdQDeFw0vY8dJaUvPgZ+a6WDsQ7TimaaokPYzNZRh6SbvbGPrMOjhLEoS?=
 =?us-ascii?Q?NqXdOJp+r++rQTBVk2gGt137KuLDPYewP+eNLaylKjytyPBg7JjD0zkigii5?=
 =?us-ascii?Q?AZ0I75BbQ5jIAp7kOoTve7Vn4QO2pWcBwcQuxhZ0xdu4yZn4FLua3EnfmGO/?=
 =?us-ascii?Q?krbK38FUdDetZtJtMaKdqKZT8b4Wb/oBnaFp5Sb2z7F6ecqweuyjIzngBISW?=
 =?us-ascii?Q?ioN80XeaswkcIW4r6fdRlcjSbfQaLa3ihxT1WwTY4GbCqOYqqGVb5HIx9wt5?=
 =?us-ascii?Q?w0tIlxllobwvRjOqVrVzE19+F8/XW6OWy5N1l3D4ef+KS9CYJ2nuvHcAL8az?=
 =?us-ascii?Q?lUB9pi+zDGvYI423LRvLcATwAhEqTqgh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n01d5bdUZkNCx8BR6nodDJMl0XpRYJyPSeCT6kSn78wnjJjlU+pRqGdMYEmJ?=
 =?us-ascii?Q?vM3LGS7GeDH4cM/dvIYZr9ZbAHSnvvhmPzGXqSrniGtKREm/riOJ2OTgsUqq?=
 =?us-ascii?Q?IvyYbJNu0Vx9rG2yuTGnFM0Xq2QYUzfoO6GjzSvx03GMYGcR0oLawtv1qpi5?=
 =?us-ascii?Q?Ea3pNFxJQIUhEHb8Y8Jt7wXustOv8pLL7PPVYEyxe2NjHnzshHUP5BS8ZHuJ?=
 =?us-ascii?Q?4PqJiRgiFlFJcSRhVN+N3dRXQEGHGfCtG4T8KH8VbV9FU9Lvp6Rjf9Hk9D/k?=
 =?us-ascii?Q?GuPvxPtX/fAf4xg15wX29olvzDKf6hE34s5Qvi9cqlPMvaajPHj2cxjWbxsL?=
 =?us-ascii?Q?qzrYCxZOUHSIxrsX0Ij+cgvq8Tb1MkzXASUzPRj04r4Cyxtzkb08vhIkCrtT?=
 =?us-ascii?Q?STZmJL13wl2qXsjm9okH63SRWfBQfYl70m51rELMzYDCPSLjNnInB+l/A8yp?=
 =?us-ascii?Q?NklcDtD0M33TKlVaQWYJCjsu3LT5HiTD72Cz7l/ji2y6ct63sZee3yz+sQXo?=
 =?us-ascii?Q?T87NHFATIVVpkVdwjF+gqcYXfLspRn1YmKQS06KEtjsY58pMzmgvHscMaNuP?=
 =?us-ascii?Q?qt8OgU9Of3clKXxgG3sRSng1hpd2v82O2swzJpPo5Hzts+GOXyLm87VWkfzV?=
 =?us-ascii?Q?Xep50DMbVDF0zcEjmaKuE3F9oUsYVrVg7AYvyaceNO9HehcEaJ1yBrZunZST?=
 =?us-ascii?Q?5KyCFacijztf1XjsSx0IhiMw5e77+sJrhwvsH7bTwi+d8H9YpHiP496yA/lt?=
 =?us-ascii?Q?VtFzVyUbC0torZNLFko5TjGg7MrpRXnknO51KxDAJqxGdg8ttQIeaESm4Lh0?=
 =?us-ascii?Q?jd6JrZJNBFG+zE6kQey9YdYpx60JLuyp3jXPg1VC0YOutTZK4+oBjLIBWBzk?=
 =?us-ascii?Q?S29jFQYSSXb1EHWwyVnj4X+u0bTzzMBz7VXSBFx4P4nZKxwH0n2zckSgINh4?=
 =?us-ascii?Q?EmyqrydymVqNta/qzeh75OiOMn4Hewbo2Wvy5uPVdOQVo37+NoM9vmSSibIL?=
 =?us-ascii?Q?f/BzPgrswm1YDS5L73ditiaTKx7spUMsu4qRZTQ6SoxW8znyVn1sCEidJB8H?=
 =?us-ascii?Q?jt5YG50FOHUFObg3YZQ/9xJmTvGJZPDvRIvc6pg5E9Exg6ohazPXSx9M9Aeg?=
 =?us-ascii?Q?jm0PcyY71GqtXZtwpkXtv2772iJtaM7DXmd0SZVKk183M9Z0c4Qa7ACWcXXf?=
 =?us-ascii?Q?C06Typ2SRlOrsqCQjPd7/8PF6n2T8F4T5qtwA60+9tp0b7K4BOcwy3VQ0KqX?=
 =?us-ascii?Q?aCoxjm1sQSdopFRWO3r7mfWDFVOXvsa2DaPyNJ8iUHDSngXwPVRSs+dgtMvD?=
 =?us-ascii?Q?r2sTyugbLJayP8dNbG0Gomsc+CSY1KJ8p84OL61zfLTjKrW+vCSK7BsChpdc?=
 =?us-ascii?Q?zHfNc0173+1yCrPyCsEpqS/MaDAGXF0NVmGTKLNOslFR7sHamiIBcVVbDBry?=
 =?us-ascii?Q?VDbCIne7xox5MVRXMdY93djdg04E5N+V/vIG5EBueDo8NzX+RmqhpRBZlBcP?=
 =?us-ascii?Q?6j+A/Ju2xtvdZcx++Al5p8ExGhSfXYWOyVRhOvbw2dWIdlKHUIAH9Q63Cckn?=
 =?us-ascii?Q?M5mqxC5ScRMuuMrwO1RQxeVFbRMdGpCLwspgINGRswqFr3VYeeWz/nTiXd8N?=
 =?us-ascii?Q?pAOdADsOVu4bZt/v5lhvUMz+oRNa/HMC3C/Jb/oorPAznEFmzeuIlaE8hzaz?=
 =?us-ascii?Q?jyuuy2HaUbk536xnwFbTuRTVbQx3zBjCCLPMiV1iMnfpulhmL07YxsKWUhGG?=
 =?us-ascii?Q?OnIZ5bNYeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f8fd43-8260-421d-bc11-08de47f8f447
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 23:12:51.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU+fXj3bHMgeIvw2dXuLRGEQGPp3+7qnDNSepbZW/KFjxYcJ11INeZp7SN59AsZaE2xdHLcJ3M3xVHjU5vpBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Mon, Dec 29, 2025 at 11:39:17AM -0500, Steven Rostedt wrote:
> On Sun, 28 Dec 2025 17:37:33 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
> > >> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> > >> prerequisite-patch-id: 912adecf969d167ddd35b26844249c809a2d4664
> > >> prerequisite-patch-id: 95ca224b0870cebb545ddaf313691fd18dfd04e1
> > >> prerequisite-patch-id: 68a218b9aaada53aa85cf33fcf4afe1592fe160f
> > >> prerequisite-patch-id: e40912ee9655a8abef17413a1bb9b05d2d4520de
> > >> prerequisite-patch-id: c0511755626728abcbed2f76e9a0b1d2f15e7c9e
> > >> prerequisite-patch-id: 0a8814cf3965ce3d5fb30d18db3daf2b96c3db74
> > >> prerequisite-patch-id: 450827b1f88e4ab714a63a24a66bd209f8c332af  
> > > 
> > > Are all 54K of these required?  
> > 
> > Ouch, this looks like a case of git format-patch scripting gone bad. Anyway, the
> > patches applies cleanly to Linus's master branch. I'll go look into the
> > scripting issue.
> 
> That base-commit is 6.15. Seems you likely made every commit from 6.15 to
> now a prerequisite ;-)
> 

Haha... yes I believe my remote tracking settings are messed up, sigh.

thanks,

 - Joel


> -- Steve

