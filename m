Return-Path: <linux-kselftest+bounces-43892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53435C0244F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB63A5D45
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465662566FC;
	Thu, 23 Oct 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLW8iW3u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269622257E;
	Thu, 23 Oct 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235074; cv=fail; b=t3nAVUj9Z1hsMC1hV1rnMVeR0/p936O0xnqosLF3zSBHbk35xTMebAmtyY9edm74NWawa3MDjS6NUMyNG09qlkw7QE2m4oIOAp4rE6rPDVw1RD+JW8yyGN7GOoEG4xAZcBvU+weyEzsJV2jY5vJgUYJvjsIRt+cHwaRJaxgFcF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235074; c=relaxed/simple;
	bh=8V3oW+3U4An5HqpXCovfriXP4HwwVeiyY/TcTGbrCsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2g1zT1zCZB7zdKn3jLNRjBg+CD3FpgeVA3tDhtvr1P1aWVtRglUdTZcxv9dR3ot2eTG8iBeC0pMsEFkCoteR2kwEg2HC83d1YitLxRKMPn4f6FJWpyuTnkuIxIUQTPwU6dG05mXG3XJq+vF3HPG8XuatwZvIfwKy3MinHknono=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lLW8iW3u; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsigzDFuCLfPhPeyaRoz7q556Pu4xmOBW7JFYmwufvkZtL/V8ga8wreTTju1yIOvc+xPmodQZ0QburpYACx0xKQUQaMg2+kzUnpLSRh+yotepSZhFnBIKbzrm6eg8hrJ7hjaNlhlVNoH6OOxj03DqSrsLhkLdnyO55XqOrUrPI57laZHD11O1w+0igI3rB+h77hxTSEJ6G8ONAPg6Go4Gq9uURYpM2Jr1/nGfVl4BqFI1CwPIivJMn7QvJoL4B5AAXdIDhCALYF0m6+8vH7qU0gJcQfGefJG6P6I/qIhKf8aL5bf4vxKAk4DEF3U4c/gd4WMJgWidMf7L4VjXNPq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB2doLAlGyazWTDY9YkQKe6G7e/6FO9vKZi9UL5vEIc=;
 b=BbTbNEcvdQvAk/NTYhu337+Ln2JxJ4/X9E14HMwCW1mZUM4Qq9FXT7tuxTvUgJf+B3SeRMh8leFNsxHxSeImZTz+LcbCldA4IOSWb834MVu75Yy8tIadjSftpMjRDVlOc0mQBhO5fHgy9U72YSB+dPTFvoZQ+YIxJ6DUzRYH8ft1ZKVa0rqPYa+RqombWRgXqQh096yDqzw+7aJBAWYxf3eYa5H2WcuwKHUWyh53LUTJqo8r0MYkmDbn2BxXe1GMb8Xmxno0h4Tu9z/V+i86VBA2OJfbORaQsxVfxYzeTr47KQEnYq6oCq1Y9KGAlaBfhGCylNjLVhQNS2YI6ZoB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB2doLAlGyazWTDY9YkQKe6G7e/6FO9vKZi9UL5vEIc=;
 b=lLW8iW3uCFd8zWtea7YDOP9GFAgEPQPOJjSGRlZPObF32YRw7H/7kmYaS4u42lZhF3Nmb5y/6rC+ZYlQWZYQVvPfxO9vcM+6xrOM2Y2A0OziJjexmiGcmI72dwLGyu9+80cwn9fG7LYFK2dKmdfJV7YyoDJccytAjzuKclcoELMst3GWjychSt8vMUWXHhLmv64OCSu635yMzFkW8p01C9pXjgBf3bgSyydW0zggn8XJDBuCbpDRvQiBiRkB6Raw9SggnmISDEGQ+JZaLmnkicXL/z6q88DIWaDOcMbXYKbnP7AkGK6EAiGVAgNiNGwDSFyUyekVvOVXC93D2LkJQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:57:49 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:57:49 +0000
