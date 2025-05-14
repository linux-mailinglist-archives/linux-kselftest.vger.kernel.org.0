Return-Path: <linux-kselftest+bounces-32951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2011AB7084
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 17:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A151E7ACC81
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C827CCF8;
	Wed, 14 May 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEEh/KVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857E27C152;
	Wed, 14 May 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238057; cv=fail; b=LU54+CHDD096pFdezkoo03D78eyWCc+aVXWOnKIboKlkU0aV9HXfnumFGMT1C5kAQLRxpGt7BdbEi6O2jPcISyBczyokX1JCY59eQpNxzouRMoaXvsdakiqZFjFgj6356n2kFPAR0duLSQWlmGdx0ToWkG0fUQe1HWLlRhRu6g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238057; c=relaxed/simple;
	bh=TwTrN7StOSaPu8ENxLm0MUmv4haTPa1YuLIxPUxZFg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rETMiykJzSjyKXh4PIx2ttC4Sk9iA4dIRca8Xn4cl0Wlqv9xgDy9LYEP5rVdwmRR9iGwRwqVTXPJGhkoL6VH2B/fMb++VHri4qVhydx2ScCv8CUVAYio26nEBOjqQKdr3xMiZEPdMSxGg8L4CUzGBjbcYRSpbK8tAmZTVlgu7zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEEh/KVW; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krgsLZYb0QF4IQ2ijB1v3ZV1X41Fx+F8Row9lnLqKZcgqm701qMCjYBSkSy5LEUv9saXHYikq3S7VVKQ3i4oHz71vWwL1sbYwDLo8LOhVyNIR+L7nnciP8HzMjhsR77T4D/hIeo1mRnidOb2ucI/JJUXX57eSl1MtH7UmsZPtzhBGiV1NJVSWhlBzXPZNFrR+27YgVmrnZk3lNUaaRtNvYWV6mkRIMIX/mPvFD3X4sWEsKqYWLc2xcvuY5pRd0y2moCl5yLa4tZEXdcoGc6oCrg6Y5VjBYPqqUCbsUKGLKOJL0oH63WCQBWDR1b3R/CYFd1kKOx02eGLrluksVh0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER2cBH9odtKWOaJ0hmZiCIx5uFRs7Fl1mRkmOm8CM0g=;
 b=GBeTPBkP0T9tUEI2o+liD5FDw9UxfgUzm2quVy5ZRfYNepoM5NGt91djXOvsAKMSPkyoxhf9fJNKX+QQ10RAy+iGw9KRmWaC0slNCJzsjmn/qcfspWJeeWTu7wYg4Yoo9EtAGxVq/AyipLarsWz2QjzH5Ghn9XqJPTM0c7hHAMuOzOxb8rCdPTTcvXCyNUt2iYeiCBybvIjF2Q+kqRFNOn3UZyJe6Fe6WP+19IrFxkk6kMOlcfa1jCKMo4AEUSUaroe0pj7nhn3U3uFK747HZliGTT7UeWbd46+t+MTePAS+RoCBxOmm9waocIGX8jV1grL5GmHGUAHxJpHYwEYJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER2cBH9odtKWOaJ0hmZiCIx5uFRs7Fl1mRkmOm8CM0g=;
 b=oEEh/KVWotmAXh9yqZtOLl5ZrW+TA81Zj0K6G8LO0Sg/T11VCmSZyGNMv850chKhBBB6JB+nmuWe30l+XXIu8T2cdsFMqjF/ux31gQ/4x7422k9ETP/jqC6E2SKmmvfy2i0j6RBIUdCHA8Oe5TxfqqBGdpTmKyj50cCui+jFejWOKZKFIv9MLaJX2CkYyDxMBTQ7sUeq5t99Y4GUDVKcBPXO3bAnjZHIH4mXx+dXbGPBQK0J9Hac/crTXldBgOKQc0f7b9zisC8/ejeEXgr4U4YcGtfwXHDDNExzyjDauzeEbnXkik75VGK16MleJZM2ogWk6TyKETgb6e/6YxtTyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 15:54:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:54:12 +0000
