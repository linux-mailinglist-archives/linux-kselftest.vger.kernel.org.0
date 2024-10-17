Return-Path: <linux-kselftest+bounces-20026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8939A2C70
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EF8B25D94
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B162194BD;
	Thu, 17 Oct 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gr8oWzbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB821948B;
	Thu, 17 Oct 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190854; cv=fail; b=UqlcBKgxgxmsUIATxIC42y8gCuVMIMsi4td9g7/jj3nOu0soXDVlMJrhYKH/fEjQGwL30g6wPk4Q/TQHtIA+uwzD5G4fhB3g8SEanyf3uqfRw2syYzRS3yt22t09Dq2pM7S5vsf8qNRPoJUmbAqwCwgnMnck1b4cvyyE87yY3mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190854; c=relaxed/simple;
	bh=YKTrwBRkgClWTQYIWl/hD/GDVmoLizAJx1RKzowi/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fssgscrGnx5okeNLYXIetSHcm9B5l/uiHnzv7ZqKpsFWHA8cY933KNFU/ejUXO303GZ+3I+GStVzVDldA2AQLbT5nGF3vu2PH115htmufp4Hdpqz+nVQjWpgE+gKbXzGYD4o+OQwAjTHOGU+dYS2GqeUjPkT+WLbHAwpmImIFfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gr8oWzbu; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA9rRonnPNhC67cS0TS+Xn/McrxsQvG3Y06A3UjtNzkZ7ijWtWJfUZpkQXff+NvhgcCZUsgWf5EB1pR89haiYUPk4EvhOzxCun0FII89khQSvtz3iUEG731ihZcf1l+PFtgoSf88g0DzZ55K2QaCs1pk6mmisdXiDPgHHcnF5mtLaR7dvQ7hstA1z+4NJ0/Osg6YAVZySQOhRhaH92YfNEZaUAkuhwRsmNoi1t5t1MKIJGYMermYBS+VMo15w/rAoM16pJ1hx4GnvnCVWeFJbpyoAtULfiCQamDnayb/Qi71SQ6HVKq8OwZrXRzGiLkHgKB84LteKJf/n0oBBerQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkBkxMYgi2HhsdNJ/2rtEouTXffbrCr08XqnmpHLgVA=;
 b=lr/QiGklwJV60edv2Et0FOh/xB1Zlou9O2HaYAcsGqiBFnogj3bFY3hyqF5bfF9XQy2wTQU8DOqzMMYtOvUXO15/1Pl4+V/nPFHeUq6olOyQYYlhTBeW+5yUn5iTpEG3jfIK21tQCc9KaMuoC+kj3omZlKtFrDRITxfpmyAaPR2XR/Vs/r6o74Z47JG533VjZNQYzMw304y2huZmQ2fHhoseG7yPwDIkuz46B3p+OhGpcidArD2PbxIj0ypVZr5veiUNfdW4muo5Vfo7oyIBQhmdmqPMxW5ii8GixNE4CtHsLH+8SFmB8NTNAf/pyS2Yk5Op7syBH7MfI2eQ+aOt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkBkxMYgi2HhsdNJ/2rtEouTXffbrCr08XqnmpHLgVA=;
 b=Gr8oWzbudYf8xEANEsKp0rzvo2IIH3P7RMKm8MyDL0ghxND/E5yMXZ3prbmIc9SbJpSuxnmIyRqI5wJeVNnor7/1QXMdNa72dw2+8orzCaDsz0GYZlt2h8sUeCOJaA3Jw1WXYlIA0j31dbKE4LkE6VSvaijvMX+iw4ZsdbLUuNDcvvjpTS9PYf1E7B892sNGWsTeKTacB5bwFd2KS8BHk+YBxWZsMZWRmqPvsf8+EyOEGfit3cfSqBFS0dSor22B9lRdDvJQgzZBAfWjcLUlkPD6UjApEo5s5JYp0J2gzYAtXXGC68TrN2Gibo1WkSxaj1NfFfrWKMeEX1Xvdoiilg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 18:47:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:47:30 +0000
Date: Thu, 17 Oct 2024 15:47:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/16] iommufd/viommu: Add a default_viommu_ops for
 IOMMU_VIOMMU_TYPE_DEFAULT
