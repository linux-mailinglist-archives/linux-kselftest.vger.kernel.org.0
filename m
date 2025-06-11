Return-Path: <linux-kselftest+bounces-34777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE3AD6404
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 01:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CF217E672
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA024DCFA;
	Wed, 11 Jun 2025 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBn9pV+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179E20EB;
	Wed, 11 Jun 2025 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685885; cv=fail; b=A1pGVqaz37TKx3a0Jbky03bXEg5I8ii+DPLLilOyJKIK3L7GgOI5FW25Je2T9eQW6ifl0Kd138KhCKzdZ2LVPXcV4oofEYJ4aEOHU83Cythf91kqV3R5b0945slBzQrKBJR5wIJTpOgjKs5OKpEXsQHLdUzphmzj1yI56Wu2cEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685885; c=relaxed/simple;
	bh=yK55R/JoO9v6zZrQ2Cj70kN9QfLIoGlayO0FAiFx3fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ts57UjgatdE+cb6L2TlSjsmKQEB1bWRuLdMIiFP/lFmBkndBbolvE1LCKMO8efHJeJ7uPP3s3y4rREpbPnBParihRvI+Kcy5s3Rc2vA60jC4j6D73pDdcK+fEeFCnE/uvVPoLMe0Vj5rKRKXYvUKl3wg9jcK2wO1/bp0v0w2Q1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBn9pV+Y; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJyfnyVNV1MbXmfFestTgjlzn5x9G66bZ8Vmg1/wYsyDRtvKRcnTyZT4NYyxRe03MPvADO3k1L4/z1+0XgPUVDT8bIr0jT+qqY0lUFlKLbYLnR05sq1003C7t49GR+o/B69Sh05sCGxie8+PQyEWEenDmHqj9/EIoTIiQrBHdKOU3oJqJgIS86QPumXyQylo3vUycN1+b03Xp1nGuWkw4K0WAHn7reNtg1/pmWH0AHS4xRSha15QNq4TY4g1F2d2hJ014vxF1fyVzckeA60to9SnAJtVPzbkW3F49WktKSix8XAIp8l6h56w5zQznsjccNquThTN6ZIHvpnWPR7g/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L80+9jLGigqnZ5R9adAKfkGWBNVDGLyTD+gVYgaK4aA=;
 b=TMUQbr0r968A9M/y2et0WsBM5JhRi3B3x9LX4x77iCVXT+9IyShXuOFtS5lHeI5WUdzCoS+2KqMCQSymXm0rAsk6GScNmboEdKFNwl893M46/U09ib5VCpTEaAvRqy7pxpP9xzm09kjqoZaPTrIo5l291GaFZHjSkkbzmBJCFjYLmoxXXAW0gDC0wDAxoZN+GHDXZntnYBlMSgCFrOkFG4Kzzaoj6fvtUJBUNs/p5e7I1ZZcQ31lgSzcTsxUIuYtFEVcVmDJU77caEmb+RKp3IGAQkS7wqnu9LfeOTMU3Jb10c7DB32Yik05AMfHjofxpRPzCOAN+w/WOor0i89Juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L80+9jLGigqnZ5R9adAKfkGWBNVDGLyTD+gVYgaK4aA=;
 b=nBn9pV+Y4cdY98OOxvvbgv0rSlw176r5yv9sPnCy7lo14JwV+5Xyst+ANQobq0iag/PiZ8MR/MkMF3rqkQ1ymlRHgzLFa3qbTeogMvchFNxs8BpOHt0W8i1jZ1QIp9OBXSFU//1AsjX+3vBnevNMMrOTFzbL2ItELQGNou3G7h3Wp6ftpnOt3QmUeOnpAqrHSNnLemHzx3VSf/OLWCWvNU5qP7nQSck+p54+vMS2bSaGm8NEhlU2SrMeWYhogQ8JFim+/NzY+UmnTwdHiXra+/Phu5rDrGMUeLfy0RsiYgxOiYB38egTNGXc9zAI0/y7sZkfhORywMMegQ+WW9OMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 11 Jun
 2025 23:51:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 23:51:19 +0000
