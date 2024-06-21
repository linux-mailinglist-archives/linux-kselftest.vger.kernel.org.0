Return-Path: <linux-kselftest+bounces-12447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B0912528
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063A0B27CE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F2152177;
	Fri, 21 Jun 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqLnqKU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8A1514CB;
	Fri, 21 Jun 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972773; cv=fail; b=gcLlr6FwY42DwyGAf3a6fTdxOscMiPqZDTtJL1qfRkAL5C9JRqbSY+pVmeJn1mZMiJIQiMsTU0JJJ8b2ONvx+mC75qn1/BlayqGRoB1mlEA8z0jJJHaIIXZ9ViC4gV+kd6ux0OYaK+6F8V0fPZt3bcVMLtJnMg9iayeig8erExA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972773; c=relaxed/simple;
	bh=KQMIGxVItsValfegSe0p1CT6I/xQRYKnSkuYj5vDaD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YHO/t6KlVsBAAHX2OxJENOUXI2mla4waIPv7EY/uv615GAuXItrDv76BLSRV2hbP7wi3ZSX7OWScNjRfygAOcNw94llLP2VjWmBivP05aphoefiY6xCC5KZ530TeVdnzYnr2tpfyeUma0KvLDJuPDFmMiMBW8C/jM1GA3pkUgJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqLnqKU7; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ery3EWYwpJynJT/C+SOyy+V3siuzCpDp1qEPCKGzP5bFH1SkHQ5XZXu1Gu+9QX0qYIiLIQQ5oP+C1S/FnrmSP10nZ//52HNlyCOcN0qbKNpEVDK0bhCtuv7xL5IfxH/87uH2qhp3uHw6fb/jW+g5CHV4I/P3PX/jjm6um/fDHaJgP0gPiKayyEtd6KyF87vscaqp6HTAQXPuonV4LeTqgilfUWzw8CjwVYfa37jDHXeh3z2ZJit5yaRI4f67R6EWByf3uIrdTECEUgVXNXgOfDcoJJDyEMFCDs/8CjoPgs9VuIdPDApxFXxqqrRWRaoXYhgxNGinmjUJezqAlJgMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKe7DLCdRo5R62CcZrs3Vh7d72Hd8fX3RIfDXDG3X3A=;
 b=LLenRNJYwq3crxDhfcu5VXz4ye0jTZBNBzABPN28MtVy/PQB/+cw50CFDjZgTpo/NBqRVoqEO1sJbEKmR8JiaLWr1x/d6i0Tg3k0VeAsax3k2+FPxFn1lFMQF9TLoLObKVnbC84aH8GA/tbWpOxXplV8YP1XoL/M6RD0JAde7v7F4OTsd7k68qF6FyqIGdhIZ9TS5IdHlJ/cPnHPN0m8Zt0pCnojHXuq1umnOSUkL5XLGefNKFCh07qyqJ9INsaLZYgbVAP/8Dtg18hSHsOU6sEGcw7nJ3a8GyBDT1xRe2oItFZJuBXfM5jH7423MAHqJmAulKK6uIunjPwjrhKh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKe7DLCdRo5R62CcZrs3Vh7d72Hd8fX3RIfDXDG3X3A=;
 b=DqLnqKU7BkENzVwTYfC0cji8sCjYcz4IUASVKhm2Ql2PtLr03uz3ezXZ5V9x1v6snLEIddVR0EGNfrWd3oua4ynjo5beXOoTviDkSq/lPmwmcAzDo0eiiXfq8HNq6NpbKJdSX36SiBBtYVpwPXsxgbt6KWl6+Y5vdaPGsARkcmzEnkjltvcXPKWFq4yJuS6/QBJJ8D4C6FzEeBclvxaH2lwvX91MrRjfmxhVnIEYQVUjS9PBB28a5hVKX/HMWMM8bazTHbkYsu+QLXEFjbfiH72LhxcJ3bqoK4zd01KqmhpYyf9/kOzMccnTC9/M02uD6yHZdss3PHiEJUbsoP/fQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 12:26:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 12:26:07 +0000