Date: Wed, 14 May 2025 12:54:11 -0300
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
Subject: Re: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20250514155411.GC382960@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <pntkuh63y26rygrkxegbzncvc3shtplucrnzkkz2dimpkfyn75@uekvyuz5kred>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pntkuh63y26rygrkxegbzncvc3shtplucrnzkkz2dimpkfyn75@uekvyuz5kred>
X-ClientProxiedBy: BN9PR03CA0487.namprd03.prod.outlook.com
 (2603:10b6:408:130::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: ad557d06-17e3-43bb-e592-08dd92ff9209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BFqW8NKi/nqSbFDqiHfRrKc+ItV6Hm3hZ4qrtJ9IlWQ/Ruk753ojSw4Dl4Hq?=
 =?us-ascii?Q?vM0cfWFkSib2K7khmJQb3MgKn/zCz5cufMeeIQkighSWkg2dPmv7TJj6hTt0?=
 =?us-ascii?Q?FqWf68oM4Cqe700s7VJTOjWpAZxepSumOCMyihXRrdezTBCmOJs39mFkvGUJ?=
 =?us-ascii?Q?lOgMZ/UHd7cKVRGoCeir/7moAKan2ZGRPGJw6zimRyUMj6JqCVHnakFXIvjI?=
 =?us-ascii?Q?ZDXQRumqg3K6qtxX+RSDzbCJ1WIwXGmKzpA3YGVWEBJeZH6Gs+BVvovHPam/?=
 =?us-ascii?Q?22R72QrQ0gW7BoqFO+rQ6ALo6Rg2xcTIVPw5alCXqqpkhZDlHyk6CTg1SfB1?=
 =?us-ascii?Q?U6SbJXiBSH7oBNsl2f3ovejQBJDtmxXcb3mhPWmUAASFuqvdKximrEvdW2Og?=
 =?us-ascii?Q?DvV0ppWkPfkVDd2OROBIJBJJvhgXpwZfIikexfdnqWSWFF7eILRhREtgJxJR?=
 =?us-ascii?Q?4U7qNX9bv98qQOju0ZZEHNcPQaS81yQqz++VrW2l+8/iOL7R3VA0e2fdFJjG?=
 =?us-ascii?Q?JEfTbiepKzAZP6wgqL/ECxPdzUvhXYLOW8ECi1u7ga2u/R3fMP9hl51leofO?=
 =?us-ascii?Q?UBgRrFUm4Y6iEWIE/fLt6oFO60izVTmDiodE8eU2pvx40D/lV+1pd2vKDV99?=
 =?us-ascii?Q?GwUtI5lZ5E8poHDxOSvi+QwS3CuEbkgzsgo7sVeeeiL5hF5r9TF0v/e7KHfi?=
 =?us-ascii?Q?9v/BDKjkhltOLm8+d5oQ5zgQZw+A9LHKdWeWqzyJUSyV/x/0ORZhAl5nsWhF?=
 =?us-ascii?Q?4qpF0PsQkT8k7Lmk4o2xPXJ6reqnsAbMzpNCKJRvF0DQjoBaXGxGXA3rFvwu?=
 =?us-ascii?Q?bliSQ0yBNbsxE3XKUbrTYUHsOyp0Rfs2s2LeKGVXRNDsmSUzwVj4hh+5uz2T?=
 =?us-ascii?Q?cLHaw437YTgrrljhRMtSugnyZIhHB1/gYL2+TlZKTfeiFAwZnnU65jaJfQSP?=
 =?us-ascii?Q?6sUqVRhgG52OLd648RnEeQPB56er5jkGxfX+MHethkJEibey2Km85NkMoxct?=
 =?us-ascii?Q?j2UwHDw00lJMMpUzYsF+tyCpd4dsgG2vMvnSjiZDwB02aPkrUAK+Gkh3Kug3?=
 =?us-ascii?Q?wRT6CftUS//XP3Ubl/s1DbtYNf0WZsZDgfP1iVEzZ/rGgvhd7ddxmc6zrb4C?=
 =?us-ascii?Q?fX2qvPrZh/T09qaIN6wm4IqXzXhcfRA2ut9n6WQEeuPd4m8F7P0w+CjZZKLJ?=
 =?us-ascii?Q?nQhfRcCL+etuZ1TCdWyP356ZYdVdYQxvMCqNHFFU4Nqd42dU7eBWXm4ByVyS?=
 =?us-ascii?Q?XxV29gaSIqZv9wmLouBZU4sl+KIfVf8FNvmeor/w6QEbGzQQca8qdZQ3OORu?=
 =?us-ascii?Q?yRb/B/IbLH3741LxEEwrx5FpP6tjk76qcZtNpe67pkZb0J4sm0eo2nVwQmU1?=
 =?us-ascii?Q?ndsPMbjKNCgNgNGxSG9e+aEKqDxAKlJcwUQGkXmR6DogTeoR+5jU4kkgx59/?=
 =?us-ascii?Q?RqKtTW9Ge0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycft477swNTmW9PnNK2S5HXdQEillFevF1azFVNqzDOnx8fom5ZDdP6aLrhO?=
 =?us-ascii?Q?isxkDxc4dX+tODH+9JEoJZBAyBsyuWuv+GcQY5c8XrKKnarD/4lgxZZxQN06?=
 =?us-ascii?Q?CrNroyXkBHWqA2/JfgqFIkvm0H4taM7tRo0B3kdt2L3vl0LQO3Z35gxqfXnj?=
 =?us-ascii?Q?EphcssSEol19Cl+uS4kg3sngOD/tzrhvDaZpzHvYfJRYNwLyzAJfEBIDQbXQ?=
 =?us-ascii?Q?ZlLMf7cqsJA6khIO3Tq8qrpo5AK5IFOhwPYcyqidA/Wu/KPhXg+jH+7sXBnM?=
 =?us-ascii?Q?Bkn2qvdVaD1q5GRg9BTZQ1mRNl/AzbZs+fGkm5/zDRVXjpXz96c7F8sIgurJ?=
 =?us-ascii?Q?VQnwHZND+joM/j3N4xM79+/naeViEv1WHB7+gYDauMfZUVHE+owFfXhl+kUA?=
 =?us-ascii?Q?RWcofkpvP+F4WAkBNbNOaviQ0SeQTp4d2fi58K6fnWVh0n4EqsT/cJxfw7ux?=
 =?us-ascii?Q?0yq9Z0VhMX6czRt7eExMXyoz8Hzh6pBTKm0TdDNHwAccyg709RSG2XP47Sdi?=
 =?us-ascii?Q?hTVyrwPLoyo+CYB0UyM+WBNu/eoG0lozZOsLbQ+rhmoN1XCjONGU4SR1ft8u?=
 =?us-ascii?Q?6GMzYUpZRH+sU2aZOGEd3+ddZZQ+ibbU490b6naF+iw1FybwbeLY61RMVmyd?=
 =?us-ascii?Q?aoC0mi9Zu1r50LGIK3vgsY3Igfjc5YPndFgfT0TYG6mlN4FH7fbrpE+rzLup?=
 =?us-ascii?Q?gWnuv6sqJ1t/0CHJtnZcOiF9Tb36/uTFOiDhuttB0EepVOFYQi3RnlZxZdtL?=
 =?us-ascii?Q?1dcpBTh3Q9HaZYHgxQMDAWgis3I+1EWEcWCdymc5m6UjT6ih9mVBU3QIc8am?=
 =?us-ascii?Q?BGTPLwYvrTdEicbE15WSTNIneOVkDO3amh+O1HX3oZKtqBl9GvYEYp9KhGCV?=
 =?us-ascii?Q?87A5BX+9nLiWClMEgRrDnKqDPTkMLYATTEQvogpE+k6cOy1imzbHo9QfCvQ7?=
 =?us-ascii?Q?sW1n93QuElR7SrcJROMW+w87cmPrdlFdKSNo5TdMZrypeHjvJoj40zHsQ6Jj?=
 =?us-ascii?Q?jADJpCZ8pkhH1rjR8UjYwOTjkRxqg5phl3qXcYSALTAtB4YT4w9UdcTiZ+QV?=
 =?us-ascii?Q?JBexYXXyEnV8JW3dM0TuhwMd7b1boePAKf7QoiGvr6+QpnwGFKD39+MHKy1F?=
 =?us-ascii?Q?hN5viXuylcS8zRxdLEHGuKxJg8Ezsax1mnPhRFvrcACjqe4Nu7FqcTnZOrIQ?=
 =?us-ascii?Q?GUlJ3OG5Jl7S4HJCXEXjf8AH9v8pBe9DREcEUD7kqJLVHRumZOCmTHRoATkQ?=
 =?us-ascii?Q?c3S8cfj/DlfDaIlxWHYAJdZWDWR5PABb5H2sID9lWvTTxz2u2wmthm9/jEHJ?=
 =?us-ascii?Q?+s42WCaM2MaEQlc+x3VWr/nK5u4Zev1/AkeiOJVBwyY8uFAAOb92HMuSp06T?=
 =?us-ascii?Q?RjbjBbEx3g1tHjkAfBCPi/LEFHdPIqfpLeHY2Ca6v0hgBU6BovFG8iF1tg9D?=
 =?us-ascii?Q?n2JkBs5lkUachhwOBUyq+IvKZJHJoUKA639Xrw5x57K08S+3Rb6b88Ty7B/R?=
 =?us-ascii?Q?4G9fxbuz1U7EVa6Md4A8vr/YlhIWGJDgow/LFOgVC8kHxH8goGdY4shGU4Gk?=
 =?us-ascii?Q?uFrE1eYddVsur9HDwzYINgRn1VSulmqpmSH78hrB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad557d06-17e3-43bb-e592-08dd92ff9209
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 15:54:12.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQDfWtlq80uFTiBTFPVputE8XejXyW0/J5zqDkrxb+lKQptxKsch84ey4lmIDIOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

On Wed, May 14, 2025 at 09:23:49AM +0000, Ankit Soni wrote:
> I am experiencing a system hang with a 5-level v2 page table mode, on boot.
> The NVMe boot drive is not initializing.
> Below are the relevant dmesg logs with some prints i had added:
> 
> [    6.386439] AMD-Vi v2 domain init
> [    6.390132] AMD-Vi v2 pt init
> [    6.390133] AMD-Vi aperture end last va ffffffffffffff
> ...
> [   10.315372] AMD-Vi gen pt MAP PAGES iova ffffffffffffe000 paddr 19351b000
> ...
> [   72.171930] nvme nvme0: I/O tag 0 (0000) QID 0 timeout, disable controller
> [   72.179618] nvme nvme1: I/O tag 24 (0018) QID 0 timeout, disable controller
> [   72.197176] nvme nvme0: Identify Controller failed (-4)
> [   72.203063] nvme nvme1: Identify Controller failed (-4)
> [   72.209237] nvme 0000:05:00.0: probe with driver nvme failed with error -5
> [   72.209336] nvme 0000:44:00.0: probe with driver nvme failed with error -5
> ...
> Timed out waiting for the udev queue to be empty.
> 
> According to the dmesg logs above, the IOVA for the v2 page table appears 
> incorrect and is not aligned with domain->geometry.aperture_end. Which
> requires domain->geometry.force_aperture = true; to be added at the
> appropriate location. Proabably here!

Yes! It got lost, thanks alot!

Jason

