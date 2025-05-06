Return-Path: <linux-kselftest+bounces-32510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1202AAC4FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 15:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724C8524401
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B06280306;
	Tue,  6 May 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gVVRdNpm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6028003F;
	Tue,  6 May 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536337; cv=fail; b=o2MLLkuz1yDDU4KXA4hfNx59kIT62g/4rbRcvj3vYpRYuR/ETYRbqd2SSqDyxYtP510qijKdxwoI+gGIPK4ymPDOWMl5zqKIW9+zB7HfSC/SuDq24o/x+Wa8CFzzqGsIX7SngZTP1dWkSJ5VKGyPkQuHj2KuU0SpPGPfymb41NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536337; c=relaxed/simple;
	bh=EZH/Q89Ttcr1Ik1mIu4AqfPzbUs/HL5LN9qKi++Lv4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LUhtLsxBQiyYdGNiDYltRgnmYJa/zFCXO6eCSxK7TUBpalsnVH71tzpW2U5a/lT/0hE7xJztnnqetFmhqcwepH3/TclCzYzk/6cKYaxCiiaJCMW7MCbTnUD6jboo8gdOsEef0nGkXJ6psYrbu7vTPWbOUuu4oaD0GMnMzW+p9Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gVVRdNpm; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1Aqnt1lZ8cuvsArNT+g0ozdixcZgHx79Z2QYesIEuaJvXAZE9PV+pD8wKA2+TII1OjNfgB63g4liXkcph1uoAE4Dse1r4FdxHHNTGeZHkcfPaium603Hj6cUoSwByu+gfR1pt0s2puoxko0pp9CoPq3fxRo3zHCWU5L1xT4PyBFBw56kANIaylZ8y/QK7t5vQClR+CWSPYZFEV/b9DijIlqjRZFB0Rhcz8CqgSOZ9ZQlXQ1UIULjt8uImK1YVsGjNvU7jBgeRdEtGfZvRePqHi2Zw6tvIXnBVkm3JqWHKvyF40KDNjGSnjGvlNxceNVYBUKsQ7wPputVcMGQgfWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHsb5Biwc68+U++GicnF8cxYKzJZSutDx7YuhkYaUms=;
 b=NW9ZTEgEqQob7guwY5hNl+qF+SszrMJJdw2YBsd0lUm3LgjhL85+7QD8oBKkgQdGDWSlsIiIMDN0Pi+VaMzMXkcuXyz6/RBhTnopXWD7tRWPkoX2WYl+9pD5j2yLEJIlxQ1p/poScwW5Q+ekj4Vp9hn5Wqr/9GjMjoWhnDt0ARNzvdMXsEb6ib0flQKArNoF2kkVwOc3Tba11Bn4xmj5OR7A9zc9AWRPWzOTTKeU6AWtSS3OSt1PXC9XJthcBJIstZHBMX8jya2vvP/X16OObicxvnaX8gH1uJkxLhw1y0+2uC16GU27CoEmvkC5rkTuyDB2rAeZUHqHaglxUfndjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHsb5Biwc68+U++GicnF8cxYKzJZSutDx7YuhkYaUms=;
 b=gVVRdNpmGNIYiYCmn1AfzgyV+rDBBBBzTQ+vvMPFD/eYzt5Dl50RCS6WeDbm1DU5ztqBNCDKpSJVx5yAnAIi9UQtrJTS0/4XtGAhP0dCzOZNXtvyk7gkVDSVU/VblfpjB055p99dBvndnBbVGHjcBoxLMsWqIk80NSKmuCrx8Ung58VSzQZegOLC3O7772me3Qx1yItw2+CRigncPTRXIIeKVjoDEzLUK/tUEz6jyKt2BMso58cTDP936qht1d7+mpziLw8Ut9eWPVbJ05RpZ1973Rg3sIOo/9ll4HsAKdDKPMQprljm1M9v1cIspINDi5rh9Y616ohv9NE4qx9BGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 6 May
 2025 12:58:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:58:49 +0000
