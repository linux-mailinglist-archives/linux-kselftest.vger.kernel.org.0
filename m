Return-Path: <linux-kselftest+bounces-34837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AEDAD7A0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8F91893B38
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707F2C326E;
	Thu, 12 Jun 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sncyQV5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C529B79A;
	Thu, 12 Jun 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754579; cv=fail; b=qaRfdQL5gIyz1g12ibA3xdoMFNreOgbQEuuGDWtbZdmCaujB6hBfmh3ognqEoKMMs7AQKaw0AeOgIMRybq1CdAa/HJyxxmWdamSLnPTNdXagUlK8tzfiS68eKXSBTyR+5L3fAlMJC+4d/b+lyPumWl1+z/Pf5kopDRS8Ms/zeg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754579; c=relaxed/simple;
	bh=OmyDhv4ea/3dab+A3/4/YjFtbmq8XeyDvQgcCUbEUqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tRtVrUJx2wkuCz3qCmZQvxhAcTPzSfrv8/j3TMsqNPt521qUP5hfBCh3t6MSFOWavav/WTUKVGmJjbP2v9l/lc9NW210OWz78p2d7OhEYBLZHG/VITNinSTLHf5NhWNHZO9Rh0DYO9APfGWsiRQvsf47tJKVj+/KE/JpJU9D+/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sncyQV5y; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPIyitMvIPgJRcY5tgFlAXBmwtEQTS2oBOlUIvUvLnGCcVFBVZR5iOJ/+d3NnREACOKNaIZOtO9LJp7iGS72Bu2pBANIOo1r0aC2TJxd5v5UUL2fkVcFErrG1gybDbmh8deMiqthYc8yA0h3ALIOxM6HDE0FQxHYz2/HZnkmLTyHgeIu4cAffj+lJB4j9pWwWTV/qwCytKsxM7xT8LYmTz49inFX0LQX4jurbWYXGkgmRnyBoDja0f0iPKubSoBvzApg9MqyAHHa73i0g714GPtJlSDLZG+h/xR8v4trwHailxyEkLDAGKfdmy73UvjfvTFMakdJdT4s4RQifxRZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K80TgxzigwFQ1VFDwUoTbojdefsO4qyvRZhyIv7U8U=;
 b=D3QdPyZYztFtHWBDdWuWAPlbBWoMNwQaBQ9BfrkT0mEU+DbX4pmNwf2upG9gzTuS3RH56ZlDydA6E9pVk4ODb/ZOE3FgN2o/CFroTUrFFiKmNOrLroDlLH1xh+mhSAveMErdEwH3pWQKkuNGa/g/n59tPG3ftSlg2XdT6n2aFFNcUWGvyjzcyadELaiFQ3eO5EIX9gVIaqaoErIJU91LHpiwfDVrM5Zu7ruEuQ3Dk2JZKS2OHS1u8TUpFNiyDfjJeXZxKYBuocoWJ64Zy5OYVVnpET+50nC+4eZWnDks39QQtP6XVAV4ijJON8m+kZRRxuhfBbcwX/SPO2T+0FYpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K80TgxzigwFQ1VFDwUoTbojdefsO4qyvRZhyIv7U8U=;
 b=sncyQV5yc67mxtnKRkzPARDqHum5sGGMGiOr5t/Yi5oROi6Bv+JffWejf51U98eTb5Nwbu6qbXkXIyOP5zUu4jCHfh9p7obgchwAIYMy/5CuT/ewoXQ/04IMHvZrAbQLr+QuFwPOaQCFyQbwQ6YX4YXtAqzxfp/CGhXi3qe4fI8QzC6GnP/wEcJezGBoZdUkOiGJf1XJRA4S3e1hpk3skI/FotILLAPk6FurAsLd90X4oph4LZr6i6slbI97eEpC3nE1LudeRjFsZpvA2ms2bQERZ4lsA7f0G/e2+04pgA6BqtcYcXEfrXiVatpHyPEA52ap9xQlHkey7YuJB5L5/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 12 Jun
 2025 18:56:15 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 18:56:14 +0000
Date: Thu, 12 Jun 2025 15:56:13 -0300
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
Message-ID: <20250612185613.GX543171@nvidia.com>
References: <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
 <20250612154242.GW543171@nvidia.com>
 <aEsUGP8xPTDjG0ob@nvidia.com>
 <aEsiJFku+wR9KxE8@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEsiJFku+wR9KxE8@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::12) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SJ5PPFF6E64BC2C:EE_
