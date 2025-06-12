Return-Path: <linux-kselftest+bounces-34852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDABAD7EF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 01:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C28189505C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 23:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4423AE84;
	Thu, 12 Jun 2025 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2No3Sxz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF622288F9;
	Thu, 12 Jun 2025 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749771105; cv=fail; b=OafIt5we5eAotcDjaf/LkH/+g0JDIBBvL3dHpYrfJF82pNy8MevUgb9zVZ1WAp9mbx/vch7UK9y1zQzRqmNwiYwP1QtmdBCWxzOHaxF/tWN8WjNHgAIory7Y3pZYsLGL37/LZbUh+FLOMb/k+cVpH+BJK1LffkBc1Zfxo1B+x70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749771105; c=relaxed/simple;
	bh=ipFF8LbDU9oRnCf0LigGEbvwYvUILV/YCKxnow/s0LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkTcUN4X0p2O73VOL2Jlz1WBJ1KDrDG1UBECVCKh47m4qTsLg+rlUvnyqoBTtMFIft9GNhLASDVjTw3+yS78yQd4aYwxgrRnfN+LOMhGgJnEkORA0FieIid/ghXiY0DtT0b3/h/RePlLgNcV2RiGJt2TfvDJJpzQtBwA95WGbXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2No3Sxz; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhykm5xFg3w8KS/2ktcvQG4+bfUlQWVPB9PejxtCModxEfis4ykmkLrzyqg8jrYefk/nlQdBuiJss1YE7ML7x+rFfGZSn5TVYSbuvQcnmZAgTrn5vG9o81yeG2Mr/oYFliYGlWntbbiqHCEVTiM6z6etD2nmxrDJ3uKfJT9gdTaJfn8XzEHgtZPk8WutBHTqMjRc99MD1AwwTzrcps18v1AQCNWiA/PWSDR+8btG4gO70usiPbg7lCF0XNzeE/cmMnkL8dUHcCoyFRoZJQwZESliEkoepawmehbol+rvM6FnHvPSn3VXwSYt+tzw6HTnwRUh5p6GMY3mEzM33urQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex+pug3NkqhOU4Y+zYhED+PhefgSZpPey22JfRWLrMw=;
 b=TvGrFRadPyn42HJ91vIik+rGBBEvO6fdvc4JfaF3aCaLDn+EPKDPE3Gi+WHKyDLx4xdNtuoePxTc+u6kah68kXzt52P/nG/vsGXqNIXsChvdrk2WyUZEfvWh/ypoSXpJvJz1+pU5xD/lus6Ge4V3v9O7SGKi2AftesNMKxe498a4P4pLqh7XyXq/dnQLmC1bPqBAunql62Y/YhFsZCJ2ZkxICHjYVpXIOwM0KCFMrh0LZq4b1CF9oxqdvKwr6h03BRA6bEYGQbdePknwJDxvkpx/yltNjhogpSO08ASWV2AzooDIhwFIDJtcXbhSGeWg1ygkO+QXRGuBzDhiSl8R4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex+pug3NkqhOU4Y+zYhED+PhefgSZpPey22JfRWLrMw=;
 b=Q2No3SxzHRIZY4gsSfKcwN129DvO+Y0pM8z1EKTdR1WQr0QXfiRvC2//6AID/rBsARv9CB66ALw0Yc9TNwmpXg7121C5Lit6Wk5tCNynN7XH55QUBjAt/5FrpkjJYE5OlXcBn4shwHuTYJwi31yq50zusk/V6RHgaLjXuHQmAynCGDaiwGAPl2O2os+hW+PNmbdfSUVciG4AwYUY0sPNL3Eftx/hHKn88WR+gnvfkhFZBsO1tfHFdEqJowSlqOpCRUsQEWDyk3D++2/alP3XWe4kPrKiGPoBTio3s9J0gP9J6bB0KYzpuJmc3abgCZsU7PD4HmUSvKkBVDhY7/qzEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 12 Jun
 2025 23:31:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8792.038; Thu, 12 Jun 2025
 23:31:40 +0000
