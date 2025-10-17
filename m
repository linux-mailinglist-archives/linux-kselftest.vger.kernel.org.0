Return-Path: <linux-kselftest+bounces-43396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DEBEACC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B55175C5C3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8FF2D0C8C;
	Fri, 17 Oct 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcchzcLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD428467D;
	Fri, 17 Oct 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718086; cv=fail; b=bJ3PWgbRcXZxHJA5+ZNZx5ihQiVnLGg3ZhUn9O0XmKdg9W21oQ0mjczMuExSXig9D8booi2DKRjimSMSX6c8Ki72SaVCozvoC04JNRaeQCgAdgojfMKxCVllv0FqM+noSTeyLbAlcTvgQUPaPUsf5fb697y8tNE2TVT7TgKKFBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718086; c=relaxed/simple;
	bh=yCbCucWc/w9l68/UtzJ7EMYGi0e9isg1DB0LeVZ04SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MzBkiD74Xedtt38LCC6ONAXUUK8MJBtDzX8aAdmwoZPls9nSKjvckgDs5BhDVKAvg3r54S8a4s6RUxpLo+goYCu/C67iCJ1ER0d8xObNwJQLE2cfGXHIJXn5i/+GTnabrQA3Beb7uL1mLUxRymBg8Z5hJ5SA8OMwTfTpnzNfnr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcchzcLm; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y780zv1I1y+ed6n6uk3i7KmWaKLmRI1l2qzJ8A6ZXFUPu5FaXEdnUiQdUA5Pt/+eu8o1lNrf597WUicgjCvFMD/cDcAUeUKsRIqTvCWGr8USVr0BoC7OGQmZjqn+MLGiS7VN+rDjsUfrjorRBRQsB4sR9RS5B/v3ZgRUrLha9kgKhXBfoAbr0TYO/aBzDhDD+h5cnq+miOpNmIR8wyMELRrvb1OXCeL1x63CB70+Euer7/ZGooJOa1SALxw+MfHaTE9t0Z+m0p3JlWfznXnKRckd8KNe25CuxcAl7HT/SvpFMLaZdRyy2yElXltS8H7ykl8QHJcYs8B1J4sog3AVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n66ZoMdcPrqShCYmH8A5k0V41u00nX/qkzEsVYD1ZAg=;
 b=vrFVCgOOz8JVrT+GDxioG2+1ZEezdTxfXLVHlU+eR2gBlCl5N5+Za3i2M+KItV1PT6AgbjRn49h6Sl1dmYj/F85cEb2BtPqLM4OUqL1Kacb0frJ2wX49601RQqGt+/90YtvILjqE6ddJKAktzNS/+/YgAFf7DECupYkVnRLmpbPPfvhDPJC/9wk528uc7BLHZT63JpX9pnheCIePkJWGEGyrCx+MvwCp8nuYG79ec0JSVHMOyYf1FTxGS7XMp6V6DltXh4plqeLut/rOkqwu9Qi0AP7aoPNcNTJgMeALmMkZC5zL4eku8qoczfI3cEAFp+2hmWasNS/7cufq3kKVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n66ZoMdcPrqShCYmH8A5k0V41u00nX/qkzEsVYD1ZAg=;
 b=GcchzcLmlXwesjAqgVV15EuiW+QwGgF4tRozsuDeksfsHWcaPwj6kWtT8aprz9cz7M9PJxCNuzH/7YRiI1k7A15w0Q5WDWTzbbfLvIxlGQ5ypHsn2F35tGl2X7bmWTK0nTcCTaPk4x4BClScsF5QaXvhzQabavSh6LCIUFlc7GFb7AuLK/DVGIKJc5XLk7qAKwbH6/YdAJBFYLBH5EFFhtAkGZLst0zedPKqrny3v+2eSGC40rDxJ5GD17pQB5n75SVICxXcjMFx/L4rGP6/M6p8LhLf1KcR+3wgbaAYjLZ2RZ3v5mVKWd+qpzrXh45t6RtS27Ud2hpWz8qn0Oc7Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 16:21:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 16:21:18 +0000