Date: Wed, 11 Jun 2025 20:51:17 -0300
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
Message-ID: <20250611235117.GR543171@nvidia.com>
References: <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEoUhPYIAizTLADq@nvidia.com>
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1a5cba-641e-4d72-c280-08dda942dc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtxc0Oo0sRHNuR+zCIC+y2hfr6aCCTAx8tu2vVJBYws//TX/A517wozmWVkN?=
 =?us-ascii?Q?3ziXT//neClS5Rr+Hap08OaBDABXYlfV9rVjT8Zl146ah4aeKt/iorAxoBve?=
 =?us-ascii?Q?dtxtjUpSgIUmParBMb24pPqKkanXgpYU6CVkEIlBdD4hrsnX02bBVpMnZXp6?=
 =?us-ascii?Q?BEvl62m0AXof3FuHB/o5KeCF8zzza1TJMYXvKfuKX+kipAPqk0Ws1dET2DKF?=
 =?us-ascii?Q?qHpcqLxi90Pq8Yns9/bP1dJdRmhZViztLvoGpUkkgoCf9rvYF18lihbONRmz?=
 =?us-ascii?Q?zqpELrFAQ2CpylTuz3HMogk4l5s6az7ZHdZsKenQSmmGUW/HQDk4Q3IWLYns?=
 =?us-ascii?Q?r+r88aZiyrzB358QetDnLW7wmz5lfFKq7yRQNAxprwZ46V0MoXdH9G1BnwT4?=
 =?us-ascii?Q?D5Jl4b37R/jIag7S3Z5lWKy12bCUrqU+vi19Fi1ihw6+4ooRxwbomimCg0MU?=
 =?us-ascii?Q?/LkkVfgI8o6VYpdKsN5/F2+FFeJPrEQYdiwBSh6GkYWxQV9Vp0ZveX/1maYr?=
 =?us-ascii?Q?Eypvn3+nREpaGXLPpnN35IPRr84zvE1dH5tzZuj+5+77rSbCH+74qT8KLBEe?=
 =?us-ascii?Q?bEbJZ09saWQwQDXU+OLxX5NtS7xWB0HONMJdLfYS9BOJ89+v9WI0kYtM10cU?=
 =?us-ascii?Q?rMzlFQp1nz8OZKPch0luiv5rRz6rz8CRuGexkts3V1yC31AAtPY7zbIC0TiF?=
 =?us-ascii?Q?9ilCLPIbDvMTlESQRtZof2YWmUVeZSTBN+5Kr77K+mR/Jbxk2kFwIRFBDSBZ?=
 =?us-ascii?Q?czhOhOpTVnS0NopjFlOynx1T6y9lws/qwUPvis9PBJlG87136IMELwTC02N2?=
 =?us-ascii?Q?jA4fRCHXU7LhO8HO6GdMtFfbOqO7m3iTI9pftTpl6rhVEjzyEHOiPwxc/RM8?=
 =?us-ascii?Q?nsxGWUQ/Rz8y30fOhmDNGa7Lnvs5anqzGKf1r4SsbmaSnvyQ1xauI9E+GDAU?=
 =?us-ascii?Q?OjZmXIJT+uXfkYa5LgtEjDkA5z1gqkAcNFDoWfYFpEBkd0v8GFVKpE1JufZB?=
 =?us-ascii?Q?gmu15bZJ1qes8mwTQO7GUBxLKNLzlb3CpDYKlyRCLiXg5bNGP9PQhIfO6X43?=
 =?us-ascii?Q?IX9dcmk9Kwo3MRAs1nWrvnRFaqCgCYJlx4Satj6O53JVGmcn1vKKSB7SGa/o?=
 =?us-ascii?Q?RVKpzZOJ/5HV1ModW8vP0TWhhS10mC5VuiKi8Kq7ZlcDmtLhNXvxIghLUgTZ?=
 =?us-ascii?Q?QexCtcYeczO3576e9536Uh75moud53UwsIJ4EXZuquNvKoQCtPzTIitYCO6G?=
 =?us-ascii?Q?hzy+T/BHEbGj65n8kDB0Wh0BWc+HHVUlIpGhrBajALs5yh1VDwVw4lz3UsII?=
 =?us-ascii?Q?a6iKIpS8ELNfl4WumEAtQZ3NliFtaFalPB7WIqV+N8gyYAgo1EY7T8+SBdUP?=
 =?us-ascii?Q?fSkUxooA+P4yOvU/NvO2C/MPNjpAArTMt0JH2shs47mld972M7iSfoM5OC/n?=
 =?us-ascii?Q?4MaHwfw4I78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Onoij8w6skCca5S74XUFO7UV4q2PVoPOaNZ8rHVKTr1E+82Hmd683lkX/q4E?=
 =?us-ascii?Q?biV1f3cNwES54JDd7OV2QER952VjZcNpSVj2b7pxaBiq23BrECY9gihODbZH?=
 =?us-ascii?Q?vQ1BXJv069J2lEqXPZ3typHNUk/1Ii8P4nMq0pq9AwIxSev6tQtlAPJ3UUV+?=
 =?us-ascii?Q?ygicDbXZ3cWHYKgTZAxIbXub8nT22cTbIVC6s2JZXm6gvXBJSqBqD2OdM4I2?=
 =?us-ascii?Q?mspzwjNOWIu3No17DBHsjFgDPM/4AlM2rQ0s3u/kBgJC76Z/pTx7UbseQmZY?=
 =?us-ascii?Q?BbCeC2mEmmkVM1AzbX4/k6OJvHeAkPh6uQOnlnLxygd5rvMpUpNStaIswsAH?=
 =?us-ascii?Q?2A4VnJ8g9ZDEJp/sCk7jC+g/5M2355L5lQOgEq8XW331+7kSbn6gLsj+604A?=
 =?us-ascii?Q?XzyTqqSDQYDhB06ZKHDFJ16GbZW0lrGG7sbc8tR2uWdBz7LAe16KduTGOu47?=
 =?us-ascii?Q?vPfPi5m3rK+eFOGm2g2CMulpvyjFmTypUlrE7A4d6k6ww87nZrmYfAMF5tkp?=
 =?us-ascii?Q?769bj/Jlj3z6TcB/K2ny5N5BwYglXe7OUpYeRKgECtWz0GG89yhUyOPvlEY/?=
 =?us-ascii?Q?ODfyYyy49G/8YivnIClydgcfXfiucKUsbSOts5+VJY8xKvDhPxS3HXF3KnAy?=
 =?us-ascii?Q?Kd0KG8q4g2riESZrLIDtQ/dCk8jABL5ziQ+7r9gu0pUdl0CqEWIldEIyOk7S?=
 =?us-ascii?Q?gUB4bepWfAnadyQqJqo+ffrWa5Kluuu7uy4UkSEf4RLM4/5aom2b42KZGlDw?=
 =?us-ascii?Q?/TWp1esr0JdHjh1UO+2k8qPI1ocvcr48pHc+oHHxwi2nvXVhwhsYGHpLKB84?=
 =?us-ascii?Q?Ql5/UgFoB2w72stTuzbiwsiGLnx23mDMTIjchiZzvMBNdjFDpJaiBAylzrTd?=
 =?us-ascii?Q?zBGo+ZoRIhKcLFtedea09OVYKSyzzrg4wZ4KELvNEPgdjMuP2LhqnEWZXhPf?=
 =?us-ascii?Q?DUEMCY6rlZlh2SnQMQo+6n1jHwhl1PNhHgxK3Id3RnA8rBy+S8KazlHEm9NV?=
 =?us-ascii?Q?JR9cZmGsyofDXYi6DZy7Agc+/5dJ/nHih1T67Zit4BWyppjsz+mv+fF59LgX?=
 =?us-ascii?Q?W1QCm8pkrDPO7XqQulk526ZK2sFS1+iInjEW3KTaQU0RTV3ts/1jH2XH9xO+?=
 =?us-ascii?Q?EKOsiZLawDF9ru3NzmI0HLAfy0Y0vLhYWEsxh36ZhxTI4duQNAcf4yAcoJcM?=
 =?us-ascii?Q?/UQxrHiah/2AlejR3SGWROgwOtbCzzB3BthzQrL+Gq0P1rXOv/OAdAk4jh8y?=
 =?us-ascii?Q?RRMK8Nk7xKLURr/SE5sN2VytQPVzn3JbdlnMRdDI53YYUXy7vfzDaZga3VES?=
 =?us-ascii?Q?c8FeTUxCiips2OhX7vodHwyHxH8LNopiyuZzqpmpNcYxp34Bp1q94KMWSXmp?=
 =?us-ascii?Q?fZORFd5RK3ItElgKuYce7xXGqV9wcn0aBvO4gS/Av4imdebWcTSxA+XCHyyN?=
 =?us-ascii?Q?zoRjGtziJYvReqbScwjLhABL4005/56SAUiV83TR2JyP9M8BZ/fIrcqL40Ns?=
 =?us-ascii?Q?RVjYDrd/U9H0hj7mCH5PES3cnzeSkHDmdbLy9WXYsE3DdwGAtKjDpgN6GtHj?=
 =?us-ascii?Q?uzv72+GGI6pthKqZjJ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a5cba-641e-4d72-c280-08dda942dc91
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 23:51:19.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcEFbcrOlg9Fsx2Ec8Jy29WiiSu4bv+hnjHyj4O1s+hvySMZ2+THC/UUBQlkQsVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951

On Wed, Jun 11, 2025 at 04:43:00PM -0700, Nicolin Chen wrote:
> So, the test case sets an alignment with HUGEPAGE_SIZE=512MB while
> allocating buffer_size=64MB:
> 	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> 	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> this gives the self->buffer a location that is 512MB aligned, but
> only mmap part of one 512MB huge page.
> 
> On the other hand, _metadata->no_teardown was mmap() outside the
> range of the [self->buffer, self->buffer + 64MB), but within the
> range of [self->buffer, self->buffer + 512MB).
> 
> E.g.
>    _metadata->no_teardown = 0xfffbfc610000 // inside range2 below
>    buffer=[0xfffbe0000000, fffbe4000000) // range1
>    buffer=[0xfffbe0000000, fffc00000000) // range2
> 
> Then ,the "vrc = mmap(..." overwrites the _metadata->no_teardown
> location to NULL..
> 
> The following change can fix, though it feels odd that the buffer
> has to be preserved with the entire huge page:
> ---------------------------------------------------------------
> @@ -2024,3 +2027,4 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> 
> -       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> +       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE,
> +                           __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE));
>         if (rc || !self->buffer) {
> ---------------------------------------------------------------
> 
> Any thought?

This seems like something, variant->buffer_size should not
be less than HUGEPAGE_SIZE I guess that is possible on 64K ARM64

But I still don't quite get it..

        rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);

Should allocate buffer_size

        mmap_flags = MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED;
                mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
        vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
                   mmap_flags, -1, 0);

Should fail if buffer_size is not a multiple of HUGEPAGE_SIZE? 

It certainly shouldn't mmap past the provided buffer_size!!!

Are you seeing the above mmap succeed and also map beyond buffer -> buffer + buffer_size?

I think that would be a kernel bug in MAP_HUGETLB!

Jason