Date: Thu, 12 Jun 2025 20:31:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250612233138.GY543171@nvidia.com>
References: <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
 <20250612154242.GW543171@nvidia.com>
 <aEsUGP8xPTDjG0ob@nvidia.com>
 <aEsiJFku+wR9KxE8@nvidia.com>
 <20250612185613.GX543171@nvidia.com>
 <aEskchlFcNL3T6sO@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEskchlFcNL3T6sO@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 595cc25d-9337-4a9a-345f-08ddaa094844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBz/8W5ljU0Kv319QFD6cgcDko/CZ4Hbmu36DCgzKiV3blDXWRj96C1+rhQ8?=
 =?us-ascii?Q?zfpnp9vHP6oZTUa5+bMwCXM7Gkd4KmCwjNyvAU88aCMsAqKXhVLVPBmGC3oW?=
 =?us-ascii?Q?Z/FUnQqkHwRPi13K6txZoRlOdn93RTv5LIxn0W2uX8fRbrYz4YAZxFG90wBH?=
 =?us-ascii?Q?UdUo+W6rozbUcx6eRhlBt5hDWIahNQP84FszV5Yz7SlVt3KdDKVF1wa+xU6J?=
 =?us-ascii?Q?JIyY8dSfNjkuXRvRLa3U9FaHFf5AeQP5ykV7kjOSeZUVpaFnzPSe8kDy0R8r?=
 =?us-ascii?Q?ARE39nHxgzvENUzomv0q7WNA4MxmPDxaUz4Y5Zp/VJO1mzJu7cAyUqRjV4Co?=
 =?us-ascii?Q?IOzUA+UG9gJjE+MxLEM8Koe/H7n4rtY5vTcswe9s293i3Wvl5so3stmF/TWn?=
 =?us-ascii?Q?mp/W5xQ5tejMmIqKMxgmA7N//j792J0hXGmMUcnX9QkqGg7pb3EW/es0FkRk?=
 =?us-ascii?Q?2bhxdTNrvO+BG0ooxvm+EKZEo94uZIGJvIt70HdXJLRaxdkaxqnr/0ZGfeIU?=
 =?us-ascii?Q?o0SK2Ib6cvbqnQ3zF2NsEp009jCWmp2w09/PntABuKgbdBMI67c+SRy0hJus?=
 =?us-ascii?Q?WYQw4MCDywCUCMYYIAZWKegVkJ1JFAjK0EQAOZPcvSlPtLuBG7xIrsZxxhai?=
 =?us-ascii?Q?K7nASQFQ9g8+1jfN3+sOpnZFC05CkeRgFK2JIYFgGetH2KNzBICrcsDaZdWR?=
 =?us-ascii?Q?lo9cTsXSIBTmnyfgwxdOLKoBrKqjbrbdJ5ejgE+zU94+igUJZVoN4wjzGzJ/?=
 =?us-ascii?Q?NYBx6chPCv0rje0UWyAKyEkO6efDIpmSsTQzV4gh2/QCwq9/sJ3TwqOnphVG?=
 =?us-ascii?Q?ZPnzriQkQMYyD3Zq8RJ4rF5EL9+0uSVogUFTWNzUUPeXZEdB4XtMqaSc81lI?=
 =?us-ascii?Q?RHUh0L2TMLaFM2clNGHoavGURXho76fbC6/mSnAH8pZRPqNf1RUak+u7r7gX?=
 =?us-ascii?Q?p4f1DmI63gATkaWp0zDZ0OkYP6tpFTk5nXSpNA0dJd6b6K+pqA7s+6xdk188?=
 =?us-ascii?Q?em6VxuN9SJ+Iuq/uk275AKNUJr7vnJ3ZZxFdjJoemCOF1MpbSEIlyK3DFyzH?=
 =?us-ascii?Q?cgNRLaCxgUHtfBcrMbKCH53sLLX6ilUiCo4rc1Jz+6YXj/JBVESftvLH7frl?=
 =?us-ascii?Q?mLmqi8fm3Clf+z4s8dSwBaUpNq3KUcapaREnVl7U8SH4uRa4KFKr7WpsCnC8?=
 =?us-ascii?Q?HJdODeMuePsiOWnW9z3jlrH+0KQ9f/5K006/fq1wKwdD5U7NaKkuaMQdJrod?=
 =?us-ascii?Q?1iqY5w3DMnSyRuBi1UBwtUmUJe/CLJOgc6vggawGPbujb4mJX5pHvSaAA8TR?=
 =?us-ascii?Q?17x9CfXvN1TjHcP5tWszOnVz+vb6KAGbqJAkcCSLtbZfjQtzsgziJ6I0gIQt?=
 =?us-ascii?Q?+AS4augzFjnE9iqm+UFSzsHdd4FaWDU5/gjQ51uDh2bC2s2+QhsTj/ldDGNP?=
 =?us-ascii?Q?DwwJiVYq4Fw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6puXgiMe8Z80C0DYUnFblrEjisXLn2yKBhecPxWwQHe3+rawle4hqc3Pg2e8?=
 =?us-ascii?Q?cfapT6SfLCMypNy403F3T/mKELI4tbteuYJxWwObMBkeTor+maoYkNvkpAOB?=
 =?us-ascii?Q?q63BNt/iMkQ4Uf2ik4SGFVaT+NzwHW1c2zy7WxD+pzeNn3G5vZQnPepZPOt/?=
 =?us-ascii?Q?n6UV7IJG2Km199BUF1KGh2H/NBqAzlHUYhXid/JZXSievxpzJGoHLKemK598?=
 =?us-ascii?Q?FMIe8qwNGvyR5+FbVv5o3hafBzbYkByIY58NXXRpcwxDwAxbIwlZsJwPgGnT?=
 =?us-ascii?Q?DCci/Dj19M19a3ne0yFgJF31M4ZQ/eS5guzalpxDkfC7gVvoQKzB2tNS5Y0u?=
 =?us-ascii?Q?orhyjR3nSUQw53JWCXVlKhy31YDKLJqFbtko621hbl6isDY6nEvEafhWB30X?=
 =?us-ascii?Q?y8/GZwTr0cOpBsgMC04opsyaRXxruxDx4iOUTqnMHXP9dDle/T8c//6FTj10?=
 =?us-ascii?Q?X2ZyhnSW5G01USZDEKYiWdASZvkfY74oQGYXp4rpGv+NmGMV8nPw36UwBGaS?=
 =?us-ascii?Q?zkiW6id7jn058fG/syHYsOfnVSVHRqpjker+ESjfmMmP8/8ko3IyZ4XzhoR6?=
 =?us-ascii?Q?Ae4Xfg5dU/RqbEPm08NQe9z042o78Vl9ZeQqB16AzAkbdswBh+vNo8dEOYy7?=
 =?us-ascii?Q?2R27KBkfmQqgqHWX2qnALMGFpihMNjhn8qXrLPyiITZt9Pd/H7yRi591jjWy?=
 =?us-ascii?Q?RgYB8BpumuEzDhVNvJFd5MYDvix7CI37O9SZVJgx7HVF8VIvbC1Ezwdqq7t5?=
 =?us-ascii?Q?pCH0+RzYL6IUBGS4p5V7F5/7OwQ5Fc7UKihXw9BtAfIdyQt+DAvFW6y682Ao?=
 =?us-ascii?Q?3DaArHzU5sVjdqS6EZUk8Y6w52ekisKmUSqndDzLMePauedmXY6mitBn7XXU?=
 =?us-ascii?Q?+6s0wxOMWDl7vUBbIWQPVp88pDm4s22bIdFLuWp5F5+rYfEMdONWW970fZ0e?=
 =?us-ascii?Q?89DU4Yi1WCtgFwU3n9e+Izo3fCw3rJvSGYBc5hk2e8wNJFgzvJA5PRGcQXkx?=
 =?us-ascii?Q?ruHnUIS57NtUZo8vjwBPpY6iw08R9Tkc+QFQVjwGM6ZAacpGVcs0g8UtIAdQ?=
 =?us-ascii?Q?PFf/sA23gofjCumK143A0pJAwmyjVA49fJuBuUER3YmvrJ+EvE99SdDNV8Hy?=
 =?us-ascii?Q?QFcnCywhTHLdE5IeW1U2m9MhgzmD8P2ugXXHoVDxRLSoBfhfhp7muu/7cjo5?=
 =?us-ascii?Q?98uNEBS/uZYwiD45Gr/T9vz9viGD9kMjYEGlfp4BSDpW41mvDZFnpNN9ZGbd?=
 =?us-ascii?Q?mbJ07g5VHPkZfYaWxASFWMGEIwDP63c7shJ+OLyHXkSogp8PJJEoLzwAKHEc?=
 =?us-ascii?Q?LTeXy6vUNJx8yow86UuWXOEtXWUH1REIqhGKTOvuMnK+6mV4b3IhW/wWbXb7?=
 =?us-ascii?Q?cYXTFeTZ3xvdRKw9FxcihYujLCvCv7RWkT28BvF0jHzqty/18kosXKnWeVNu?=
 =?us-ascii?Q?M+opFA258HNehM+hUBtoefgBIfMXOx9WlJyEbXimkSRnXE538WxkdZGda/9o?=
 =?us-ascii?Q?G9EJQIKGYf1VerZGCv7z5TggRsUAVa4KhGesjPPhJqEz/2wzqMls1FmNzKNH?=
 =?us-ascii?Q?a18YmldqUqMlqeetKzqdB8ljlMtjFufigdM0orq2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595cc25d-9337-4a9a-345f-08ddaa094844
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:31:40.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugfc4INa90JUHIbCsTF5vpP/1CHuqz6EqKtaNsC7A7G9JWE0AR+4F8hSSITNEvqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

