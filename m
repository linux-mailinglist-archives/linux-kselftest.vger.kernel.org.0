Return-Path: <linux-kselftest+bounces-33124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD86AB8FF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2909D505B0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078E270EC5;
	Thu, 15 May 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aioOP3yy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B325D1E1;
	Thu, 15 May 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337015; cv=fail; b=Wv98b7B037lfOKk33mLW2VokU4PzoMVRAb0iH8yg7ZVP3iyYZzhMFtu88paUqUWd2Mx6OsbRmCGPVqZ731NDG9z1i5Jc9S30OX/Z+UkMWSEU3aIBClWoCxDeWhn0vjP7nRpF9B2WXOSjHK3P6BFUy+FS8F2DxYVgoErtDXAU93c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337015; c=relaxed/simple;
	bh=cW8mK8wStFiTIulsWTd54kEsKRDQUbdpebu5XRjQjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GDlHQGi2Ud9ldo7Z6NDnKeQ4uCXoDcQM8UZ88VvLNzfJk3UiCVLEY1Bki2+VftjWeKnOCK1W2WIjkmlmWs6xsVSol4RX5KBYE++h3exZjlAniKdmsIjhrF13ec7GUKIuaUTa00WXHD4Ho8N0+CkaEv+1cgZuZyBf4R7QSjHpTdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aioOP3yy; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1L4KdeJ5LHSLQyVWI1pcOeuVogD9DHm9d32TKfKvUWMCwYrUxwNKCPUyvAjTqiHFQD21gw5xfnI1B0F+IjcKCyjNbz1/N+ekPwVUlFXOG7tIPk3xdPlt4D/pzyKQCi31y/8sicrI/WvtmvrihfsBB8bg6hKvSJPM5LHNfuV/gU5ciHHGBj0a1m6Wi308jY8RMfnYfJOP0pL16s8kpxFnGOvo6h9sKEwqU1bdj1B9ZA16b+l6LH2G/eiRtPLfVFrCy9Pw4n7IRFXJ1TEArGWNpL3FVd92Y+I8m5Kilx5cmdd1PNJmShGCeaVmetSRuV4j95GJrUAITQcepzjmhXuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aESVqzf2DPtLQSA59MhfxUKHKSatZdLwyIBjZman3g=;
 b=tkPoPq6xjQoLne8tS6jl1A41EU+6THZCvRAvCvQOGT7URo8uzcSrfgg7lGzH60BInSsOBw81zwjuYmv/oaQR+NcYLET010cjVOulewn2q3FIQa42sPUhp7WA1+mztBY/phu6uz6FfcFV+6DcySCXz+R346P7gFi6jRryS+0dsL6LOEEcIB5zNUB3sJZPITt0suVwGmWTpakvyrLzv2MztwSOpFXH9rUXgWqwjJg48l5i0YNsPcnoE/9IbRfqMIaLwLgprNmOVyjsfh4+pnw8AeDMQibPRe5wmZqmKbftYA6Y52ZXLorhD63nTyYhBToTg/xu4zL4xF+Ny3fRDCltIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aESVqzf2DPtLQSA59MhfxUKHKSatZdLwyIBjZman3g=;
 b=aioOP3yyZnjD2HLnN66Z1BbivlBVh/mPkPEExYT7wkMxQ7EJeqeUkiCP3dD2TG+JM6CvS0sP/hl9InbCF77l2Wc0CLdifw1RFlgDleyIdnkYlp1y1Ugk5n3Z6Q7YW4siUxs16K9w2LWyVg7eODpRSpYtgxMRx4rQxg3FAGw+bvl68Fod7uhGCZvlH3T8fJ9UsrXpQtP3akfq/jfpt7qzjiSMPt43DoqP4iAB2AODtSDK0z4byA1eTBm71ErRIx2gkOdhcPx5Otss5JWAlslVPCNgaCVTSLkseov3eDcCBPHviUavR1lmV3gsSwE8keRxOvh1aIgYDMmVD/Hu4ikBcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 19:23:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 19:23:30 +0000