Date: Fri, 17 Oct 2025 13:21:16 -0300
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
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251017162116.GA316284@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJp3hP44n96Rug9@tzungbi-laptop>
X-ClientProxiedBy: DM6PR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8498abab-8fef-4a8a-7484-08de0d9933e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mvVp/lvzdHzW9Ao2vJy67WsIUJRiVsU/2FW/sepDX5ArBEl3WU8Q5UVHZfEA?=
 =?us-ascii?Q?/vGoKQdBpNZhZyUHEwRpiGw4MQKfZp/ZHhbLQWiIr+GvjVaRkbsi9hm+Eme6?=
 =?us-ascii?Q?BydgaRZRVPjFiGgko3JI6ah02YVqCe/0tnx6qb1fImdsD/+/G8npuQzSEAjW?=
 =?us-ascii?Q?iY3X9eksAqrIsoBGYv8ITEGYjPv2iq9yqnQ1mP+qrZgiqGtC04GpxRoAKmM1?=
 =?us-ascii?Q?NYF1kx0opQWLl5Cpy6AuZuW20GQI0oxCAYQQmM4TsQ4ttqph9/t7lQRJyCC2?=
 =?us-ascii?Q?3vGKh8VeZQHpYQBuREO2fWRmIqQTnfhKUWHH5jPwBb/4t6BU9R/cfoDfXSwl?=
 =?us-ascii?Q?7LTFp8NHm6ADP7QVrrZ71OOPXXShxTIRjTs050pT+L5wkPbsMDd+to6Fbd5M?=
 =?us-ascii?Q?dAhW8oYyBpymVVzHPIlyrpzWhzhP5oY6S11whZx6dzsR1edo6Bb8CqZzahvr?=
 =?us-ascii?Q?ZXvqd/nVwMd2YtpduU98PEGhavIb3D/kWBKO6zjw7m+HjgD5e4IcjHBokJkI?=
 =?us-ascii?Q?QJoeY10N7nWHKEaM2jcbliUASYJzoirKc19G488nXn3vNqQI8MWClhY87JBN?=
 =?us-ascii?Q?Iv6wmlLcaT58s2xd9PQpKe9MnWP/qulWahLMs+XO8iDcsUlD7BZCpEXgdJKI?=
 =?us-ascii?Q?4HG/YD1sth9kI9mty9giy1ufSvyo23vt7f+01pAk8wx9wplywGWGl3ueMCIr?=
 =?us-ascii?Q?aU9uoR80vJ6d6WGpSriI7i2HAPtBln0aZ8vDK80BG1lfA0owngIBJmJKGXW9?=
 =?us-ascii?Q?QRNJ9Ec2oil/EJpEAEw+cVMqGGAZ2+O2sYb6ubQSFlbp0mLtP7kcur+50bag?=
 =?us-ascii?Q?Gkrp4Uji7ULlklTecyFgjTT6QVf8dAoqUPQP3qBGBI/XasWY045H8/7+05MT?=
 =?us-ascii?Q?7B8GakTeFSjVYg7N8HCRlAohtPY89kajZnrEvCErkZmhFv/TDMTheg8fYDDS?=
 =?us-ascii?Q?uTM9/E9ZmaLHPkgw5e46eCtdXoxEAPXfFayq8hFdACh1DMlNs7XpE1rgTraQ?=
 =?us-ascii?Q?X57Oxk17sqtw4PfQbOcCnxKzg1Kyg2TJM4erT3RlOBi/3/Guz2zmnNfGpq49?=
 =?us-ascii?Q?G9MjFMPiHywY8LnefB+pBkNVHjlTkoZEzhvD2a+25uD5lOm4wSqa+SU78OhX?=
 =?us-ascii?Q?GN4gKKRKDpAr2LNT9jQ4PvJemNPMGKIYTpVU7rc+W788ENTtqtUEDoBv/2pP?=
 =?us-ascii?Q?wwr4LSQ8Mngc/E8HPjMqglqyP1779ph/bDz3Bua0JCxxEUmHT2M7QFZ2BvXD?=
 =?us-ascii?Q?JxK+T/YgvDBmFCgo6wlc/pp+OKE3Qq1icJ/KQab1NUG4GZwK/pQYiZ9V1eWS?=
 =?us-ascii?Q?VviMDoc98dhblp/Kun5Yebc+QSMUcJT6cnlLlV4PNj/7PhKSHlhpdjWG5yhy?=
 =?us-ascii?Q?zQe4GYohNQSkFzL50TvnZ9xTfwzkpX8pQG2g/bt3ZrKfM37t6/KkHpCO1G6l?=
 =?us-ascii?Q?DiDvnU+tdZl36Krob0WH7s87P9MHJkuK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?roZ3jzU5ZzybV60pOvHvQ2RXRNkt5o06+HT1ZIFZPlByz8BFrzyTQGotaoG1?=
 =?us-ascii?Q?1fjCDMMx749zPLoHvT+89uLXHrf60LV1DoHg7JepiVhSGk5fJ+d4jswIhyLv?=
 =?us-ascii?Q?9u8M2w8DH9l7Il1Jkh85BpuYF6WYYK++rGe73kJ5rl7Xuk2CmmYpmpkKpgmk?=
 =?us-ascii?Q?l2sD7VxG9CTjTRYqYZ33npmebiM34BY26xzC8UR9S/I0Rmtb+6wfnxvqdqBi?=
 =?us-ascii?Q?BkDs5ad30bK8xAZDExtPqKalNXrP6kQHeJydUKHCD3SAP29aWHupc0Lckwvz?=
 =?us-ascii?Q?g0MJ1HhAtnpr92GFaGSrxT7+jktqI55lxvnxj11OqLkMtS48LSFSE/3aBKMg?=
 =?us-ascii?Q?l9LokwWFZTC4inS0u7wbeki/7QKnF5s02ckHcLgLdgPrHZv2xloJ84hnKyCh?=
 =?us-ascii?Q?0Hj3WOlK8sgnkRBMTF+yF2vYxHPWw5TKtUMxs3zt5lU9ZlWXVVrlfEjwSTsB?=
 =?us-ascii?Q?JfhAeXIHvmnDFlV4Gyk+bXwLR160bb8kVKUPJIZFW59+A5e16Seijw2uNElU?=
 =?us-ascii?Q?tpRiG5RZHwR7yhLuH2Gkex1Qsv3ykB3LMucTT4Kwnc7z2cxs9Ksw81njTFP3?=
 =?us-ascii?Q?WQ4Fan90SHpxRU3ATMUtj+TLrDdL4BrSPCaY3BHcafR/cgNOOcGplObiWKb8?=
 =?us-ascii?Q?ormVn6b80nw+hQB+g/9Oy+0hFzWkoHy8WFUP6IQ0y8V2mLq5j9B8OO9w2txH?=
 =?us-ascii?Q?t3LaOrLnrZ9/EBHRuE4BwbAUuuKH1fpvd9CKpL0/1oH7Ah/qetM2qKMlyIt8?=
 =?us-ascii?Q?U/YK3y0CpLooDeAKQJYnOcRGIEoykEOjzBwlpcZyEVBv84qhHOYF1z0erIZp?=
 =?us-ascii?Q?nZ+kASNm4d/RjC7yMK3ASFatUxzOgVv/QZ6O0FSFpU8abTWgqD1dsvcFmyPQ?=
 =?us-ascii?Q?r7D11Nk4XbUmoSsZlsiShObrtGX1TFaGp/5Qla/fBJbloNX+/X5J4QBu0DS6?=
 =?us-ascii?Q?pRjzR6fxNkeo89DyTJJGCemgx+p9fZS+KrbYfZ6+bLlzd0RMYs6qY688CXDv?=
 =?us-ascii?Q?LGvI2rfArfXBjhs36IAFIh6A3kT/7xw5WpYIL0oIKzvo4ftgYSbh21xVyQU5?=
 =?us-ascii?Q?D0iSdZdYHGukryrNrGvp5yVj2DR0AR4GAylWFQ0VFsVKACNf4PJ9B2A9ILQx?=
 =?us-ascii?Q?ccyDdXeq4qQo+O+ntloQo3zyxKmrnl1UyOc9Mfq1r6XFJZhLmAqsmh970C6X?=
 =?us-ascii?Q?EAgbkALHJTNCwsI7OHAV6OvZf53CNKz3zOGOfbyvgen/+yFhK2IYyd4P1onj?=
 =?us-ascii?Q?B1CD+nFXJHHkvT+G+7a3evSw+o9HaMzV1QTMXwsxp2kpnHfFOe/EbkSIJcBu?=
 =?us-ascii?Q?iDtPGlCG5teDJq/hC8CHMVFmFLAYdgrvrOBpyakKnoPtv1leMrzcFQqJFxQR?=
 =?us-ascii?Q?uKEvJUV/K1x8sPkS7TcAqVHG4/0Y4OSfjKPhYtPBNj4imuurDHYHgylpY3QT?=
 =?us-ascii?Q?Rmc1/6XeM5j87RMa+raneLHFP96PwOnixiTZ98A5s5MovNVSMQ7ZYhV6dWbQ?=
 =?us-ascii?Q?JYSIb5d2JRmcaf6hSe0d7ykVOy4o2a02bT4IVUq8/wVpQSy3PkRuU/Q/1LIi?=
 =?us-ascii?Q?g9OvipQzltEJslGtJ3iDwuTZjpLEliU92dsc4XdA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8498abab-8fef-4a8a-7484-08de0d9933e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:21:18.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VGp8bRIyVsMJ+PFxDVSJcZ4e71cWqRevWsz5GYzksM46lrpv0ZMPdyc3SJ39VZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