Date: Fri, 21 Jun 2024 09:26:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Quentin Perret <qperret@google.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240621122605.GP2494510@nvidia.com>
References: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620231814.GO2494510@nvidia.com>
 <ZnUsmFFslBWZxGIq@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnUsmFFslBWZxGIq@google.com>
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 25543bc6-7377-4a16-08ed-08dc91ed531a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sTKm53hrkd1Q3yEBAHZWSGyV/HWerkDScBsPI5wM/ses4fUz9E4tls3IwV/b?=
 =?us-ascii?Q?KVjvsicQoKDjysbbdCqYB7iSjIzlsErwZR4lJE3kXVdW88Zmmk6mlmmdvJ4I?=
 =?us-ascii?Q?e70/OUH0QxnUw8NK9fUOTwYrYj36Mrq4UVuCQZ9TniJNPgtl3VAwXPusvys5?=
 =?us-ascii?Q?pj5IyITc4h1M+GTXKAV+XM9jiLBCwOHVNIT8G0LOXNJUK+XJaC09FQcQXjSb?=
 =?us-ascii?Q?S3NK4wooQFROpjDnGfRBmdtyERvE3KYSAGFlQQnpZG2GjBKeSmpV0mYFOXlh?=
 =?us-ascii?Q?PTOK6/8P9TH5FgGnH6PvI3DzEMSQrEbK5sj8mDGdka/3C6QWVR2aTBtIbEMF?=
 =?us-ascii?Q?PgqQqdt2Vf251TjBEyTeC0XTjJB3OIdM8YqX0f6K1TijItWFK9ijlZfn/Q47?=
 =?us-ascii?Q?xOaL/Yn/z3z6bURXhrz1dLYmSV11R4BlNeXY8pZ2a/oeq+bF/eM8DxpXlXDj?=
 =?us-ascii?Q?rSbei+RAj5N1IVl2fQu+iRCL8flH/LPsnX/B31rtcsRGb1QaeBKo7w41D/Jm?=
 =?us-ascii?Q?DfNJAzbL+zLZ0aI2glhmeotE5ZnPsQe12qEg15XqAFdzlHIy832hlxs5R9fo?=
 =?us-ascii?Q?5kUont7KER+89e8x4VioXPu5VY/iWVLFgxzCerqkaIl3H9K/n/+8QeVeK9cD?=
 =?us-ascii?Q?/tL/CwlOzsIlOfO1mq6+99iEZf8NzSoEbDaBRXGtJWY9djxIyZEOJtRkrws7?=
 =?us-ascii?Q?hqpuAZCegUKgq7KbPzrHpzhwQnIBLBXj3r1ZgDzOYyDlhH4ZV2RbN/eGZD5/?=
 =?us-ascii?Q?5go4NqqEcu+FMaLvWTidbivXgkfxnKPr6o+yI+vxe9D5zuE5GShOR+pFvnz+?=
 =?us-ascii?Q?kxtBUPLOYAy1DV1e4svvZyMzsx1lKQ1tosVTywk0HUGOh6DZ2fp+ysuEABDv?=
 =?us-ascii?Q?TLN4FU6J5netwztRTboeDUD1FDHmE1sWZk+yJ+tgk3dDjDPtSuGLjbfSfp6o?=
 =?us-ascii?Q?zfMq8N6O2pid1JpWamV9pnvjVTuZuAVC8Fn5PoyVYMaRQuOdD4DtNGJg6+X+?=
 =?us-ascii?Q?T+0VIMus26VIOaC1k5oNaUhkRIgnOgZelct211UKIQGIFrHB9V6h5CRmyYlX?=
 =?us-ascii?Q?2oBxax4Wxaw+fFKl8sZySRyEvJ79T9RxhMoD7oheMfXY1LUyrBhPPzNexKgS?=
 =?us-ascii?Q?Tpfb0V7lect5KW1SLaM8Y7Dq+Cpvr7DP70l7uQj+hgtloSiUov1qapT9sxL/?=
 =?us-ascii?Q?M++MQF1jrNhGi8h6gqfMw6gkMfYwJGvoAz9/1HcumPVb0xNvw+o6Izc2vn+R?=
 =?us-ascii?Q?WdAQ83eiGoO7yQcdurHlsFc7qk0kM6McuitJRKlUNO+9WTWJO/FKMC0Hd5Fl?=
 =?us-ascii?Q?xuApjK+KRWoNtCAS+FJhT5U5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SuCQYGLkiGtpXQ7eDZoovsV4vtDT+EKuVfwhweYMpntjYR3VNh0QECxyHDrW?=
 =?us-ascii?Q?YBMzdI7kXBW8Sh9/qxqnpBCfQEx6cY73ao56h53Bn+dFea0uKYYWSi1F4v4y?=
 =?us-ascii?Q?l3bvVRPCAkJ7PHVdcBGlZaspBER7zxaSvdyeRiCbL6ZX0T/5doGE3aGdVRgs?=
 =?us-ascii?Q?qo0pM0c36P26nvag55jOItgy/JLaTEZ5VwbK4Bocp5WGrUDQrKbu9iJs6BQq?=
 =?us-ascii?Q?xC8Jxdgchee3LWc+kx0SDG4gqMTZGePsW5ehuh16nGpT4Qio5sUf0/+rIy1G?=
 =?us-ascii?Q?XDKzbAw+SXge9mXmzSUTCEixOWKYU0tlDmZTFHdBw87FSgVCasYVfI2Xj4cd?=
 =?us-ascii?Q?V5nLMm9/DVj5pF+bZ6coopK7qg3subeE5YrNm4GaReteZC7k1v4uSxQ2Nztb?=
 =?us-ascii?Q?n9ycNxWJ+cYx5+AWNuEPshqt2JAaDd+R+nEXwjLIMHHloCcMZgEhOdvfMjWC?=
 =?us-ascii?Q?RDqflZe+WPEgWz/oyYHqJy1mzGfBhDaksE5REOaCXa6ez8rxOcPd4zTsI6Sl?=
 =?us-ascii?Q?Gk2qNz35ynktRHDkSFXnVRz5ZuQE7Cw8O7fXd7j2WraOqwqTTpuc3d0Y2OOy?=
 =?us-ascii?Q?M0vWCiCWycxpbteGaLQqJ1V04itf/C6dPYaRjGSPu7osEBx2G22p6wcpuI+G?=
 =?us-ascii?Q?gYH4POVE7WlnLZaLj365IfOQvJfgUQW22n7MOB+DeygsNBHar4a0lzF2i3Lg?=
 =?us-ascii?Q?S3W1eFobrvHRtQU86kGGoLylgHHRdZM/i2F88g79ojee6zLo4MHimfrBZMZK?=
 =?us-ascii?Q?AF8CtJsLrypcSNZ6udvs+ZYuH6aCUBNJu1FGEdOesQOEO/AZ4NT00/kNu67T?=
 =?us-ascii?Q?1ul8UMjnNgfVJocSJOoVTm7QNIUqzZTyF2hYT0rWfJ+1KxcVAxRIGCSuQNG+?=
 =?us-ascii?Q?j6N3rmJorrjrN6dTn+E3WXyx1UFshPxWBmquPbkCALisowUwyzFAYHXmWVNV?=
 =?us-ascii?Q?6rexhFIDcaqaHQf2ks/87itKotQVdRu/rVvkA5+tmlGQ6NlQZLYjfkUXXbk/?=
 =?us-ascii?Q?uy8VBt8rJz0uyviHp5wvsyQ8W4Ccp/vEAw7Wq5MKaj5qe9ReE2krPfoPrrq8?=
 =?us-ascii?Q?GPEv3c6HulEhXkma+71ETbDW0RivBAykNN9rjH19tURxnck4fUVjJbUMo6pP?=
 =?us-ascii?Q?t6fm6rDQn4Ve9l0o0cO8WlV4soFz//L9H0ZkO64GOTdbOZn6cGo+zmmxsCqn?=
 =?us-ascii?Q?t3SVAHGlpAR6HbSOJqoAU1XtXfm9nPwPJNF1EfxI/JBZkeYb1Waq16+8973k?=
 =?us-ascii?Q?oKeOXEBG1PWHgAzsXtbUQlFBkjrXcJiYqVHCm8ufQTkPNhVZyj/w08a+2/KV?=
 =?us-ascii?Q?tUqflAln785GoSvJWxDe7fWbtsKrlOORE2o8FlygokUwEHJswlT+bTA6Vecv?=
 =?us-ascii?Q?gusEZKz8R5q2UsQo4iAJ0yYws2zQQ8Tq65WqnB4pglinHh7Sj7Fw6eaSZQqI?=
 =?us-ascii?Q?0vpY2jP7/csTTpHk3ZjaG5PLKPnfqnsxn1z4R74EOxRFSEATj+94LMGPLhdE?=
 =?us-ascii?Q?xV7oACZiGMJw4095o7LhkJDMuwLx/vBoue60784X04GdEP2l+0nkwECFiVAC?=
 =?us-ascii?Q?HHUsf7Fpzdax8i/EXo6YrqN6K/vvSPt3JFGeB2ef?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25543bc6-7377-4a16-08ed-08dc91ed531a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:26:07.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxYNWQjYGkQKM0y0fwpM+qQHVJ2yH0Riz8yrUP0dfn+7Md7kffvS0RTrKasGzpIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