Date: Thu, 23 Oct 2025 12:57:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
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
Message-ID: <20251023155746.GL262900@nvidia.com>
References: <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025102321-struggle-fraying-52ff@gregkh>
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c19493-39da-4e5e-962c-08de124cea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7hzvSYmpasnSB2BGZ+DTRmVnfmAV0tqD9d/k09XDAezGMt1gAQIvlrDYxcUE?=
 =?us-ascii?Q?6AHSF5SFm32Drk+hXYWxHhlBx6EvEdrfBXUB9SIATWXwU0RGsh5IqHZC9AgN?=
 =?us-ascii?Q?2OkmyOFg8rW+VFUSYfDq50mqCmsmxvn0Dkb7BQCzr0l4u172iCdiqZYuE0vm?=
 =?us-ascii?Q?hiYjDL9EDm6+KqChiHPDHThI4WWJ/6fHZMurdE08JlNmvvSJTV1TPos9Hs5P?=
 =?us-ascii?Q?8NHUB/imLETMgtwbViihUHvCT/3xX2hRkXMMYrHL1KiKbnri/sZzJgSmqhF2?=
 =?us-ascii?Q?9XNS3ChVOORCvENir7fTIyGGThFhGOsGlZySfjpCqbtmgfHdiFKTIN2ItfsA?=
 =?us-ascii?Q?NnBDf24rfs1urLkMQKrWGYPdnZz4WG6W6DY6vGcl3QwzJVvtvfEIyKOLwCk1?=
 =?us-ascii?Q?PPsCrdjpQ70NNRLAZrU02ZJPxpJ7v0NLVpITJN2m663/bwKeqOaFrSalfLYu?=
 =?us-ascii?Q?YH95d4FKcAL1pA6ExvvD4gTgde8e/jF05AZjhPcXq+LBKnq3ygungLwQ9Tpm?=
 =?us-ascii?Q?8qLjEqUZBLj8xgQ83pk8Qm1Px4Aab4h66AVhvf/FjUTHprZZAJbM43We9w7f?=
 =?us-ascii?Q?e+xewEuix1OjFP4MNb1wKsy2eyIAIeEasjmBzIUj/WN9a+nHaoaRyYQVOJNK?=
 =?us-ascii?Q?fBwRuI7HerRDqJAVj53d0ygE8HC0WBfS/FnFL2shyiOVOUJ8KNlqNCuIBuqj?=
 =?us-ascii?Q?P7F/FLkWif096GLaxRu/Pz0zG6PgGYr8m3Zvg+caaAA+6ScTACswDbZpCq8h?=
 =?us-ascii?Q?csx4B+Jr4VfWXCq70V9nQD3IPtyKTR87LjlNyMl27p7dTiOzLEe34uIga1J9?=
 =?us-ascii?Q?HA5Xtee5rmSg/FMUHeFw3/8P6VDQ8tO7RT9bU4mMXm7oya/vWAIVChauN6vO?=
 =?us-ascii?Q?R2fEWm6UKrZzvmv7YLcC7rH1VWpUSyGbxB7/v2HgTAhUvKFcgZIt/BzHZOna?=
 =?us-ascii?Q?DZYriS/73r/42beOMXC0KGwA+uQkPA9g8xMfRypWfDETRoFFb/NGiGB/yrVR?=
 =?us-ascii?Q?NsFUI+NOtYHkD2vdJx7sxB18+/FoAQ55lcWYYlC81EBiZsxCPAFsZS4XTPKO?=
 =?us-ascii?Q?36poRucwC5mq8Z9my9hMJuX3KvKKormfGu+fdsZxQq2TvyqH0Oa2q2VUembg?=
 =?us-ascii?Q?+yd/MMIxMZZizSFPzUYBR0oA4jO1/N9lljbaDxEqnz9oil1VMDVc/5pbULzt?=
 =?us-ascii?Q?zB2AVZLcjuReGwEr+nPyPZDkCrvci1F4Z7TDJjwsAC9Pss6dEK3d5PyEY/DU?=
 =?us-ascii?Q?2VFp+t8Q0RBgY/VLTRLoG9G4iRMwogiFvd0ImnSMIBPctzo0aDAmBttYpYzB?=
 =?us-ascii?Q?tthnTWVe9/V5rfOJQ2n9K0EVfAegta8CxCS3SH2b9EuHaXmUg4mTmbUOmmuN?=
 =?us-ascii?Q?wE2D62/YxYaWpx4hfIf+rUS9SQrafvoCCapHbd4sJ0q7nXTsF0O4Jg+p3bUs?=
 =?us-ascii?Q?MdVuF2tYcnL6J6UsQfE6+dGqAmJao10Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQYL9ey0roJpcTFZOYeJ/XxuhVwsKPxWdguH6TsLsLSEDAeCDdZfFfc2cATN?=
 =?us-ascii?Q?/YQpQk4K7mk882HQcnmNKyv1Op6W/7mnfBRW7Rx9YTvjjY2oR4G6B2bMEfYu?=
 =?us-ascii?Q?JNmtghW8y50pGMMdG5TT+tBMBObIjq4A5pvBovu7W9r7WqC8DSePvKDGwEoM?=
 =?us-ascii?Q?kO0SOAYdegqcIHi6ayHn9pW/FpcxR/kL/ZbroZxVfZWCu4M+PSTNfslZl+H4?=
 =?us-ascii?Q?KC/TP/XEuBEid95SjbDM8gY6Xqo8n3V1ohbJd6ddH0QMy3kC3C3VGDF3LSlf?=
 =?us-ascii?Q?59Fg7AdgKKvACzKxSTdYcu5P6QdYx3gmEMMFk07kna5xnSJhHZh5Jmrm0dyL?=
 =?us-ascii?Q?KIYcLV9e3TAQM3p1LZABwemddUFJANgghrWzlF8aR6CcC2MSAeYaM+JTvfz5?=
 =?us-ascii?Q?Ee7CjPvguGTv7BJMnr8qON8Yi1km0VaH1N3GQDxaN8Ezep1q02nelfLKGq/+?=
 =?us-ascii?Q?x80uund6oNmPNk4ULDlSTaMkmaH5bG1O2oiEUxtHXE9+qyRO8Zm8lKCSJSVA?=
 =?us-ascii?Q?lWy/KeUFfGTudA5JoUVHhQv9qnVV+9pDgecVbnHAbILw/UIAgjuNDcB96gPa?=
 =?us-ascii?Q?XN49bnxkUZ9FULpTaCMezCWqpKz7eyYgzuhwBoHZWwdEXK+wFItnQH7SxHSl?=
 =?us-ascii?Q?5WkCalEsXgcPBwE6YA7gpkLqm+dGo3mo6AcF4g+NT8MmcQWInrwALSGK9KIR?=
 =?us-ascii?Q?9lTlfvjwgHv27LHPG7VwpIQE9DiSmKH+Egplj+PjhwSAMI09a2g8p0oAWUmw?=
 =?us-ascii?Q?YaTiVr/iDeJH/uSH39mZtXfC2Ruq/o8LDo8gAMqY00b/6EnBRABM5HdXLUzf?=
 =?us-ascii?Q?2I/1KamISutQida9t/f7EeHwzjcDPXJLQmuYSjA7fD1qwvkCR7jqurTX4Yrl?=
 =?us-ascii?Q?dbCOFDEBuNu9zs9PuNnc3ipF0i8VerR+M52SEMxz5aMSiF4cYbfO8a+8rg9j?=
 =?us-ascii?Q?j3V4V954nZaHEKcXULplYKZl4INE9EtGT/4Q1enkZQbypGjgVnAKbyfxpquH?=
 =?us-ascii?Q?o5J5ijURgKWDL3RinT96SlZVcHGPEUhfaS8jCi1DUH0FUFE7EIl5LxNgTknO?=
 =?us-ascii?Q?u/dCLzoSAsLXrkWV7XgHO4VTiqN2ARkaCq/p1DVXmaoB6YVqBVdrhCd5IYVr?=
 =?us-ascii?Q?a9VQdT2JlHvnTqPCPF+lFgPZsCq3GvvJ/41m4HQzGCG2rokUc5oidE+Ai3ol?=
 =?us-ascii?Q?lYj/2WH8V8Zx+VePENokSNWMEf7oqT/LUUQ3GrNL8bsOX3STBUyjNz1PBkWm?=
 =?us-ascii?Q?Pj8vwA2lVnkq5Q0Q5NbxkQohoiq+Z2214j6DK6nDK+vM0FYJIZjHKz7D9qDU?=
 =?us-ascii?Q?zFcztSE3lScrmJHdd7SYY/wBZWnF9CQ0iazg0dOSYPu3WCfroOwlNhYreDY3?=
 =?us-ascii?Q?Qj3VYxDDBozJQVK7nDu/GcqlP/cVXI/5Z+uSgDQcFGj9FRo8fcGXgWbJ0bPS?=
 =?us-ascii?Q?pnVr6Gb5+1hx0J67+H3UguKQPamqANriOMt0PmjkgPxxZuoH/SEOmPnaaRer?=
 =?us-ascii?Q?oJkqQsJplfQAhln1wRKiSIx6MuzezlXuPUvw3bXtP8F2ISOdqKRTP835KJu+?=
 =?us-ascii?Q?s5TC4wBGJPC0JPcXmwAOXiII0QnDC2bDohXFAmu8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c19493-39da-4e5e-962c-08de124cea0d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:57:48.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrbnjIoTKaHY/8/qk8+T8BjGdU+YRfk5y5auwBo0qBL25DKCGKVVa1FYFMFGpcDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730

