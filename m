Return-Path: <linux-kselftest+bounces-43631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7019BF3FA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 01:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0262A34DE02
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D442F5311;
	Mon, 20 Oct 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWpw2QPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2322D979F;
	Mon, 20 Oct 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001335; cv=fail; b=ZybjmmDBjl+laJdajRSpU+I0Q8/fc19Q2/lpHPe/3+3TllmttywGKuQQPn6g34RteAHrdwUasj4R0MbWdZOjzX8F1d4S7ukrofUespQC4SxWDWCHKDEkkqNsCcgC0n4t8gmc01tc/NfFvMvu4tQOg/LqDK8MTlnNbZcL/JQiQ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001335; c=relaxed/simple;
	bh=ge+c/VdzQVaEex3Mao63FNz8sMizU7RGBhK/pZGTTKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dh3F6I9+I3pMlv6nmXrKMmLWDWjYfUGRBbVSAxaC939MMOBPXQwZaiMlvPVsiWmcqhsIeRIK7X98X2aRU+oSk5lrPBekgeH6pbub1r3K6JbZD7o4/fDIKk/ymmQp15BNRBQA83O3T4ULz/OgbFIYUiL2dO2gPMk+0yLWg6Ufr/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWpw2QPC; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxjP2yWgsXN7HjKQYtkC5VRK9ZBHREX34a373IQiqWEDa34y32F2IoCdeMEU/bxIcI6yqwF90kxiVKWGdb/Dn3CfVXlI9TLwAMxzJp052zJA44TbeyeyLlzNRs/JmPZY69Ic0z9h9OrC1kU9LYoh3r99cY9jR2n5Ep3uZ0LOv1PuJF7ECmMEvRsbWO/uy4Z1vzqbT0cNrNR7mFmWo2aWs2zMEup9B172OBVnmShNFx1MXeR8kpFZrM/+30/6ExneRwpYVOmTO7SYrQbbkTjbQoUGDqCr0D4GnQ6xcIAVRNaBD+d9709e9T0jgUkDX40NBpx8dLpzDkXem/UYmC8+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH40EOb57t2rxkE4EXmpRtlxbrtXRVmR6Vm3INrakXM=;
 b=VdhBt+YzjfDnAH3QsmeahmMT/tS1cfjrr7zFyhYXZaT8uGf5gsUWzUfk1BXPGICm4kGB8ZfQLqHDwjBc4kZT5mJ6IN0WeMqjh35yaFsIqQZXslMwlTaf0yTnTRl66fGRKUElV3n3yXcJ3gUma26xLpCs0v30KzVNUU2dWxvRsmgVoNkjSswFv7k/gL0RJR4ObxwpLbz4NJfwoC1Gqj5q0ZPJkysuHXMMgcdnDVTjF4OK3XcG3J5j6gSBbZzICbj9t3fTmIzyyOfdtjeD7K8wLDFZQjZvagZUW65OJDKMBhWXheYH9ppmMHkRFqnRd3BkQS6fm+2b006GQ3mTEzLbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH40EOb57t2rxkE4EXmpRtlxbrtXRVmR6Vm3INrakXM=;
 b=MWpw2QPCq3JREMZWmB/IndxUcWDcS1cQzWfJ+AquHtc36FvBOFVGAzOY437PzKxcyXh/Fu8TvXextEINkH9We46etPlyozmHk2vVI1mwUBcOCcIP1JA3xQo9vg3U5fkaShRvS/cX939MOYgGI01/9cNkjD784bv9ZSYD3PKkvFY/52YR8KNJOQ6n+d+QlTimcxVdmZU/hNS8oJBjh6iQvgQ1OkmRiYnQempHWNYqhLWrR/wdJh31X3A85IWf3w+kM82ijAsruiX9QgYPsvRqwM6czhGXrvOTmXfkSt0IhNpXcFw9KNkGnWftREecRjv49N/gZTjs4HYbevp3f17DpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 23:02:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:02:09 +0000