On Fri, Jun 21, 2024 at 07:32:40AM +0000, Quentin Perret wrote:
> > No, I'm interested in what pKVM is doing that needs this to be so much
> > different than the CC case..
> 
> The underlying technology for implementing CC is obviously very
> different (MMU-based for pKVM, encryption-based for the others + some
> extra bits but let's keep it simple). In-place conversion is inherently
> painful with encryption-based schemes, so it's not a surprise the
> approach taken in these cases is built around destructive conversions as
> a core construct.

I'm not sure I fully agree with this. CC can do non-destructive too
(though the proprietary secure worlds may choose not to implement
it). Even implementations like ARM's CC are much closer to how pKVM
works without encryption and just page table updates.

The only question that matters at all is how fast is the
private->shared conversion. Is it fast enough that it can be used on
the IO path instead of swiotlb?

TBH I'm willing to believe number's showing that pKVM is fast enough,
but would like to see them before we consider major changes to the
kernel :)

> I'm not at all against starting with something simple and bouncing via
> swiotlb, that is totally fine. What is _not_ fine however would be to
> bake into the userspace API that conversions are not in-place and
> destructive (which in my mind equates to 'you can't mmap guest_memfd
> pages'). But I think that isn't really a point of disagreement these
> days, so hopefully we're aligned.

IMHO CC and pKVM should align here and provide a way for optional
non-destructive private->shared conversion.

> It's really only accesses via e.g. the linear map that are problematic,
> hence the exclusive GUP approach proposed in the series that tries to
> avoid that by construction. 

I think as others have said, this is just too weird. Memory that is
inaccessible and always faults the kernel doesn't make any sense. It
shouldn't be mapped into VMAs.

If you really, really, want to do this then use your own FD and a PFN
map. Copy to user will still work fine and you don't need to disrupt
the mm.

Jason