Date: Thu, 15 May 2025 16:23:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <20250515192329.GA613512@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
 <aCY31VOs62/OAaca@Asurada-Nvidia>
 <20250515185629.GS382960@nvidia.com>
 <aCY+rXsygxjHYRhK@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCY+rXsygxjHYRhK@Asurada-Nvidia>
X-ClientProxiedBy: BN8PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:408:80::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a87eca-5b96-4ff5-4a80-08dd93e5f9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtwaVSqp8eYEYPM6rFJ4JliyqmwmKpNz2OXQzIV0VkkezdAEs4yJrxGXtlnL?=
 =?us-ascii?Q?usR7BlVedpXpI+Rnq9KTu8LI+QLOVnoMKMtQTUmqhHNvp8MOpsZ4owOxEMHB?=
 =?us-ascii?Q?PIkGO0NQ9hVNhvI1bLI+VjZa0LWOyylAB5ci1AWUWtqUqMV/8VVurIviYcNF?=
 =?us-ascii?Q?pkQZzYyIvQdtVfaaK5CZIK83UzuVsuiiCinI1CfohkyvMwIv9GNM+OsR82FY?=
 =?us-ascii?Q?wmMYCOXqSARcky0X4kElT4fqEe9ZxFYQRCsZeYWp7qPzEgsApVIg6HbsLFzA?=
 =?us-ascii?Q?9FkCcT1/PjSTNDaBlRjZJ6MumqK/xHEjOnsyGNiMojZenvCJDbY5cmCYfAdr?=
 =?us-ascii?Q?GbpeJBZFj+gUlM7xCd9tyuEsgivpWLGO0OEzvy2e4B0lbgfQiJWdx6GQ08Li?=
 =?us-ascii?Q?CgnYJ59ftG3JQzKskXFNOEncoMIPW0CGqOAgpNB46G/IzS/tmxjud5MoA9BM?=
 =?us-ascii?Q?Bkhr138M3pBt5CrCTjKaRnjzNcVYmUyUxxuFXK4fgtAm08KIW318Di7GzGwm?=
 =?us-ascii?Q?BqumFjlo7XfEHcDq/5cd5Ud4b19NeSRqQ25hBR9nZx6z81quJA+jJoOunkc3?=
 =?us-ascii?Q?Ya2CJlIAy1P2MUcRW6B2lOrQVq3xx6E4/kjhA3jYRXiBeVxPxLm9+eeOpHvO?=
 =?us-ascii?Q?QiSMm6NCAx4QC9Y3Ukc/mjjg4NUku6Y3M2B6cZs8j0584H8mOLtjHmv2/0Vh?=
 =?us-ascii?Q?q9HsFrJ3JgugPkPfW7q7CuHT+ri6W3G+Cb97G85GWCBjiNaOklmCRUeMzdqz?=
 =?us-ascii?Q?lOpda8CQZFeEgiJ+haiILvKij3etvPkYi0osLMwapqTQjMwJ0pLH2CnWoJ79?=
 =?us-ascii?Q?4p/EF9unTXLEJNK3cxgDYPHjPQ1JE8HKgZMTlxajlfavfSqMgaQrAjNmGGAQ?=
 =?us-ascii?Q?MBnchAWB2mRpCM2rYnNS7jmWMaFdAYiymEjwycYfA0KAalaw1EpMbWvAEQct?=
 =?us-ascii?Q?tA5k7LdlXMDQI8VJv0ek9s8snOnmK9KfoIDHjLOxcU9u64QShRBLJz/yIje+?=
 =?us-ascii?Q?m/FdlwXiDfEUWChouzGq8zlq+k0C0RcpOcr7NrqDM9TRcVSrpbx+xwQUkpwg?=
 =?us-ascii?Q?MMHdsnzB/Fq+COijcXulBuvCnz8eJnk3FO1nqOK2hVmlFyPW+xJDvwPs5WwJ?=
 =?us-ascii?Q?3GuZLmyBTAIHiKRweE4ZhVjw/XESKBzVbihvSAuPvmNIw90qkaeQu8SCkFFq?=
 =?us-ascii?Q?fQUQYalU31j1dXLeVFJC606vJNjVcxcXC3AAOTPYvSqsNi5p+4CgHPi2qqaA?=
 =?us-ascii?Q?fUdm+q/m5ioE+0dJCo2ElAu6ODIrwHK+QP+G/Yj5B/aFUXoxGIEdNQMN3Zkr?=
 =?us-ascii?Q?SHQOkahj7Krbvr0vJ8aN9w+5kQn9+07u5tPxgrmI10ql5HIIuXpR2uSdy6HH?=
 =?us-ascii?Q?w18/8jcwXrbG+LopUpGg2K/O9SFtZa6cMHNEUOwaEAX18Fi4rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9ql+4LLxcotkFZyWmY3JDm/8rayYZPJ7zRBZsc3AFHVZGQ7tjfG99pE+hYc?=
 =?us-ascii?Q?xiV+nl6mWAmzIsoji68p09GFJxEN2BrBwdUzno9yCXGgbahYZ9PPhgXYTO5T?=
 =?us-ascii?Q?tH1m+IVHYGPmJzoXKbjDA5gEq59Z9+kLetOSc6J8U0MpJJkxmT1QqCDxtc8d?=
 =?us-ascii?Q?5sQtZyt2z8bsH+qUWYFuSgekvwzR7ueLksZaTJVcqf3LBpX2xwQJe37tZ8hR?=
 =?us-ascii?Q?OFxtmtip3JMdSd8EO6SVw7XEDbYdjut6fqczJof6VeLgdJDLNeWSmPsSAwVp?=
 =?us-ascii?Q?YqYCRVj9x91aiqyn6tgu8HN/NU6X1rCFbzrgQIEIyN26DOkHXS+GkQGxTmjr?=
 =?us-ascii?Q?yxEDOZRDT2bD3ddA7THoDTRydg5hI2C76ILBj+l+UGMg/KIYPOY7TmTFTKVm?=
 =?us-ascii?Q?maNk4hTjKkTvRIKSiPfXAfB16aeiiaHckLmyaPbz+5P6jmx+Pb08SMMavFv+?=
 =?us-ascii?Q?oeh5cJlS/X763Cfx5jSjWGoztpTxVkx2y+5dsiOkeA7MuaJ7ewU4//Aw78t0?=
 =?us-ascii?Q?amZe8Ecxcmhpye5hgchzoeubjEhydAes+dwnAOgVRcTHEhwcEijnj5fy6voi?=
 =?us-ascii?Q?Q0GsANYvTHR8tenjf4sylDj6n3axtAddA0ZuW8THS3JAD5sVHcHGgqMZN9Z2?=
 =?us-ascii?Q?yeFTzHLrOi0j9iNbl48of/X+4t/MfqzssFaf97nCfSgcA+y3qsuXBeJ1+R9e?=
 =?us-ascii?Q?DfGxBaPEqkMuAZ+tF1ynF0ia4KRmrEt1jogFdR+b6R5re+3UNknQfMAv3jWc?=
 =?us-ascii?Q?YLr1It8txcYIPRl0Af3o3vPhH0xvYBUj4QInoIrZjEa3ZqqsKs6bW1F2yZW8?=
 =?us-ascii?Q?gLzSrBQnrzfrZ8exnHjRHbHZNobpuIc+hiEdgJBnG0Oihlhkcw8GPD035A25?=
 =?us-ascii?Q?2znS0T+6m5JDDTew9eUzcCCcle+rpu79PZBIHkKSHVDpQrUzh/AIQm4pUpOS?=
 =?us-ascii?Q?Y9a+fPY++EjXL0ndd6nJ5Xforo8HsB/8Kue+4n0TWkui5Jb8ZtDkIxbDv8rb?=
 =?us-ascii?Q?Rk+Tdhmbbbj+C9cD19mOfePYTGcY1U7msRkIlMFN08GGaGonDsAJVMq+Zvuh?=
 =?us-ascii?Q?ntp8YBrttQwk/3bK+ffUBH/8ZqQX823A7cSRqOB9H0/tz0H3EFkYjbYMY8N4?=
 =?us-ascii?Q?kqZ9R6p30aOsR4xzs+mQYtRw3nB1AlgTG2Yhygw8JoLO8pND976AmwgnJc9n?=
 =?us-ascii?Q?s627w+N27qTxUlMVPzowshuPQ0grWzVEYiK1PyQN/TuU3usmIUgh3ADB04EN?=
 =?us-ascii?Q?wQvFS8VXXQIIbt2E0uTODpys27zScIZzOZtBCgI4IjQlmfTBL2ZGnt7z4dGM?=
 =?us-ascii?Q?uFR85nIzJG1REri11l+NDYT2Jn3ukq1rjm2MFHrjJ1x6Al0ELO39CSgdgfgM?=
 =?us-ascii?Q?3BEzUNeh3+8RF20MByH76I14Zi4rOxzNIIIlNsEQVuteUlmEbibF6HHY2rf9?=
 =?us-ascii?Q?IVMfZJ7SoZfWfVwj44wSG0PmBBa99cjJwE42IMZlsd8JXiop2Nv7lGd1PkT3?=
 =?us-ascii?Q?lWClW0z3tOhNrJocqo96Q0TQiYB2waiimcwYCtaXcYrOdlz3MRBp5fEuxoKe?=
 =?us-ascii?Q?9ZgTgp0+L90HvmidECW+qKkID6A8bb8V/TUVrSn4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a87eca-5b96-4ff5-4a80-08dd93e5f9f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:23:30.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuahjFcj3m/pp5dBnN8afVci6/+oG91M2BOhZJMRPylsF1GVaBKKhlp9ksw926uO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162