Date: Tue, 6 May 2025 09:58:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20250506125847.GA2260709@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
 <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBl5uLOFCntuIYYz@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:408:ff::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b953e42-c672-4477-6bd4-08dd8c9dbe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6JTpekw6oDICFcSg1EHlTfW7PaIWaODPfhVKWhfnSX2FGrvEpe5bVmZE7pqg?=
 =?us-ascii?Q?QS0I4B2DzxDtox/wdcVo5wbzVI1Wyp17R1MfRKcc1wYHrNsejh/IKDtlDmB9?=
 =?us-ascii?Q?tuWoO3L9zr0EvNgs0f5qHGWtMeGCELib/c+x3vfhMpNErhq8yylNqqhngq/9?=
 =?us-ascii?Q?DwVmQZA8IWb3Py25jpaT0VcrZPibhaKwuJxCf/C8x0yTT9WjuZB3lfNeMvaF?=
 =?us-ascii?Q?RgL427HSYtfHgkWJDI3me3ggJtyG+mdHPyGEbOV0n2Bmktemiz8EQ4JuRGwR?=
 =?us-ascii?Q?Z5kE3TDnaVA0DpeVPEAzeE7izrZlxjjhxlc3RAApEHwvBUnfBsxTuC4WTY8H?=
 =?us-ascii?Q?CrT5CVKxJw0cv+O1JGuIanEiRDlWIWf2SSpgVEe9eaXtame/s/XtjQ1ujMTY?=
 =?us-ascii?Q?jTr/l4U3IYdvbEGdPQQQbDk/AYoZdZScKzZuW8O6KrpKeW+uT6FPrxteSba/?=
 =?us-ascii?Q?O1wmuiK8qekWD4qT6Nj+NOoKcw6WOfRvFoBsIyw9zy8E0NFKiLtdHzoyhkYy?=
 =?us-ascii?Q?grX5fj+kJ/vgcXfvCl5Vb8wmkOEdzSG6gZmLZayL17e2HPBNnjim6s+xREP/?=
 =?us-ascii?Q?LVelhqRMPdD2DhKfU6tlsi5ItHshPRFn8gFsLDKZlEYi1XjIWCy/340Z951f?=
 =?us-ascii?Q?lXqgKrGsgROcswmFog5bLocqlS7tstt/7f2Gsnc4tN184IaeNjtbszAaj0QB?=
 =?us-ascii?Q?hlJYF37+bj4TLWmHr99UFa5EdrBs2kA7PP6xMCS0JHPAxbKMuwpZAnHoIMLE?=
 =?us-ascii?Q?ltTJHBia7D3uovSTMRuzID4taldVyMi0UVb7hs4mTwembEVkPgWfU5ZkjHXG?=
 =?us-ascii?Q?wrOpagHmDB2p1gAW75ynx8CY36u/GJmyr7+sHdcUhKGWebjSNKZCwQ0PETgj?=
 =?us-ascii?Q?LoRYfvPHxpC2fucsDPzrPfq7TW2w1CAg0vh2Bteh9Xp7+5jTA3VEqf48512R?=
 =?us-ascii?Q?vkoxCg1fKt9mG9Qdpr4Fw7+YXD4itMrG31Py3qJQw5S5ZM2cnIMcHGTtjBdq?=
 =?us-ascii?Q?/Oqe7M5XGCnD82OgcSfwzgJ6ftg2ZbOFbXILOMi4Yf8OXiVIicuA7vetfcpW?=
 =?us-ascii?Q?DxK+GSsZDi5LUMVe4cwM8B7TcSxU+XdxoMjxBYYF10WF3K6ihnEHliM9ViJf?=
 =?us-ascii?Q?k8UN+JP/lDhJm2k6VZkpPD8Rt8/edy4Vei97UM3zCuhAVmyRAzqrzQuvRTrq?=
 =?us-ascii?Q?5hJpqE4LJTb6h7Io88t3VjArREQkrqaNg4Dsogd6CGH7fzbz3Tv0zYdlBeD2?=
 =?us-ascii?Q?dXibBWViAKCkQHOVRk5Ecz7ANyvrfdJdGgHUlVfc1gGddnr7kvk7XpSRj60d?=
 =?us-ascii?Q?5lf5vRJXTHmf2jqSK66M+79qm1bn+zSnLq+Kx7J6G7/hKXW+PAwzFRZdRavK?=
 =?us-ascii?Q?3Z4+2ZaWTWEQ2bRXi46zJEH2+3Gi6h52ai7o7lvpHOZFRIo4uSlybnk/uuXa?=
 =?us-ascii?Q?DErozIszmjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPPFc+jrKdhhlGj9ghiTOwS9FD2KJz2+RSpTSLkrasbcz8CJlz03+WxA1wBX?=
 =?us-ascii?Q?oHFKxVlVCte0V5fTXIiulW50X91njTkiQ46JKFUUXG4IuYp6yEyxqRRpm+Dt?=
 =?us-ascii?Q?1H5BZf4USr2Eis0Q7g+OrUs8UQbqD1b6gx2mx+suy2Lhada9WrNvAZzk2jYA?=
 =?us-ascii?Q?Hv6ELFka9PKhaDjHJpGg8blHmREk91EB1AECBSPZNGdmZ5Vtc/WZ1SZ6OytC?=
 =?us-ascii?Q?O9jDmh6BPJrjTbtPb4B0ML0zNec8+IfRzb78iuWEz+xA0OrO3SnR/6ulQ0Dd?=
 =?us-ascii?Q?rkwSC2oJPBiX36B0zXQjbtdzz9kzcgK/k1UsUSV7CHEyPbZIalPLC4fs/ONo?=
 =?us-ascii?Q?dxab7k9ooJFnyGRY6k4dwXVwkS+jZkACnSIx+StDFnJtg9jDJGdpJnT2zfh7?=
 =?us-ascii?Q?dgQZ11wlEwjX+d9VZlqY6o9zmyKPtgVYVjWwE+2HKG8vbwm9Aa/hgvHRTTdO?=
 =?us-ascii?Q?w9xfAgNsbSE58Qtfc1jYw3CQvaczfa4BkPCFVTFpXvL9iZHTEdreMt1ZXy5v?=
 =?us-ascii?Q?zIrEV39NcFW9rZirGnvwHsHNc9L87AbW88pw3WWOAN+1YAyXP4RnPQSQiOtP?=
 =?us-ascii?Q?DPni8bY8ZA5yyMXpiorzpXypk6p9eqOlpsSNqMGgdDH8z41mYc2pgFMwhFJc?=
 =?us-ascii?Q?YAZ55TaerYsT+vesxITh703vCWtBvs99Sokre4HLCgtPJdH5inLY18A3lmIg?=
 =?us-ascii?Q?69CPyoRScAfu7MGEon63JlEAOa/EH+Su6dsrdlfJzkDePrCjDEHo17Wwi93n?=
 =?us-ascii?Q?GDvC+YJHU3lQscmZsad/pJ6fvDHQ10bIeNzOoz2VrvdzitcO1fGjTk23RWXj?=
 =?us-ascii?Q?YeVSsMBr7AWjxNnBFFWZPcNf/Su75G6oc5KqnhO31wpIuy6IggV2cyG/aI41?=
 =?us-ascii?Q?vdYFMkKuXA1gMHer4BmrjWPr3YuSRqYvGtojW9nVaaojgcI58HC91Gsqv9QY?=
 =?us-ascii?Q?5mTCRzwD4Cfn3zFnMP1s85XZXDcEawHsZ5yYJ6YYvcJITbz55EoINEPwQLSB?=
 =?us-ascii?Q?igPLuJbD6I2BornIlUWoYXPWoBeAV2i0l7u2Vh1g/DSajcU57ifLpRsZxE+X?=
 =?us-ascii?Q?Pi+dGNrqZlORHQXYUAFw+LfF1oAafsDcusn89bW8HFeMgBOdlXF2LFsZ4ne9?=
 =?us-ascii?Q?NnfbZ2LjiTQ8Z2uXON74JNFefoo/9IzGDIfnhLH2yUb7TFNRMGsA6U81PQKs?=
 =?us-ascii?Q?F6Q/Fz04LBQjJ1B1965YuqvOHXipmLxy0LS15rYcrbTkj0CPfrCj2WW0wmG3?=
 =?us-ascii?Q?FXwrAHoYVXuA4E+UDC297Qy2B12RCH3WFFmaCCIu9po4gjg06Z7QusJyl0Ht?=
 =?us-ascii?Q?50gKQgJvlVb6PiCtvnlXEbZlWdumGWyjzNb2my0GM5dAfuGGMckjzsgYjQCE?=
 =?us-ascii?Q?9BhP2Fl3B09rMkaermguaccsmJRwtE28Rsfqc9om3FDHfPkbtVJSbyy/gFBD?=
 =?us-ascii?Q?J5SUVWHjvySOItyPZkrBs711DChFkY7ljaoR0pfYBYxykegfIwxbsAUtaC62?=
 =?us-ascii?Q?zpqHd+PxGiS0eFoP0MbSEKl7EZQTtl28VynwdfG4dzFjNDzdZ8Fm/V7WIKCT?=
 =?us-ascii?Q?FA7hXdpWIRWfETGBRKYDcHwZyA680PP+LvCA89n/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b953e42-c672-4477-6bd4-08dd8c9dbe45
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:58:48.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDfNvopeChXPOQ2q+06yHBbnkHuux8IJbmNnO5I1OETc8embAysIiw4kaio9Z0vN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