On Sat, Oct 18, 2025 at 12:07:58AM +0800, Tzung-Bi Shih wrote:
> > From this perspective your example is malformed. Resources should not
> > become revoked concurrently *while a driver is bound*. The driver
> > should be unbound, call misc_deregister_sync()/etc, and return from
> > remove() guaranteeing it no longer touches any resources.
> 
> Imagining:
> - Driver X provides the res1.
> - Driver Y provides the res2.
> - Driver Z provides the chardev /dev/zzz.  The file operations use res1
>   and res2.
> - A userspace program opened /dev/zzz.

Yes, then you have a mess and it is pretty hard to deal with.

We don't usually build things like that, and I'm not aware of any
cases where killing the whole char dev is the right answer. Usually
it's something like 'res1' is critical and 'res2' is discovered
optionally.

Making up elaborate fictional use cases is not a way to justify an
over complex design.

> If it ends up call misc_deregister_sync(), should the synchronous function
> wait for the userspace program to close the FD?

Some subsystems do this, it isn't great.

> The design behind revocable: the driver X waits via synchronize_srcu(), and
> then it is free to go.  The subsequent accesses to res1 will get NULL, and
> should fail gracefully.

Yes, I understand what it is for, I am saying it is not required here.
 
> > For this specific cros_ec driver it's "res" is this:
> > 
> >         struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> >         struct cros_ec_platform *ec_platform = dev_get_platdata(ec->dev);
> 
> In fact, no, the "res" we are concerning is struct cros_ec_device, e.g. [1].
> (I knew the naming cros_ec_device vs. cros_ec_dev is somehowg easy to confuse.)

        struct cros_ec_dev *ec = dev_get_drvdata(mdev->parent);
        struct cros_ec_device *ec_dev = ec->ec_dev;

It's all the same stuff. The parent needs to ensure it remains bound
only while it's ec->ec_dev is valid. That is its job.

> > This is already properly lifetime controlled!
> > 
> > It *HAS* to be, and even your patches are assuming it by blindly
> > reaching into the parent's memory!
> > 
> > +	misc->rps[0] = ec->ec_dev->revocable_provider;
> > 
> > If the parent driver has been racily unbound at this point the
> > ec->ec_dev is already a UAF!
> 
> Not really, it uses the fact that the caller is from probe().  I think the
> driver can't be unbound when it is still in probe().

Right, but that's my point you are already relying on driver binding
lifetime rules to make your access valid. You should continue to rely
on that and fix the lack of synchronous remove to fix the bug.

> To be clear, I'm using misc as an example which is also the real crash we
> observed.  If the file operations use other resources provided by a
> hot-pluggable device, it'd need to use revocable APIs to prevent the
> UAFs.

I understand, but it is a very poor use of this new construct. Come
with a driver that actually has two resources and needs something so
complicated first.

Improve miscdev as Laurent suggested to fix this specific driver bug.

Do not mess up char dev by trying to link it to lists of recovable and
build some wild auto-revoking thing nobody needs.

Jason

