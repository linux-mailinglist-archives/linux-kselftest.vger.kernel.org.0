Return-Path: <linux-kselftest+bounces-42319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC61BB9F45F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865DE7A7890
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3400283FFC;
	Thu, 25 Sep 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umjnMvp0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973B283FC8;
	Thu, 25 Sep 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803555; cv=fail; b=NY+gLSGGMOwOWV1RH0AKRMbEnZZu77bj825KcHE630uNzXic8o47lPWkD2K5B4xsbxP8mDmVR8XAjSOW1UAaKs41NPo3In4JBCkyR885/pk4zBkxay8Zq1Ew3CQfmtTKPIzCGHP6KPFYcBorwp4zsNFvhMjbUb1GjhV6W4fZKRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803555; c=relaxed/simple;
	bh=/t6vdTvA3ofcnYTGhsRQ1rkERSTzBjSyPafJngRey9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hYhTrQ/F6MAZXYOkUbOBuKCyxYmZ205IF05f1xcsVkrPzhDGmV5JJ0dK0f6HtYWylEW6eacrcUYgqvo07/gl37FzvWmyEqodvFTT/w9IUch6y2QCgYMmw1cGOYcDCoC7vCIKyzeYk4uJceQGAKcteJCXp60x69opela5im14e+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umjnMvp0; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgg6V59yLN422wxc5xeQGJwpQdSesknmV5pzoKsCy0pC0a5nFifJc7d/PquHwSsKlFSG60/G+32Unx2I97eF/EUTP6NYuxpX6EMGEmv+R5VriBAwgFMVSqynCdMre61x2NpGvhxgH/gNKD5lCYC7jmmECDCSXpCPK6HqBElSK9UjQ6P77ty85I1v2x2mazT0t5MQVdCj/+NqHXB7LVrzfCdaPhvxTzsbZygJXBu5gQXaO5KFC5yPIeB3o58Xbga8d6UPMTmyUwS6ISuHBdvjjSdbiDTyE4aj2Fu7RgQeqTECy9I8v4OR6/3R4w+GRuHXfRrWdGPcFNVmd7uW6G2N3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4MbEj8mJbJ6XpR/hRf0m8RCrlX04KW5e/00KADROdA=;
 b=fOJurrNsLFn9q0UFLW0jsCSyyIpM8aEni6zlrZy012LfpzsYFUS6SpSAJcmjoSNFRHSnzZ1VIP2EZ/S2ztWRnCe0SyV974LaOvwycgFOZgHmddV2Cz0rnZXSwQ234HyNHXnzAlcv04UERjJwnuGUgJBqr6gI6OvygTpxuwtrrAIHsLUN0pDVOkjPZAv3/2l1jGDQiF1bJvciWAsccYMJLphWfN412Ua+K/iMHaJVtSG8/LxS8nDweAYLOM6J0fpcSyNFANvlZd2ot7g7Jz2V0QbT1SSL8ZXvWBUE0BvZh4gNGVVFejgywnWkqxIeBN68GanYq8G9mLTtSQfuJw0OMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4MbEj8mJbJ6XpR/hRf0m8RCrlX04KW5e/00KADROdA=;
 b=umjnMvp0XxK6FNh/6NKhzGKA7Hu55CAgo18tAPNgFdOG8kUzTyC8WlA+f17Vvc4xkNOUBx/BMsmkrSLMMH0i0wdofyuEouCJ9mOCWmv775kZ6q27NRvWgppe37+MtEMSXiCoql5Xph6MijJ8BCp6wm5kbJCfAMk4SnPhy58Zx2eaMY5KG4jyXx3Mk7BFo5SnzEEl76FlF4vCFEToVjyd/oMwpDj3Wp29DQGu0RDwtFjU2bo3uwSsxYT+1Eq79trm2V8ww8Rxysx5sGARhZuLfHZYqDr2U/SBnwSwbArB9tzNYAg+fHVyZUCGNrF/74idCqMVTDvMMqfpAwuiJ+thYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 12:32:29 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 12:32:29 +0000