On Mon, May 05, 2025 at 07:53:44PM -0700, Nicolin Chen wrote:
> On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
> > 
> > > > ... and I just hit a problem with it - this is basically guest BDFn
> > > > and it works as long as I'm hotplugging the TEE-IO VF into an SNP VM
> > > > but does not when I pass through via the QEMU cmdline - bus numbers
> > > > are not assigned yet. So I have to postpone the vdevice allocation
> > > > till run time, did I miss something here? Thanks,
> > > 
> > > I have a similar case with QEMU ARM64's VM: so vDEVICE on ARM is
> > > allocated at runtime as well because the BDF number isn't ready
> > > at the boot time.
> > 
> > Oh that's ugly then.. So you'll need to add some kind of 'modify
> > sid/bdf' operation I think.
> 
> But the initial vDEVICE would be still unusable. Its BDF number is
> literally 0 in my case. It can't be used for SID-based invalidation
> nor the reverse vSID lookup for fault injection..

That's fine, that is actually what it is in the vPCI topology. Until
the bus numbers are assigned at least.

So you'd have SID conflicts in the kernel, just pick the first one or
something until it gets sorted out.

> > The bus numbers can be reassigned at any time on the fly by the guest
> > by reprogramming the PCI hierarchy.
> 
> Yes. If we take some aggressive use case into account, where its
> BDF number could change multiple times, I think it's natural for
> VMM to simply destroy the previous vDEVICE and allocate a new one
> with a new BDF number, right?

We should not destroy the vdevice for something like that. In a CC
case that would unplug it from the VM which is not right.

Jason