On Thu, Oct 23, 2025 at 05:04:57PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 23, 2025 at 11:51:31AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 23, 2025 at 10:22:01PM +0800, Tzung-Bi Shih wrote:
> > 
> > > I was misunderstanding about the "sync" we were discussing for
> > > misc_deregister_sync().  The "sync", is analogous to synchronize_srcu()
> > > of revocable_provider_revoke() in the revocable version [1], doesn't wait
> > > for closing all opened files.
> > 
> > Yes, and my remark is we don't need to obfuscate simple locks in core
> > kernel code.
> 
> {sigh}
> 
> Yes, that's not the goal here at all.

It is what is being proposed by this series.

> I've refrained from jumping in as I think we are thinking of different
> stuff here, probably talking past each other in places.
> 
> The original goal of having "revocable" is still needed, despite you
> feeling that cdev can live without it (I strongly disagree with that,
> and the v4l, gpio, i2c, and other subsystem developers have feelings
> along those lines as backed up by the many talks over the years about
> this.)

Yes, I undertand that, but this example is just not a good
justification or vehicle for it.

cdev wants a sync unregister, this is a common pattern open coded in
many subsystems. It solves problems for alot of places, including the
bug identified in this series.

Dan and Laurent have brought this up in the past, it is something that
can be fixed and Tzung-Bi's fops shimming approach is a good idea.

Of course it is not *every* problem and there may still be a role for
revokable.

This series is fixing a simple driver bug that is due to not having a
misc_unregister_sync(). So let's fix that in the natural way and find
some other, hopefully better, reason to introduce revocable.

> The use of it in the Rust code already is kind of proof of this, it
> enables driver authors to not have to worry about a ton of real-world
> issues they would have to otherwise.  Which is why I suggested copying
> that pattern into C to help us out here.

IMHO the rust code does it principally because the sync unregister
life cycle model does not fit naturally into rust.

Jason