Date: Thu, 25 Sep 2025 09:32:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v5 13/15] iommu/amd: Use the generic iommu page table
Message-ID: <20250925123227.GX2617119@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3e7mfy2s535w47z2cafeugv6qcy55wtijnzxeqozjbzhbeto4m@g4hamtjzg7bm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7mfy2s535w47z2cafeugv6qcy55wtijnzxeqozjbzhbeto4m@g4hamtjzg7bm>
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0611e6b0-3cbe-4b3b-d82f-08ddfc2f974c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbkdmHPYwChCKrp4L9Q+Z0JvdJy0wRRMOuyt2yhDDRQ3RxUhnVmLCFhZx0rp?=
 =?us-ascii?Q?xULfPcGk5iKSoLERPGjf51WU9GJYe/rGS/lp3Se0g/yAnloiQy42QP7kJNgz?=
 =?us-ascii?Q?4QYDMQOkPSfBopStqg9hhh0MzfVZUqSaq0Wz5PxDSciq/fmc6P5z0lCY7DHW?=
 =?us-ascii?Q?cTM6rCpVbsVdLtZerD3Jb8aIiq6X6saxqXAT9JNgOeFFX/FjbqOksOUSJUpU?=
 =?us-ascii?Q?sPadIIiW7lHCqvT+hr6wiGJFebS6yXqXYmxFYsB5Mdc+WX9+yslh/32ZyqCM?=
 =?us-ascii?Q?s+K8kQ9e1r01ZihPIrJuVQPeQqr37Icpj4kVDbfycc6VRdAXpNXmJ8/ynYAG?=
 =?us-ascii?Q?rvdWMoHKByUg8rfD20bwyQObe8IR0DedgbrKUREFe89cAK5LrVxZ4zWAWKCw?=
 =?us-ascii?Q?x1vJdS5GihYQL2QC8b+4ZesaHzsitBe78E3BI1knDuY3MmbHyG7T2Otl7XHd?=
 =?us-ascii?Q?JZtU7iqGc7Bv3sfLWw9gR+cuH9hLh4spfKPt8zOSqJvlB29xqS8XlnHqSTTm?=
 =?us-ascii?Q?4UFUFRXQ1J6td4GO1bNLOSJ1bHnZXCtWmwYRtcOwHdNEMgaMjZvZ6whSOXIi?=
 =?us-ascii?Q?ETK0Dbtpg80hkXuHD60qpU9DEu+Snm/kb5sfvhJa3sRXbSQ8yG65rObcKGa1?=
 =?us-ascii?Q?14wANpnukxS8PMw+CLYevjs+pKwBVGocoeUxwM7NrHrsVTkHNis2ZjVXyhba?=
 =?us-ascii?Q?CHa/MKMZ630LujYwtZmNz32g6dnLk+bt9OZj0uhRgp2+t3LaxBW7Ld8oDDFX?=
 =?us-ascii?Q?6VfuRV+RvfjVSZr99Qu6At5nFS4VOTaRrJuufSKw553+ex/oFuJ7TrLxSHZM?=
 =?us-ascii?Q?CDbrp9FtWM6C3udVYgzLnS7+mL7dMGJLa3MPttrx5i+0hZJH+6dtJtugofV0?=
 =?us-ascii?Q?fLwDLsHGlvrBoOBvwkUypO0PSvJn/Ux1a+DJV+Z4RDyqPj1MkYWhpXJC9OeM?=
 =?us-ascii?Q?RweOvz4i289FZkdv9kFrgAKWIqbIteWorOsXL+U6ulKUkKDepEf68AakQoRF?=
 =?us-ascii?Q?1Nzd4OmC5AeZfogcS4NNGCY/1T9tK3M7Bj8MoadArcDX1QdAnM1MWm5I93ok?=
 =?us-ascii?Q?9rr9Nv8hWU0XSedGD8Xwqo/jZ4eXQCTJ6AiNdHhouAzf+v4WO6RvsbTaOrgU?=
 =?us-ascii?Q?Ee64w3PZWhmTfZ7F9Ax7midbPuJCYJ0WDBkpOYfnpKBfnk6pb61emnvGxuzY?=
 =?us-ascii?Q?dlDOJDxM9DXSSSKlXul2fKEMEgYyEa6OVjCq8jFPtKVSp7aAVt5wbESgvlkT?=
 =?us-ascii?Q?y16CF2rmJ2MVOT37hJmGqZle5JeD8rPfEy1/cs02TZMWUjY60wn7fnrqfgVH?=
 =?us-ascii?Q?7yFebfmHVyRLP2c9geZrG1tE86ydk0JqdD0Q9MkosFOrqKhlpwi6fOkNfTJY?=
 =?us-ascii?Q?/tmCvoSQgVlWOVrXKJ97rlDtBhqcPj2VkAFov4B5GNKXMdDniksRb5at5Eou?=
 =?us-ascii?Q?Af90dbdMu7wYa/4GmeS+akDIQ8sFpyCr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2EnB+8KPrF6da9+tAYgTzktACqp8qN8gW3Fe3AzYvLKKiiArVs+RHtUpTyW?=
 =?us-ascii?Q?RGhSG9JFZb/6meNLKlGe5CTZAsyIA2bUc/zTeU0dcyH2HUUnl8hbHTHVIIpW?=
 =?us-ascii?Q?kUsS0tuX2RZjMjWnFA2ITbGchtCGYg6KtGtyXRzK/44V3XM9nsoHdLfChdqr?=
 =?us-ascii?Q?D5uk4Kiv4fKFWlrLYfcmvFzzJL/Sy6G6tIzIqJOz2hdbXzk9bhfNHAs1HBmM?=
 =?us-ascii?Q?QU1Hgm59HeaGBPhH6a0T4QGKig6ajLFeXqXP3HmQzGvcP3XKYTsEMbq0z6fW?=
 =?us-ascii?Q?rN+wTW2S8CfHu9yOibnnG5O0yuk39Gtj1ZF9ZpKQ6tLIUVGtpS+znr1pab8I?=
 =?us-ascii?Q?48kMO/YuH/XjKdroS4kXGN5j3YcXBhFVBNrnYFQEW8j74CEeQE2wvee+3Fg8?=
 =?us-ascii?Q?maCL7cV6vy6W7nx1F165qDGWbey346O8cr3S4jnfBtI6t3aXh/208J0G5XBc?=
 =?us-ascii?Q?BasruEipTrRkiF1qC2pBh/awXdob710kkX5XglF9luyTF0dl0aC0EDGvD8fl?=
 =?us-ascii?Q?FQeGLvl7y2j8OC0uywjJHmQ0EuhZcm5JzMPwuLMfIbd2Ipx+KhqRim8jrch4?=
 =?us-ascii?Q?Bi9b9ncF4KF9R2iPppxaJ05N+yrvL7mEwBfzSq0/bj88jOyb0Tqf27PgQNHV?=
 =?us-ascii?Q?2GZLsdShViH2vTqVWoVK5IAkZDCWSNk+6Po25G54Tx1GE81KKc1KwbDjLyoO?=
 =?us-ascii?Q?tUZYEzfNTRHOFOF7IY15zZhqwt8T6ToApkw7xwuDVX6c78Ptc6kOcamFf6VG?=
 =?us-ascii?Q?fLA/qWsntr6QMiFHJgMzzgav28s/UgjnG1z0NZmhx3lD3H0TYmdB4se6kD61?=
 =?us-ascii?Q?iIuNALwGbAVDXtlcxewRgF1hluFiaLN1XnSstiiUqk3MeRwte350/jKtG6OA?=
 =?us-ascii?Q?ci2qgG5UUxNFtILazBx+lyMxEpenkiVOoOShbNI+jLBm8xqR9my5sI6AZw+w?=
 =?us-ascii?Q?9bZj6wPDCr3btZ48UkOztyzcAUMNgCTWOMWxurtOgdBX4Vu+Yvg0VRkvHbTE?=
 =?us-ascii?Q?FEBrf/Q11Qmzogwldxpmi2alg2cFMdIT1htb8nsc3sNYQomJ3MG/LMoT/+bo?=
 =?us-ascii?Q?IUXDkewXLSfvplPz251P+rqLzynX/XSy0dSeKE2x9Z0NT0TZ+4JIQ/x76FnW?=
 =?us-ascii?Q?3ACoBxxCM2TgZORbNx8WQMOi8TwLeVv0oHkLKATr6FWvkZC8aJzF/C3eEy1u?=
 =?us-ascii?Q?aWhEORzzi82wFgvEPd3B//3UgeE8DqVeGq2Kv54xWtBZUnyfcWb2Xq4yEDgE?=
 =?us-ascii?Q?PY0pyApbgVAzX6jjfk8izMv/MlJripmdYk6LH0IqdlhEhRBIXNyGfFigQmCZ?=
 =?us-ascii?Q?Y25koKFQ6GnWLHoexqal0SYr4Cb0BY5L8nPG6phEpSuKOf/yoWJMrBfp3jWo?=
 =?us-ascii?Q?YG+MdM/5upDy8nVskgU4SgxqgxTp40UXto5K3q9R7n2dkEhFkcrx6d5kWjdz?=
 =?us-ascii?Q?gFndWb3d11LXo5ruFnlhvtAsGx632MWstdRv2O+NCCTh3koZPeT4jsHbjwU0?=
 =?us-ascii?Q?ATjNt9XUx9Y5WRMDyPevskS4fjaMOsL0+wM1Z44fYQKoeD7EYobMZUY/6wly?=
 =?us-ascii?Q?JNmn7rNV4r2x50lfbEPVkibiOAPA4r5gtkx9Ij5Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0611e6b0-3cbe-4b3b-d82f-08ddfc2f974c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:32:29.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnxRWY3ADQfQ09QIiJLDYMJF3MVCRLGwx3nwcGdBjVSxsWfrZvLf4GR8SYbf4CS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

On Thu, Sep 25, 2025 at 12:07:04PM +0000, Ankit Soni wrote:
> > +
> > +	cfg.common.hw_max_vasz_lg2 =
> > +		max(64, (amd_iommu_hpt_level - 1) * 9 + 21);

> s/max/min
> with 6 level page table max will be 66 and i am seeing boot failure with
> this. Please refer below fail log.

Oops, I added this when rebasing, thanks. Just to be clear the max/min
fixes the oops?

> [    5.458439] BUG: kernel NULL pointer dereference, address: 0000000000000030
> [    5.459338] #PF: supervisor read access in kernel mode
> [    5.459338] #PF: error_code(0x0000) - not-present page
> [    5.459338] PGD 0
> [    5.459338] Oops: Oops: 0000 [#1] SMP NOPTI
> [    5.459338] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc3+ #83 PREEMPT(voluntary)
> [    5.459338] Hardware name: AMD Corporation RUBY/RUBY, BIOS RRR100DB 08/09/2024
> [    5.459338] RIP: 0010:sysfs_add_link_to_group+0x16/0x60

Really weird the above triggers oops here???

I updated the github

Thanks!
Jason

