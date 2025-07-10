Return-Path: <linux-kselftest+bounces-37024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FDB008C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63447BE2A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688462F3646;
	Thu, 10 Jul 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VTHmBpKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9532271441;
	Thu, 10 Jul 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164902; cv=fail; b=g2b2Ps/7IJ4LfY5iBWBFJM+BQqJhXdomedqFAvwTSj6ZWPvusBx9R9v75Juf4d45wCirDTPUHFYxy3dLS76dGDGxN5+HbpRSxT8kVw9rE3KhyswZPbBJBuUiXCwmhtWV0TyEBB3bZtIDq4eFWnoiTGnS/P0QnUwhmKPAJuFRyMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164902; c=relaxed/simple;
	bh=67J+hbJfwU+5uqw/mOJvWxDauqUFO5XCw2+ck3PrdOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnt05z2nd8C/GyE9xSsSyB6HB/qyv1g+mNrVMUA8jmtWNVOG2AVyh0dhiROUrmvg+Z8Y1mHJtzkvysDQwJEI6lS+Pw0Etzk4+AgKf/LvvTXUDcP2NZmTxIeN0Z6NS5PPGSzzzbAGL4Wh4ysVIu4b/qKG3/iu5Tm5+fmi9Epm3MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VTHmBpKo; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y110PgknZ/uC5ZPZyLchWlQfAGG/0mmKMtErQm8lmCosvb9eD1NuCBZRbRtmiqVy8NJm7DNCy8C9u7vxrafWjk2CvgrTz5+DXA50M0cfx7YTkCWymR4RqRRufY3t06WsnxN2Nla2TEl+dB3h4aw3AkpaPRuKQ623z5j0Hl0FemYK91CxHpKmR1l+FbbYPOIx+qqiQhfrNH9FnEiIAJnONTVOhDjs0TPaVe8Ow1dE0U7eVo82vPPCXVjELm9hUYCJoSBGOwQbk2RJdvJiw2z4EkesZsBY7/IpicyTj1YgRqyu2Dw2cFCPiw4MgAEn6IaEarQACBUPax+Ig35tA96OhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlawjMIOt6OTbN8gfDuzMIbPl0NgsTC+tdwgRRt1tfI=;
 b=avE6evtV1CMtbOF8hhuJwHnlw/JGXmhDV9Q5dtqkwSisyNGkORoEgrk0FqS2OeFG659zJ6Nw7BQeYhI1y6/UJp5t6oeVj4nWpnW0mJ2nW1COjoR3MtyrwYanOiBHnw0WkzBqAtvlCZR4EpzaNRsDw+rV6RIGK0xVJ16GjFwN92ee3s2hGtRk40eh0aciwE04182W6NIRFLtsjLg41LVnXaVBPJAGCWlVBSlh2il5iEEVRqHCQRCloMHLLVZl4o8Htxydo793kRDAHszv4rExmuIfocHuKbxvXHE8loAT56Iupv8GhMFxou7ew14lRUg9ANw9ldj2aEE+I9Cl/tu24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlawjMIOt6OTbN8gfDuzMIbPl0NgsTC+tdwgRRt1tfI=;
 b=VTHmBpKoGiN0r4yXq6TZcNpkyAH4fnmhfsihMQ0BFdKSkBJS8thE+EWNcqxHcu4RXwffh+dIR7VuawmV85d8zHd0NOeuK5ZOGDtRfvR/M2dwq8DkT0J9Z+i24RAxo3QWpX1/PjAGoiPj/WfU/FAhREFH6J4RDh3KDzQMaB+poIE19LNkcWZJ49fgIUxPt77gf6z59M0LRfvu2YolR9r0/Fiz3om/MvzhLKfhpn2RchIch7i9TpMR50V5GheBaZR0QmUY4B67THxBTslVPQMJpjVA5thICJMmseeROf3WXJI7DQ6wNZtIpqGfbR4uIFjKegt6LgAhvmcaQ8zRR6ijqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 10 Jul
 2025 16:28:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:28:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: wang lian <lianux.mm@gmail.com>, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org, brauner@kernel.org, david@redhat.com,
 gkwang@linx-info.com, jannh@google.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
 shuah@kernel.org, sj@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Thu, 10 Jul 2025 12:28:13 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D536C704-BE27-43CD-AB58-4F55A7C97C9E@nvidia.com>
In-Reply-To: <aG9889HWQ8K24z5w@finisterre.sirena.org.uk>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
 <20250709123224.6593-1-lianux.mm@gmail.com>
 <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
 <aG9889HWQ8K24z5w@finisterre.sirena.org.uk>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bce99f-4626-4de8-e7b8-08ddbfcec5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pEXWbmT3cjX6vODILp54X86H0F/KEg/y4ETc6y7USjJOYDM5ba9js8ppX/cd?=
 =?us-ascii?Q?9WIPkdJ9Iz326r44U/fbjnR3uzlKVn5LVuqdTX0eWBLnWUZT8zexld5NNwI2?=
 =?us-ascii?Q?z4WjE8tcgZpazHkNoMTTeqsZTmIpjC41n7YXTue15uTVkOivMVyPvzXZvF5d?=
 =?us-ascii?Q?mfGbJU4hvfPZ73QNJ7+0NhVThJQ8Iw878xkVfHJnZqp1APR0MHi05RLpunQA?=
 =?us-ascii?Q?aDzOeTXV6kOcKpQhUrogznyWCKDAQJWMiFmvBC9nM2nazKEI7VdDDnlmaiTY?=
 =?us-ascii?Q?yL4dl/v8UcUpGEgv2vY1zcorS2hRnpW6DV7hmw7hBB8nm1E0LCCI+zdmht1+?=
 =?us-ascii?Q?oOHkqy4/DH712Dk+4H/t0QBlaPLuX2X1CFkIwVcw7UXiGSvNmgQdbWPQPXNh?=
 =?us-ascii?Q?iM7sgMtHTUPxoXuABMv3ohT/sr+QkaQFUQQ+5sjxayF1XrQg+1ljBYYkVogA?=
 =?us-ascii?Q?odu39QDmlyPl6kSketlmd4fkven4UPiD5qA2YBb57n5wLyQ8kIkIjLS1SBNQ?=
 =?us-ascii?Q?Ivja3T3ZJ/AiFenl+68ueh1jly1jCiSPm0XyVefEiJhRJoBC+DAfIxhWtcD3?=
 =?us-ascii?Q?w8EvqVg/14IFGuzWXvAeJiV5sW/0h5UJyL6qkMHMhERgZ3qLvTVLR1ND9nKE?=
 =?us-ascii?Q?4691Wy7nI30YmQY07G8F5MIXFElCubbi1ws6zH08dUrV86O6BMpvEC9kliH3?=
 =?us-ascii?Q?NrkgM2M8NCWOuwxUsROFh5/8PZGaUPKgOcitsBDjr1HEwyOjrghNOU7LRns3?=
 =?us-ascii?Q?WaeymEIa8KjoSQ9ujP3ApApm7oaxHjlVW2YmSX4wtFV8R3qdJR7+sG2gzp2E?=
 =?us-ascii?Q?CrvtbLw9b2d9dqnjXMkbQS9iYIGFdUf2x23Tz3HuI8DL9lL5dx5XyY67JOJq?=
 =?us-ascii?Q?u8jRmZk/0ZEPYx5by/N+VYK5vtCIfGIz5DuoN7H9+omh0K1jcEFW+lhydGgz?=
 =?us-ascii?Q?e2tgq+943582TlodzNnHo8ym4wyKnGP2Up+cMBLX6fGnXjeJerSV+0QbA32h?=
 =?us-ascii?Q?DCBAP7sPN6OSBbsHw47T4sUNwYkKtb9hi0aIU+ugq6G8Z+ZsjqXSlgDRDU41?=
 =?us-ascii?Q?GyfUb+qAGezmnxbLNi0ASnhgJsRowYCugj0rxQx8DxG7amMSZPTgJjt10NR7?=
 =?us-ascii?Q?7qBjbopmYsl5c/L0dbqUR2qGcbaiJdu8dtbLqjP1+fCyWS4OTOlGaKZOxtkA?=
 =?us-ascii?Q?0M804JHxFpR2C+Yih9u3PSF7AU8v4O5zQTPUSFypVfPQfixkMGMG59Mo0QXu?=
 =?us-ascii?Q?mWDGaQVfTd6hfpypbSGUKuBHr4GV74VNCD3BdiyUEUwz6GMmCo+MK8ToG3mB?=
 =?us-ascii?Q?Ly3vXzbz/wU7FvYGHtEH7JJJSCEfleNhNA+sYFC2USpdl11rwPi7WkZHtG3G?=
 =?us-ascii?Q?+sUMTxWMYqt+XE1vhHgqp9/PTMXegTz3UaM95NP2P2HKVY2N4UxP2PXxUEtB?=
 =?us-ascii?Q?wO1znsQMY4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cl3/3wc/ssbd8bV/PaqBanUkO7wOioLzb3qkqD53O6av3mo+Me9QZYXMrWLM?=
 =?us-ascii?Q?IrMf942wjNksABleql6c/xdXzjVVaZOCh+0sJdRfOgWgBTGXK6BLRTS8XTEM?=
 =?us-ascii?Q?zlcSRSdezJBN3Rz4wm9kqdmpBoQx2NM0fsH4V/v8oKUFRvS76FMBHnfmbsKk?=
 =?us-ascii?Q?HbzPnLqFruIyu+FhlEt5iGEU61iAx54TfJ791smEVU3G9lDjsWluhwLa7iFY?=
 =?us-ascii?Q?CB5iLJ3IMLHucqu/VVfRa2vnNP+rBOB5R7rlQITchLx5h0zXa1i/rQSR5Yai?=
 =?us-ascii?Q?TlVivMyfrAfGnC6PW/BkdkqqytN5htenoBlTtR/Wm9Y17JFJ2laCC6p2Nq5B?=
 =?us-ascii?Q?pM/WlfLAJJ9X1/dww9SevuK6APnLO1j94F54cgHWRtgBH4sL8EpAkIbOtuno?=
 =?us-ascii?Q?+pvaqET2Jb835qwymnYGUja6EHrGztTj9p1nmP0NpOYPPjbwem/rTVOealy0?=
 =?us-ascii?Q?2bhx3VuAe0oTttlalRqtY7nAc+6rlq22L9h4O5MLmrAyv/BHb21QcGjckuhU?=
 =?us-ascii?Q?o8hCtydrWSpjbIswI8JGCC1XUQXK1dF809LijsxZ79v1mFPHLrP+HgvDIo5r?=
 =?us-ascii?Q?ZLm3IPRTYJyF8lHEJtx0CsEFTh0FAySroJpWmHyptUAZHVXEib1+CVgbbCV0?=
 =?us-ascii?Q?gUVmyUozEd38NBRJr3LzQieiDwTVxFdFatT9MS9frLTyttuJukTcaLRh/Frr?=
 =?us-ascii?Q?6EuZBYecXdBH79Ikj5JShrRt6c1oAciEm8ioL3OO3R+GFpRz1lKEi7u5Zq2A?=
 =?us-ascii?Q?gDWjkANZ0WabSM2XoZ57zK3e99tx8IAnn7W1rYRM9Q9pAX+5y4ykFo4wZi8h?=
 =?us-ascii?Q?u/AVhxwHNXlvhD0hvDT1kQ/BHgGkJcVN4vmm20Skevxswj14MJpBlVtfPNVI?=
 =?us-ascii?Q?BjIdcnBucTeq/yIgO8WwEXv6Z+pIvaIEanHOf3mvDzeAQxLB1t2qLRZKpZ+d?=
 =?us-ascii?Q?exVWxKnciKGf2Gi5jABHVnIWUfu2WiARvsyQb1es61mHeoMxpjFAKbMyYlhQ?=
 =?us-ascii?Q?ZlkIJ5UWK6kuSDTnyjv/legrnGSkTKJHBsDtXib22Y5lCVI6sI8wZXAdbGw8?=
 =?us-ascii?Q?JmpdiEmtcp43ba3UTHJfyYRdFZE55yTEslb1zafCNwrcC1TgvjJvMvKNF76D?=
 =?us-ascii?Q?76Y86NCuhTFl2mSu/w9knmOvziux75h7hhAHKbJxtJGJmAAzhujv3o21rpkj?=
 =?us-ascii?Q?zsZ7XDEvVoMMktNn9J/D7IEQ3mqsRU5obLfkzuMLbaWGDHrZNeNSsD+GECoX?=
 =?us-ascii?Q?vvBdgabelYtWHyG1PFNPsEJBJNj5VL/B0lZ2/dddeVrj7fjsQ/Bs19+2dHZR?=
 =?us-ascii?Q?0uIxyQxXdw9av+EsnJGKOzUkO/tRFHX5vfLwE3FI3E7SqI2TtWoTaRhA54ce?=
 =?us-ascii?Q?cjW0YqXi43ygpBFyudanl995I0oHv93V6nEC/YpcxfUOAz8WtYlUxsge/iG9?=
 =?us-ascii?Q?YLvi+01c9XCQNrgtB3lg+/KF04AaJ56066qIOknObeQchf1W0MEpPTJ+Gc8I?=
 =?us-ascii?Q?y+xHXGi9Apr5SYZLwQjuZvf4FOnI84nVVj9AhZtToeTNzpZD1BYG4J08MCwh?=
 =?us-ascii?Q?vOuukWqKeHLahmHoHTOuqHgOiLlmjEgCuRJOtQIt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bce99f-4626-4de8-e7b8-08ddbfcec5cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:28:16.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hz0BnRi4eWZ8CH8G51G7UeJ0gsVBPYgfzWGJP/3OlDFfwerxQ4c5sMfnFAncl32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

On 10 Jul 2025, at 4:42, Mark Brown wrote:

> On Wed, Jul 09, 2025 at 10:46:07AM -0400, Zi Yan wrote:
>> On 9 Jul 2025, at 8:32, wang lian wrote:
>
>>> Thanks for testing the patch and reporting this build failure.
>>> I don't have an arm64 environment readily available for testing, so I
>>> appreciate you catching this. I suspect this is caused by missing or
>>> older userspace headers in the cross-compilation toolchain.
>
>> Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
>> should not rely on userspace headers, otherwise we cannot test
>> latest kernel changes.
>
> That's not realistic, we need to be able to use things like libc and for
> many areas you'd just end up copying or reimplmenenting the userspace
> libraries.  There's some concerns for sure, for example we used to have
> hideous problems with the BPF tests needing extremely recent versions of
> LLVM which weren't available from distros, but just saying nothing from
> userspace is a big blocker to getting things done.  With some things
> they're widely enough available that you can just assume they're there,
> with other things they're less standard so we need build time checks.

Sure. For libraries like libc, it is unrealistic to not rely on it.
But for header files, are we expecting to install any kernel headers
to the running system to get selftests compiled? If we are testing
RC versions and header files might change before the actual release,
that would pollute the system header files, right?

>
> OTOH in a case like this where we can just refer directly to a kernel
> header for some constants or structs then it does make sense to use the
> kernel headers, or in other cases where we're testing things that are

That is exactly my point above.

> intended to be controlled by libc it makes sense to use nolibc avoid
> conflicting with libc.


Best Regards,
Yan, Zi