Date: Mon, 20 Oct 2025 20:01:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, alessandro.zanni87@gmail.com,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Message-ID: <20251020230158.GF316284@nvidia.com>
References: <20251014214847.1113759-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014214847.1113759-1-nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b97185e-041e-47bc-144e-08de102cb2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xVPHbQvd1D40Gu3IwajQBewGRGtlb0aV8b2tDAMabfcR2K06PEQYnJB/+3E+?=
 =?us-ascii?Q?XOEvn63I/1nWl+w1zHip5wuSVHDeAQH2hiS9TvchPPtF9Ali9j+edWW+p8bU?=
 =?us-ascii?Q?mIVKS5ymatk7RdazuOuyFGzIOtfR2/fLskzcr1f+zTEY2+GAlUaJKJYIHHLc?=
 =?us-ascii?Q?CLHGz4aicivJ1dm07gBAOiy/yzqK7hwpLroS8ny1h4gqpPvITgMSUm2aX+QY?=
 =?us-ascii?Q?xyICVwpMvXtbmrX+oxnga3finJNQcoarPe0RHqBSvBTicbISQ2NcNz7gInnX?=
 =?us-ascii?Q?IJtUMnUkfAEoTdhw7Smji4JuNdx59SCjxmyo7/Vu/W/gKiYDcMDdpiJamIr/?=
 =?us-ascii?Q?Ys/BDMUDbgqgMKgVo9YKLKzK/v2s0++IlqT8YLA4hSQD8MPc/LrZJPokWPkY?=
 =?us-ascii?Q?tc8sPAArypiTzQOZVaJa/QmTT9/ECByVt19L4jZcRPCO7a4TmX4XAsQVbDlX?=
 =?us-ascii?Q?676rZ9Z5F7y9EhJvf8EII74UhTCaYjRgci/aTP4CemcUCxTYnJC1XBqHkpnJ?=
 =?us-ascii?Q?cSbgMilRmXs3QdVebmiQEpuHX46tmVskt7Zt/GynAD5I07GQWKJY7zp1s5x5?=
 =?us-ascii?Q?0Bs1M4787gFGnSIoWDjb8dt11xVlsx+k9xFolX4VfrGdHw1pe3R7vEWFHrpG?=
 =?us-ascii?Q?OUy2rubdlIzhdTSRCTg48Ksbm9MJRCGyM3VLBQWBZnjI4V7Np2yneGX3e9Az?=
 =?us-ascii?Q?IxNYEs2E8OKJm5UwBUtPlBHh01OmuN2961Ev4t2vffj/h2Ons0hr5KYdFuy7?=
 =?us-ascii?Q?lpidVWIi30gzlbdce+2Ketfj8GoI8NrPV80oJwcIlk434WcubCkfaXELy2hS?=
 =?us-ascii?Q?iNfam+FolSUeoAgnH7IvpKnNFvdg5MD2qTg5XWI7BOxIWGcFmNrPAaxejite?=
 =?us-ascii?Q?lWqYbM7a3FUelQoL2vCq5RmstuuyrsWxCwgOf4wtdWpuavVk+re8XkL05Mp9?=
 =?us-ascii?Q?hA7wllqdyAPvLhDrssQ6TAdkgFuDMlErzTzE51M40lZYEWKFMiPLWO7hQdcO?=
 =?us-ascii?Q?RGFRR9X5hxYfg0akoHtjsopSFhH+m0JDWyyYVzU+eb7po46J/CFeESrpt5XH?=
 =?us-ascii?Q?EmL7MdmIl4CCtmr0p3NmHoxaLIM+QMhS4NmAqS4BTT+Cp8b24jYFPLhV5PUB?=
 =?us-ascii?Q?NcwIB7yTBzn30HQyVwNVnFaBCv5uBLIqcqcsCluYjvVEGfQq90xmSgTLB3+P?=
 =?us-ascii?Q?sAGJJReWpXdm4UXGprjoQmlL5wkxPh6xjMIhSChkeMK1X65vh0JHCki0wY0z?=
 =?us-ascii?Q?UKG5R2pP2ZCpv6qBb6Q+w9KC6weLVspcJAiywndHWroMjlYVdJfIO4B4cyNA?=
 =?us-ascii?Q?jXC5fUbp9Yf0BSKDxYWNDECNYMnfI3SAaq8p+jmbDj2MwsHvIvvrzwmZq5b2?=
 =?us-ascii?Q?2PcYAoIF8WeMqDcSPwK+FbtcCB/uzH5U/v6bBAbS3vHUq9OtJdXWekcgaDR9?=
 =?us-ascii?Q?XG44/+8YQF4UbIdI2C8az/+8YtnfLneL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wmx4s0y9hk/FVwZBvIpt6TCaH8Ra9tcWyia38Mo/zMomPuOz8437nTEt83BI?=
 =?us-ascii?Q?0s89662ocHKFJMy1TCAD7qzQVr/9fReQw4uWLEES/7fbsrRrEl6M1W7fVfAX?=
 =?us-ascii?Q?CuBqLiQ9OC6ww1XDpQhDcS9XFjDAeacNtQuw98BXJI+WckNM+LghyAszPZcq?=
 =?us-ascii?Q?FdGOn7yU4jSF9Zd7DXEU+El5VZUQAJ7DS60mZPhVM6YJ/23WSczM2CjH65JV?=
 =?us-ascii?Q?6E13DeSvgrnCAupgdM6dT/+bVbe0/53CmUYK579+XrgRozhPtvHNaFwxLzNx?=
 =?us-ascii?Q?ZvG1VxnvkRyyIiFzqO4wcKz0MGD/Hq5Doa5YyZko6n6PQcEPEmirio/Bsk+U?=
 =?us-ascii?Q?mJxugN7CfOZjIDa1ATVPUaXv+5kRSXvr0OmkJVT3JWb/4TrknjdrREB6LTCZ?=
 =?us-ascii?Q?RbF9zNsx1rExbfrQ1eVV+JOnE+Ux306hIwWlqLQfp71Ik8t51P4po2SCBpju?=
 =?us-ascii?Q?/Klis1SdN66By06l85swuQ1Hbe0LDXuE62TiA3ZxdXFyrSWNxR40eAYluCyU?=
 =?us-ascii?Q?XKYeaGX9R1BTwtbmulGZZ5UeuL02Lxwm/M/B4Oy9Pb17+6rWkowMVoYgxV05?=
 =?us-ascii?Q?VKxLfjQYuDTb5DkOCL14ZF6DZK5vJ7waoK4I+ozwK/ycWK1MzDikcxB0l4zn?=
 =?us-ascii?Q?5VY+4OlK/W3kUUnMeQazB/m6tuDcm8hhzWMR1I5NdHiY3Fs7WA6f0ct19n+n?=
 =?us-ascii?Q?esudHB9Vqetoh4QBtaE9JKIotudYaJX72GKNgJxyWSfpEwimkt5ofvBFIWQE?=
 =?us-ascii?Q?KUTuRrKlVH2LuJK7ZGciCEW43TYwQubrCu7oGueK/mqam+q6rr0tHGBOnjfK?=
 =?us-ascii?Q?wKA1kWDrJuOpwonKQ6zj0cVhnLBPFJjpnyHwGdAm2ItYuEyG8E57homnajhl?=
 =?us-ascii?Q?blVGXpkVfOhkcYikdHY2KFmi5QXiTTPSFwSdGlcftddRlvQN9lro04CKwpSY?=
 =?us-ascii?Q?x7197ke0p+YljKcMc6br6Y7l6LS5hveeSErzAFrb/95oghg0eAK6rwOpD6vS?=
 =?us-ascii?Q?cO1ELOEw8I8kjbWuBWRDWarGISKIxC4FzFa2NEg7ZoaFTFZVE7Z573+t2Xeb?=
 =?us-ascii?Q?WXo6B7UVbfBxvSmdm+8dHfo3Qp1rT+LpBVowptE9/qhbcB86u8BN8pr/2f3V?=
 =?us-ascii?Q?a6+paeDJSRAVv4N14PM50XaaKaKa65rMSCtIY8XjE0Pjsu6WhNItjSRLLCo3?=
 =?us-ascii?Q?5OX0R3V9cUJJaxHBpR1EThhMp/m2hZuv0W1VMKKoSvs2nEVOqrg14BazrIdQ?=
 =?us-ascii?Q?vg43LFgh8VJVTLtN7LEgHcP0X5F10nUjBHcolCtcK+pMRcbY8fXhpX5NA6vQ?=
 =?us-ascii?Q?fmzfas9Yeokw7LNqWJDqY1sryGKARKoxZeNiIOOBth4jEpxf9sSvL/zcesz7?=
 =?us-ascii?Q?bqLkejLN5iE6Gb4rT1ZaQS7gop168W2QyGUrfZWkekq/NQngsmTP9Hay2in4?=
 =?us-ascii?Q?pJSPIOqah8H5CAu7avUxhhKotgKcL/DyW0Io1JTLoBzVBqokvmOuFlObBpqC?=
 =?us-ascii?Q?/xOmk3ZY3Mrgpc4tCOhC4EUx98z517Q7Bd+iMxUe7XaH6IpZ4oE6+i4qkT19?=
 =?us-ascii?Q?AIsQLB5HKXaI2xr37TULvX084/xNxyJTPN8JiTZF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b97185e-041e-47bc-144e-08de102cb2aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 23:02:09.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9pqM3xSPcHMCq5rvE9X7h1ZMULkWdlGyvD9BXV5FzKApqTt+l7pi6UPCjRQLhmL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

On Tue, Oct 14, 2025 at 02:48:46PM -0700, Nicolin Chen wrote:
> The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.
> 
> Drop the '!' to fix it.
> 
> Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variable")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason

