Return-Path: <linux-kselftest+bounces-37588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82424B0AAD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85BC5A3F8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8220296E;
	Fri, 18 Jul 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cncqyb+L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186821DF970;
	Fri, 18 Jul 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868608; cv=fail; b=fp3Zj2kIC9fUMvoE8kzo96Zd3B10WFlXVmTJXtCv8/txTc6z6gvdSjsHs/4/SN4Af8feHxVSDo9iTT40XAS2FpMu6lmm0UL/q4HJpHfJod2Y69Wc90eZgqxdVtZ8t6FNHqJXwamDt4tjaB3uBrLmEl8Ai9ZpD7cX3zi/Lq2omXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868608; c=relaxed/simple;
	bh=Z0LymdsvqGv4ayc+7pULqJzEzmb+NZGXLVvcbufesiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugBD4Z4alKwNPX/inQc/bPAZZeGjbcPKnx/bxJN2tGcvXmHPes7hJd0UlRQp7vbNIGBdCNM8HK9mxPfbkpY8ABoeMoXHEcAKe1e0ayLKXYbjQx8eR0S5GPj7KhonkHeN7u2VXFdkXuTRpBZDuG7cDJ6/bBHlxvh8dWw9RxqT9u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cncqyb+L; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs1gQygdbPTOvkP8PL6Letv+MqIgFcU39KvL/b7qJFlppO2fmNiJO1jvdZu1KCWMZ4mEAf1cvWbcdgxMEqpkg1Oglhqg5HcU8gOr4CCg81QmIAJNn+pHtYP7JhAjZNxysn5kjQ3EQ+YxI8ZnX19lIXPcRr4AGkgSpGF99+r8DllnNICezIiJ67wkcgRWswPaaTtl3T/LsbFBblsbN43tpWQe8i3SEuIkLU3Se0P/ajsv+nmcW0QTsiGGKZ3NhEPPOOECDHzpwBtAaBITK5xCjfvgZVvsj38Thjr9BuoHRJvCvr0hdZZzPE1z2t8t2cjACHYzvecjSc889XNoZ/ZeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0LymdsvqGv4ayc+7pULqJzEzmb+NZGXLVvcbufesiw=;
 b=Qai7I9rubKLyNWF5ZSjFPhz5MksuYgN/kY4VSDnbG6pNuErbKqk+cjBUT8DZyQkiXs3JK4pMQT63Sf45PUvhx/GXhydqm1llmsu1rSPcqVbrUbyZA7iTVGlZcfkvOQUWiPvCjtIY3jskBJ+uyFgoajYCgBBYD2buwvxGNPZ8DwpHfDvv9KAGuf60POjaXZYMTIZ35fOYAzT8glsVZlmn6GqBmOeLrjTnPELTmDI0GXC11h8Uvn4Oo9Mp/y7Nd7PDe3pGBLkGSB7MGswbFhtv+KlaG8Mj2CrHfqKbJUai/ZF+DFIPOd5On4qgVeP5v5hB+/TGTmBwzj3QmEmxk+Lngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0LymdsvqGv4ayc+7pULqJzEzmb+NZGXLVvcbufesiw=;
 b=cncqyb+Lv0Qg5ve4Ca0fQ83kadWQX11WI+LopgM2v2BEPPA9fDk0jUOXmRZiZur6jJRKN1U3ITGTq6ihR/an40R3zhOMUKxofcVcpatoSjLUJb9pd10FwsDMDbdXzs2bIVSlP/3CRNUk0n121AwPlstHAf06wK3t46JpvHz7wBep782Xstu6vdvn3w90brWVmJL4GpZXjvfKe8aQt1RLhG9FuOTMi8TH/XCCVgR71BXrnK75rt4h3DrshJaaUEGH5SIUQUTxLZ/575/2km584h1G9P8AY2nJy3ZMlFr1dKmV3MtvZ3AByvOj1u+FUFzvd2QIN8WF/+urY3ELiWEzIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 19:56:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 19:56:42 +0000
Date: Fri, 18 Jul 2025 16:56:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <20250718195641.GA2402299@nvidia.com>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
 <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
 <d18d7013-e82e-456a-87da-8acffc90d8db@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18d7013-e82e-456a-87da-8acffc90d8db@arm.com>
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: dff7cd29-a047-4d1e-3513-08ddc635375e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2k/SkUkourtfDIt006ktOO+j6C4X8a7O9CwtIEQQRbcyRRgzicOfUtbPaE70?=
 =?us-ascii?Q?2aFGQ44+Bhemn9eZpf5M9+OVrXcICk6Hv490/XsGhqULuJ2GDyyayuqjnJpI?=
 =?us-ascii?Q?kalbtogiVZZcLijwbJJh+A5BYJGol3LLMk9RJ7s3NfPSX+egbSg7CqVp48CH?=
 =?us-ascii?Q?QmpmhCgMY5fgVwtF2WhD77YjRY5nH4skYvGbMbjrYd6NPixYCVZixq15tKbW?=
 =?us-ascii?Q?LX5ednLqweAVnchCoFSFPYJenAvkt2c7jubNf77S5ajaHc6H3Ix5eWU7MDWh?=
 =?us-ascii?Q?tcYtKv43ndC2HmbZFtyTeFzTwFqdqIBHQydljTgqVqw+RrxAUY8a5E+1Lv0x?=
 =?us-ascii?Q?w2rStzXsjIP+4dYp9fKRd2YAgPU3FpyfCOtp93c2lUg8/gZmE9Fj4L2Qu9iI?=
 =?us-ascii?Q?3FaCJrWXTXMB8E5zl69YcvtHsLsDsp/ihAGZ52QeZgyQBjPuBlyRd6fpEeyy?=
 =?us-ascii?Q?BV8iuo9LA4NIPyY0AG/hU7A5YoFUq2LZvi2R6wo4K9AM4ANt5ZK6m7/NMI4e?=
 =?us-ascii?Q?mq5X2j6H0SVlnE4zMWDqEiVC5oUFEA3FpBrd9b/lDPUTlqQTESxqqgkT/dZ9?=
 =?us-ascii?Q?CNMv7qg76Ek4LR3MkN6FEpumbPT6kOket3AIa2MyW1jy7/pbV4ZlHznitNTP?=
 =?us-ascii?Q?ftqReYCc2kweSXQ7yf63Tqztn/1axeYcE/U9g24gq/R075qHq+CZ6Q6iB1ag?=
 =?us-ascii?Q?qg5Ne/7bUJt5t7t0/peebOzgt2QqxxYU5OD8ZUqTVlMSvr6rmvkUd+fFKRMB?=
 =?us-ascii?Q?RGynkXwvB95EcwVE5Jlk5g5px3mH2nvlXV9XAID8FBIIaue7CWn7viXrBaph?=
 =?us-ascii?Q?pwnAjUw1MyZN7ztT9rA3xCcRy2uCIXhIV1teK/HT3GNTYp5qM9wtVQkAQZX0?=
 =?us-ascii?Q?7PAnmXM6OW3DiiRbUB6jHq+zqbMi6+CKncAHL/41Dz+bltn9Sq2vo7qJfL27?=
 =?us-ascii?Q?tEFbN4bOcyHOd+aanN+Vm06YLcn6btBAo47TBu7hMw88ap7p4zpN6HJsbop3?=
 =?us-ascii?Q?VmIUtKd309T/oAOUEtuf0LMJ4U5ko96Yof5AksTfEV4YcsmxTDO+0YVse2sd?=
 =?us-ascii?Q?qZgZHJSOrrmQDPDQPZK4igVRT6Ft+0sL+iFa9jwV2QFnimvH4db+YE0RuQBn?=
 =?us-ascii?Q?2OCUVabqmGcE4jeLYeKzFpJzngq4IUK8rVvrRGwS5lORbevAau7Vw5PJAWD7?=
 =?us-ascii?Q?qos4GUGtX1P47lP4f019P1g2M4i1gAlrusQwOA/jtOrf3PHAFvWrw/f6BYgI?=
 =?us-ascii?Q?T91jZuda9BAs0azEFcNu4b5Xy273/BquOig5J0P0ZUsJ2YsIIMJQb/S429U9?=
 =?us-ascii?Q?Fj0Gtou4JXA1UanD8GPFz+l7tUDBvGc+7r1XjsccgycYwGmIaJM0P8GevdDn?=
 =?us-ascii?Q?jEinHjutOcjkMejw65hya4usrzdPi1UAWWzhEHp3TH8lRqtaOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YxV6cuyilEyK9xds31Y/5P00vwf/WkMFf3HIOgaTHCCwtpauWu4duQOsmu8L?=
 =?us-ascii?Q?zNf8M5OIBguBqWF2vn6+Xo13boK4J2Ubrrg918MqdCONwnAwGTqWmM2S1VJB?=
 =?us-ascii?Q?qqgkovLKrS2ApKqUdgvj+ZqHwSglr6qXUFRMYMI7JsLK5sJFHmo/RR3PSkeF?=
 =?us-ascii?Q?uaRYSQQwM9LgiHh1YkWU1SJz1EQ1NvF4yRHCH2gFfNXfj7y3rThCdhtqz6yT?=
 =?us-ascii?Q?QhP4rjRJAV/lyQT5LHcg451xNJZEkZ9f4bJrEDso9VuMLWp1FjTGq0UmAi7D?=
 =?us-ascii?Q?BlNCsveU0DUr1WVu/SdzZOyVerZQbfKVin7xTkllWTxrfzEpi+0GozMbAdk2?=
 =?us-ascii?Q?t3h6WPrAzNWlpGR65eXJDiCY03xtqCJtg5R/W65jb91+PZHC8n1Rd0dbmNx3?=
 =?us-ascii?Q?KEHwwpu9wtVaoOWn7zeZxEWXARQox3IAClsvDABYC/yz4QNd+Lg1GI+xbUGW?=
 =?us-ascii?Q?qi6SSkxy52hA+qQ2gdFTb2preBx7L0Ll6RztkhYosl3r2IfaKI1sFAkdbHpY?=
 =?us-ascii?Q?WAYxvU6yh9uT38PvayaYIPw3gDWnZwgiY12uQiwNknmHystiTxsJGH9GI82g?=
 =?us-ascii?Q?w4muKUAcHnGXD6tC03vzQx9emVTAiRhfXSLxOVGlrd1y9hC6RtDLX4qPvN8x?=
 =?us-ascii?Q?8TqNVqSRXpSbF/Yfpk5XEnzrh7fvp6szW7gZCihZtk5v74CR+6SbeqMa3Yj6?=
 =?us-ascii?Q?ai5fpGhmMWQJ30e91lS7aB9Uocj2X2WbhTstt53PguRrbw9tvHCYM0cH/mtf?=
 =?us-ascii?Q?WMAAIfSTlB560TxlNKr9XqZilYkVRtUwS5qVutjaUqzhRwyH0Emz+L3H1z+T?=
 =?us-ascii?Q?njF4EszuqIAl1uKEcoB8rdVblNk76LCmpIuV6gFCZAoS2xzUu4bsI/ganxy/?=
 =?us-ascii?Q?/3p2uqnqVsw9gqe5cjhNwJnrSMZBT7zjHIhwPayMKdgD4icarqZXvQQ2GYLR?=
 =?us-ascii?Q?x6NQ5e6TRkTELi54tAzLPiF8Z1teKU1W4KwqYEEwkC3oHfzpIACZSTmIxTgP?=
 =?us-ascii?Q?hdQnsZgjOCOikM50auVOVPO1H2QGaKXZ9EhzPElDZvMONQt1KnPgha5luqWS?=
 =?us-ascii?Q?Kl43coHeT4Whnwcyc2hILP00aN3Mfd7BdFQbruDQS9+0TZPDcqhIW6vz1j9h?=
 =?us-ascii?Q?1zNY02WwY7vpAdbH2nG6seTQNUHPtm2JTxZ4YoH3kowAavRmqOEbTQD6UJJN?=
 =?us-ascii?Q?AjKkEdUPbGYi8itpGs7TD5VDz4vXL+VWvQy70Ntr1zlEnYA1Kt97CKZVEv70?=
 =?us-ascii?Q?idD1sBQfK6JlcZjaXUvsrrUVSOvdlgv9eZsCQkJt9+QhdZL827tqP74lARb2?=
 =?us-ascii?Q?7e+Uh/no/tmC877IFdhWKIPMJBbjlYmVu08GmV7R/898OERBDdHT11C3Do5F?=
 =?us-ascii?Q?KlmoaKRq1nq3yIn/k12eGFaFPv2HSw1db+TGedX4mOR+vitwpId3fAt8Zb6w?=
 =?us-ascii?Q?huceTx2aHtUR5+1s8K8g6qijQkMekr8P12jHz4XldwTmTCtACUaBu2S25M/D?=
 =?us-ascii?Q?7Gt+Gey5wDbj/UUWMETjz2b7zZnTp7bePv/l7ZftoJbwoqTANwXT43Z3YDr2?=
 =?us-ascii?Q?ZGJvbqlekySFhiqZbQtsiYeNenQv7nKI6s9wSO8c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff7cd29-a047-4d1e-3513-08ddc635375e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 19:56:42.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3r5kkAZyHcHhLJbTTZZdQbN+1OHNOqTbvQ5hQ6gSrxNC/HVJkM4n+giaRjS4jga0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

On Fri, Jul 18, 2025 at 07:23:25PM +0100, Robin Murphy wrote:

> Shouldn't it work to parametrise both numbers accordingly, e.g. (if my
> Friday-evening maths holds up) reserve "1UL - MOCK_PAGE_SIZE * 16" then map
> "MOCK_PAGE_SIZE * 10"?

It could be done, but I wanted to capture the syzkaller test case
exactly as it was, weird randomized numbers and all.

Jason