X-MS-Office365-Filtering-Correlation-Id: da0a131e-fa95-46bb-1ef1-08dda9e2ce3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGXtnKWT2YE1b6f5ZdrTy8TqKs5xzyo518ZbZZL1Lx3IJheMK1cE5GZpC2Ah?=
 =?us-ascii?Q?VGoNHLclVJj74sJZKNk9obxmoTpr5jLGlUbOjqErxACdbkGwyk2chpxxnNvV?=
 =?us-ascii?Q?kUgz4JSbj/Ks9amCW5GseiszzkcpeT3Y/PgGEjGFiM9J+ruw6lDR4YgdSlXJ?=
 =?us-ascii?Q?6CU0Qyvgm3NDv6d9Zj9RnehDqai6jIWfrh4d5V4Gl3m4C3JrJE0OHJHPGnUG?=
 =?us-ascii?Q?J2/uVlmNlJedpPxnhP4VZiGELuvOMZ8EY76Pl5iziUog+5iwHgTKznSL/uwK?=
 =?us-ascii?Q?d8YM7AnRuSAGnlJCxTc6UU7XZY/TXlbVLRa0xDtS0S1q/zJHJT8vmCj4KWiZ?=
 =?us-ascii?Q?NjVzzojtScxxtqXVXObCJ9MgVHMohrzH2Updhrz+drjENKDhSEHnfugE2hHQ?=
 =?us-ascii?Q?q3NwGQQRd0zxuXk6ZVPYaemnFRcRpe032hkkgZs5HYrvTwQguHHJpUGqR6Df?=
 =?us-ascii?Q?T1hxHXdbIIy7NTv6hv7DItcrUaiRPGiUVw+66ksRtDGxr3RxvDbjTXE4bUGq?=
 =?us-ascii?Q?+HoOIQdU2JeLfLqAyirQJslcRSevhCEtoyY/DQmMdkwl6XSRA3gGJ2LpOaxL?=
 =?us-ascii?Q?avCc7FA/RNvER/docmOCPh6FIVCSKJpXu7i+SnekJer0dllEDUJ0zZW0V7sO?=
 =?us-ascii?Q?KAO0i1/cAdR2+U4zk9z5XclNz5zyPVusbCEF5PYq4dLeM4FBGp8SQY7XVce5?=
 =?us-ascii?Q?ABJMxwXAT9ZZ7zpgAYARASDE+TXacEmBgMhQEDwr0Sx5t+shCxeifEb/VOhy?=
 =?us-ascii?Q?p1Ar+TYOVfqaieBl0kRCOEr5CCtNhl6uqhwcM3kty/IHic0P1E9EYS4N14Eh?=
 =?us-ascii?Q?mu1LlsBc67zEgN7L+gKiut+JGymXmr7hGbl5V4PHCKhbmuyN5ufijXs5NA76?=
 =?us-ascii?Q?qTr0SBNqQcZp4Mcm6H7g3rtARNoJ7rpR+dwHNb8btr5Wsri/Dab9SMo0bxvU?=
 =?us-ascii?Q?TxdL59bNUBJdPHao7lZ5YQkdqdAqv4hdLvcSdbtasOFaAWnJI2i7gajdaZQ+?=
 =?us-ascii?Q?92CaSSKmcY9k8YNWbqj2LyrIWqVaUBy6xftc9imYzNdIIuVJ2+uUCOvYevqS?=
 =?us-ascii?Q?GgCTlrCguAGYxKpyB6nWOC70s+kEg0vbzGWp3jRsloP+Uso0yfCrpiTPM+Qj?=
 =?us-ascii?Q?ObpAILb40xERhHFfEtJWAZFH0PwNPfCcxUFDiqyZ2LoWWX1hi7bcRS1kVpJM?=
 =?us-ascii?Q?vHYd4kchM/Mm/2HReD5KF6T4Tm+Hu8WjuWpMTZ6lCDx8l/8sN4NM/PFGaR/F?=
 =?us-ascii?Q?WqFwUG9kBUKT880a7d3zk3lFvpwoTUf6WHatYINYzRGr2G58M3G/t6fSQN06?=
 =?us-ascii?Q?QPbXfhgKCsbWwPJxnRfxYTHKadKu1gZKA3V3jZvaIkgyX/QqulkS/H6WBSvl?=
 =?us-ascii?Q?v0C3OheQlA6kKaesCTGfpCKwSpObbMOKvNjxtFxokqorkNOATvaw2W6kDi9o?=
 =?us-ascii?Q?VIeRh8uLxiU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LGlbi7e5Tlm33jS6DDgtq4ZROb+MQdyxAYyew1QoFR14W83nWIPPwOVEapiK?=
 =?us-ascii?Q?hG3j7z6f1eOjTPM9DHaykZuEKWEpC/Fld1zYjyqCjrvTQol1FZV/LBQ2lzl4?=
 =?us-ascii?Q?rnTBAOdsQNZv0jRQRKfqb2BWGdGh9QKm3QoUkIR4G5yFqZ30ecMUxYjr/x3H?=
 =?us-ascii?Q?jyuFTTcO/k3GtKwfqisyNZHDiDYL+QzcB0DCqK2QyvO8jjnNmXY7w9B1pOJ7?=
 =?us-ascii?Q?isA3wBHiAYsb6FJyo/ei4GGUlZZGRl4qxCA/plrj+w3XmD6mfx9Pef5RKTzG?=
 =?us-ascii?Q?q7Khy4kJMlsx7z2gJMPLMFOJnxw5uBmn1b9BiAapT0GXL+Zp+Fsi/xEPt1QR?=
 =?us-ascii?Q?0+tr7vJK7Y/nviq1qf0xRzmv8b+HmBmmiH7hgBkmQhrZYXHxTMwavuqGPs0B?=
 =?us-ascii?Q?8SR4nqERZ5moLesBM7qSD0pQAz2QmnyFQvN7DfVKL6xi8aO+/xDY56ggn7oO?=
 =?us-ascii?Q?p8OCkxHnL7gds9PfefnZ7s+GeJxcwI0VwMW2YG4jCc26hsJSp2m4evoJJMRD?=
 =?us-ascii?Q?dpFpN4EWBjhIqrRAIqN4kBLMIgH1DkLgIFZ78k5w7/QxzCLpa/apOIziKjRf?=
 =?us-ascii?Q?IjkymorrxMlB9WEZm9J7SgH2mr4d4YcaH8lhLzr0TrGqs7m9jmTTRS3UCCPW?=
 =?us-ascii?Q?0l6fQ7JdDD5d1XF+hSKB7YbD9RubE3xf5Sq81v4wBODBSPkgVgVj/TQ5oCLV?=
 =?us-ascii?Q?UuaS565JMPpEGIsgH8LenyTG7coREq9pKx3xtN0SR01WNFw46qyEqKejEzKU?=
 =?us-ascii?Q?ew0mDlN8gftvi7Z7dNAao/Xtw55o+cUJc7MYpdzQsjLzmlFQgfMoIsEGMdcJ?=
 =?us-ascii?Q?ujQuy+fcij39LmqekCIMC1aQYWe+eYfGenjDCcVNM5Q4bbBR8Z5ND62T+n5Y?=
 =?us-ascii?Q?Nska8tr06uleEh6oK08t79qrV7cPhwmxMHUH+Mu5VtxYhGtzcbnLNjARqihy?=
 =?us-ascii?Q?enD25YjQ+zc2JDpFUEysaRVrU2CkT09I3sOLmlF23rpQxFnAV+4x3i3F1nOx?=
 =?us-ascii?Q?z5xwIA0yV231r0+vhr9KkNXNaO2fzbaQfktysDMNu3JEzc7DHzbwzsk+E7ZN?=
 =?us-ascii?Q?JxHsc8CVj80fJsXFcuoGZElrK9y7jCBmVN5u70saLOFYexMLl7l1GvDE4RGf?=
 =?us-ascii?Q?jigxbiel6cX3W5nUSJxcErQTAWRaurGfKXn4EQeS/7++wp2f4FKilULv2muQ?=
 =?us-ascii?Q?HY8qr36NbrEPAzq2q6DqY/z7AtnZ0ML/FsSESlAZt+7xW+QHkvuOFtdomhdW?=
 =?us-ascii?Q?wykR0O85z7QJ7oLYqZshgF4vOwaPSedO7lLodA1jQFZTQuT0C2YUTD3ZWYQe?=
 =?us-ascii?Q?UO6JTNfe/wYWIv7LU18OV9XYlQDJuwP5IyUaGMHe3yK171rLjlKgEhsNmVxy?=
 =?us-ascii?Q?SFjqa+5jut2AWCUJXb/mGIzofZ1CpvuDHcqD+I+CkvU2ktYzLLpG0o2nPng2?=
 =?us-ascii?Q?yWbg+o7iv2ZwSGL8vd/z8D2Wr4bbWexLXVnYN3HU+jZwi9Rdydldj6cj2Ca9?=
 =?us-ascii?Q?JJtTm+J+r7BXHJS2oSe7IeWG6xpMkUsROQCthmTwOKfxem+hwLXHwE+8uKZP?=
 =?us-ascii?Q?K0PeF6Vkm9bRDimp5tIPOTvmJCw6h8j0p850Of41?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0a131e-fa95-46bb-1ef1-08dda9e2ce3e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 18:56:14.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKYK6NP4r//2GW8f1hvUiVuOaJ/GURnFLHIA+zVSmD7gGmlPtrRa4L3eM1tAnvgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF6E64BC2C

On Thu, Jun 12, 2025 at 11:53:24AM -0700, Nicolin Chen wrote:
> @@ -2022,7 +2023,19 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>         self->fd = open("/dev/iommu", O_RDWR);
>         ASSERT_NE(-1, self->fd);
> 
> -       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> +       if (variant->hugepages) {
> +               /*
> +                * Allocation must be aligned to the HUGEPAGE_SIZE, because the
> +                * following mmap() will automatically align the length to be a
> +                * multiple of the underlying huge page size. Failing to do the
> +                * same at this allocation will result in a memory overwrite by
> +                * the mmap().
> +                */
> +               size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> +       } else {
> +               size = variant->buffer_size;
> +       }
> +       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, size);
>         if (rc || !self->buffer) {
>                 SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
>                            variant->buffer_size, rc);
> 
> It can just upsize the allocation, i.e. the test case will only
> use the first 64M or 128MB out of the reserved 512MB huge page.

The MAP_HUGETLBFS is required that is the whole point of what it is
doing..

Jason