On Thu, May 15, 2025 at 12:21:17PM -0700, Nicolin Chen wrote:
> On Thu, May 15, 2025 at 03:56:29PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 15, 2025 at 11:52:05AM -0700, Nicolin Chen wrote:
> > > On Thu, May 15, 2025 at 02:17:06PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 08, 2025 at 08:02:39PM -0700, Nicolin Chen wrote:
> > > Should the first call return out_data_type=CMDQV while returning
> > > the arm_smmu_v3 hw_info data? Otherwise, VMM wouldn't know what
> > > to set in the input sub_data_type of the 2nd ioctl?
> > 
> > No, either set a flag in the smmu_v3 hw_info, as you were doing here,
> > or just have the vmm probe it. Given the VMM is likely to be told to
> > run in vCMDQ mode on the command line try-and-fail doesn't sound so
> > bad.
> > 
> > And I guess we don't need a "sub type" just a "requested type" where 0
> > means return the best one and non-zero means return a specific one or
> > fail with EOPNOTSUPP.
> 
> OK. I think this would work:
> hw_info (req_type=0)     => out_data_type=SMMU_V3, flags=HAS_CMDQV
> hw_info (req_type=CMDQV) => out_data_type=CMDQV,   flags=0

Yeah

> Or, would it be simpler by having a sub_data_uptr:
> hw_info => out_data_type=SMMU_V3, sub_data_type=CMDQV,
>            data_uptr=iommu_hw_info_arm_smmuv3,
> 	   sub_data_uptr=iommu_hw_info_tegra241_cmdqv
> ?

I think the former is simpler to code, you can just add the req_type
to the signatures and if the driver comes back with a type != req_type
the core code will return EOPNOTSUPP

Then just match the impl_ops for req_type in the arm driver.

Finally we end up with only one ioctl enum number space for the
types, which seems appealing.

Jason