On Thu, Jun 12, 2025 at 12:03:14PM -0700, Nicolin Chen wrote:
> On Thu, Jun 12, 2025 at 03:56:13PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 12, 2025 at 11:53:24AM -0700, Nicolin Chen wrote:
> > > @@ -2022,7 +2023,19 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> > >         self->fd = open("/dev/iommu", O_RDWR);
> > >         ASSERT_NE(-1, self->fd);
> > > 
> > > -       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> > > +       if (variant->hugepages) {
> > > +               /*
> > > +                * Allocation must be aligned to the HUGEPAGE_SIZE, because the
> > > +                * following mmap() will automatically align the length to be a
> > > +                * multiple of the underlying huge page size. Failing to do the
> > > +                * same at this allocation will result in a memory overwrite by
> > > +                * the mmap().
> > > +                */
> > > +               size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> > > +       } else {
> > > +               size = variant->buffer_size;
> > > +       }
> > > +       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, size);
> > >         if (rc || !self->buffer) {
> > >                 SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
> > >                            variant->buffer_size, rc);
> > > 
> > > It can just upsize the allocation, i.e. the test case will only
> > > use the first 64M or 128MB out of the reserved 512MB huge page.
> > 
> > The MAP_HUGETLBFS is required that is the whole point of what it is
> > doing..
> 
> I am not quite following this.. MAP_HUGETLB will be still set.
> 
> And the underlying selftest case is using:
> 	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_IO_PAGE_SIZE
> 
> Does it matter if the underlying allocation has an overshot?

I expect munmap won't work with the wrong size and the test will OOM?

You'd be better to correct the actual variant->buffer_size..

Jason