Message-ID: <20241017184729.GR3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <b7acc7b61f1ffa156d5922a17e3974f41adb964b.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7acc7b61f1ffa156d5922a17e3974f41adb964b.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 754a1961-f4b3-41ac-9684-08dceedc275e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwyE7WKHNHeuHFbS1mxwWHFdyUnFWm8Qe4HfKfe1mq9ebSAiLOiJdm7YwFKv?=
 =?us-ascii?Q?o4NGIx4LIWxUW6Z0ynl3Xt+EGD6FmaRG6dz41HtL7rVALLjIJRdsJxXYnSqT?=
 =?us-ascii?Q?gXffbuFAgvG7Y355h4Kj2Niybkbmj9L0NqluyJSteW0/UhpWhCJCaSUEfAYR?=
 =?us-ascii?Q?/XD2/eraQKGU3LlIt80kJ8oFHf2+h7YeS4ZZ9SvhsetkePVT/Re3PhG/beUx?=
 =?us-ascii?Q?K0pqK+214vncI29dbowqa2o9Bx+E2vJjGyHoKPzmn71yKSzuZTO2+UA2RqGm?=
 =?us-ascii?Q?FqQY/uY0JhJQQV7KWB6l11yZwt1jxkSq/6BnwQSgeYUZyMFaCHVj0fFbBPQg?=
 =?us-ascii?Q?kgOqDKpkItR4WAT/WnNaMyjNDZQuy2md4Vs6EKs2KwknIFYlSG3Ak7uESrpf?=
 =?us-ascii?Q?pv8wMHDemoo6HgU2XZwqR1H51H72J+zTk2w7IQZpMyhu9R4o4/GHu3L9Qbx0?=
 =?us-ascii?Q?RY2XYGHTxxpuw5zTAFWcICBe6dylG3x63YR2Q81KuFN1yBPRplCpG+kC4MFe?=
 =?us-ascii?Q?NIJfvqZhJen4PhGPReNTUn7TiVfgnsfJCrzMY9YDqJQCpsxRAl8Wqlc2ZALG?=
 =?us-ascii?Q?J3D0ccQ+YdtAvfP4u0DFsKC7uHjlilXPNpiZQ/KG76n0tiOSWrNDq1Gyqv0a?=
 =?us-ascii?Q?MDyvz3NE1Asdsu2OEBo/giVkxkfcM7nIPoIIM873hXu7hs+akIq5RiePKyd7?=
 =?us-ascii?Q?sHeKDof8bN/WBI3NOOEWzsFNLJ+rFAeOrxQfvR7VTf9qD4MA9KItcDNGCVWq?=
 =?us-ascii?Q?/U8m3rusv4G4ZeOMYfuUsiApa0iXjJBi5UKJHyfOblK/JpSiT5gLZYofo1lX?=
 =?us-ascii?Q?UmDAI1fqOHaKwmOLXC8/YR5dGKsYdodChCR9LDntwNZMlQxgNGxSYYjhj2EI?=
 =?us-ascii?Q?JIB/rjG0yorFbwnR8jcB7IudITH9OnRpGpMhMRFb2Euis/Vowh0P8bNL0utP?=
 =?us-ascii?Q?DJEZYZOMrhNN1DOvp10H/dA+no3x7fV6USNNL1yWxhg9UCHgXX41agrXJUoD?=
 =?us-ascii?Q?5MNznQuLVDk4o3llxUGPFLUD3rc5QBxTAyqQO8Cyf3a2XbJ3UJjmVJ2uHVxQ?=
 =?us-ascii?Q?DDc002JIlz+BcauKg2S+iAELpUIng4XRxCL2YJ3EyL80FDGvkUX91O/6QkJ8?=
 =?us-ascii?Q?vJoSUebljZhcqQMg7JH+1Zlsw7z8Nq6P3X5f6AEhSF5/4kfU6pC81frqluJn?=
 =?us-ascii?Q?55Taq0i9VaUgYS8UdEZLpcZkBsItvHsUB/UMfAoUOhIY0GNDtRKXxUK/ZBE7?=
 =?us-ascii?Q?TdD07pP/5FgLN05aM8ua8VAbAPArbl93WboMgPG+mtAudoHNudv0vQzK/OmY?=
 =?us-ascii?Q?Bc0rb5zzmwe469z6QWJk1urI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t4oe7uok67LGZ34xrkJfqd/Md89kxxdGq29WQ2oEpp4fYyTulrIRf4pmTUbD?=
 =?us-ascii?Q?7Kr7uLcIrpbD2ebZCvkQ3Z7amIF85CO9vUoro5Q6bMGqulsL6au6YLUA3Yvw?=
 =?us-ascii?Q?8+hx1T4jJoiV4GYtHLvFbKh+5qLsVTEfp0OG1K52LayXKcynvLOisbFN7dn0?=
 =?us-ascii?Q?V0g+biN20db8C4tyKE0wo4bvOwcFv5LsbNqMOBwb9wQlgLg+d2YXQ6CG+VKE?=
 =?us-ascii?Q?M3GW7xPZ4zFpH6j9Ts3R9sz+MDVheaPN1Vr9vYKOUfOB/ycWekYnMMDaYe84?=
 =?us-ascii?Q?hdVb68BpEo82g7NIEmksDXahzzXnl+7wGBuQKGDvseWdCpUWRfFrPMnKzSjB?=
 =?us-ascii?Q?uoBaTTwqYbItnd7fvTX+OdfOvvJXnc3NatbTWcragQOkMlKsYeqytM1l8wiC?=
 =?us-ascii?Q?GHsY6n71aaxTiWz5RtrEg4VL3x5GYcC6OjWdfeJcqj0YppbXU2vtmXXb8SWP?=
 =?us-ascii?Q?auCFqpEHsFgAyVvBT6ik5HOS9e0Pgr1v6b22UJ45OG3dZItjsQ6GuKOvNsnn?=
 =?us-ascii?Q?zQeXMLy0+2FRYMmB1CR2D7Hux8xURU4dotwF1syWFlWCShhyNQYFarlwC7Dq?=
 =?us-ascii?Q?HR+Kb96xfDi1UGLmzrRIcHiJzM4MuM5djs5Wp+KyK4qrob6VaEZJEYrIjRH7?=
 =?us-ascii?Q?myPmDEf2rTGr2CmmQoJge7TPOvL4wbWlc/3ILFIx39bpR3E9jfEgqmjdHZwc?=
 =?us-ascii?Q?DvaysQwH8FaaLGeRGTy2WqSFSGBd7UVL+cCuFizuMASGRcW3QEl5xrC4TvSp?=
 =?us-ascii?Q?yeGSej+bFKX78zDL0Pkz996NhHuqDPV6qlMTF2XtSmP5G+CfwHipmgvh7Gi4?=
 =?us-ascii?Q?kj0YtHVA28EM1hHQEJBCvx0VQeQij5d2YbmO5l+Fs6+3l+fQExFnqhk1O4HE?=
 =?us-ascii?Q?xwHZytTS/lDDOXHf+5PGuDx+ba9S50dQCfSFCrsYVesgfh1xZpFNLz1+MFAf?=
 =?us-ascii?Q?2i6IDQtUQedyyzrzqYlfdJzgWJE/7iTIwEW6s/Gi6ui2mgfIiMt+ymccL71x?=
 =?us-ascii?Q?JBQmTWJEkcUnO2+VuUN3sXy04biw4TBy/1bsqraO/yiOXVlxiFIoInPYAGbp?=
 =?us-ascii?Q?MnFFMBf3ohIIUcpUeZWRwvW0uQyKoqLo/FgDDw7fT5UyEjkbJ2qZ8a2B0QPL?=
 =?us-ascii?Q?YvGd6fU12tRJmlAczhFDlKF2ZkU9OWSKveK25Txgfq+uLHV7x0cyOMMsAaa5?=
 =?us-ascii?Q?owe4rIpoWWPR9KZQ4ZkYDLCxqFto7gz878cBIvNu42s61PGkRXEj/NQOg/P2?=
 =?us-ascii?Q?uR0cuP+8mNrdc2mRK7ug1qronKvrSXgtn/hPGUS2xsA+pHIm1f/Ov8Z6BCqN?=
 =?us-ascii?Q?02SOqwHSfmWliBSvaDTh/gHLGacz90e27CffLIWw5jPoeKvfOTx5VoqrHVLO?=
 =?us-ascii?Q?IFFD0zL9HYZ9pXzrzql2md3ZUaldv4su3jn4u+PSOk8DWW5UUsHvNEqfF1ji?=
 =?us-ascii?Q?zPZhkUkhUiL5JOFj/RvLlQN7dRAtUK6uAunTZKRgHbSj011ibDaU8yQdg5SV?=
 =?us-ascii?Q?fjdA4WmeuODDUHp7wDwrgoiVfUWv0OmHO09Qb4iWdEIAcJWWrUw5qn6RQNnY?=
 =?us-ascii?Q?hGx1/1/4yTjTtMbiWpA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754a1961-f4b3-41ac-9684-08dceedc275e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:47:30.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BatfQqdM4ZY3k9xfJiFPf/AVD1tC0w5LginsqQT0c+dEeqCJDBVIWzFUDxz03SUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678

On Wed, Oct 09, 2024 at 09:38:14AM -0700, Nicolin Chen wrote:
> An IOMMU_VIOMMU_TYPE_DEFAULT doesn't need a free() op since the core can
> free everything in the destroy(). Now with the new vDEVICE structure, it
> might want to allocate its own vDEVICEs.
> 
> Add a default_viommu_ops for driver to hook ops for default vIOMMUs.

Why? arm_smmu is now creating its own viommu object, so who will use
this?

Do we have any use for the default mode? It is already a bit
confusing, can we just drop it?

Jason

