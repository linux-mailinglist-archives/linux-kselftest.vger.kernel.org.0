Return-Path: <linux-kselftest+bounces-32409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5AAA9A1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E1D16C60E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0826A0B0;
	Mon,  5 May 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jbx7q6/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F6264A89;
	Mon,  5 May 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464897; cv=fail; b=gzHlR/1TodgoCGqR8LVzpUjhi6+qwqy2sC88TLNNohXsPSJc8HjwjAIZSyN+JlRyrGC3KXKkJ4ozYVcq1v9j8hyeqtbOwRo+lb697ibCVQU1GxH28ufjrV1QTydi02+Ew3j6rTTeMqqGujk7Hl4yoW4jRTW7zeHIQ9k7kuu4i7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464897; c=relaxed/simple;
	bh=dvSrSZ9MlZi2Zy7NhUBgKUEWtoDGDZ0/cnM0cqyOk3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TS13HluCuVlYu5K2PsVo27JoAArnxS9bHvBkR0v0dG75TJ1KaIo5JhDhYAM/DbN1er0EVTxqKJJksvTY1Xbx4Ochmwesd/XZask5ejgzssFlm7SQyuC8+jG5LI805FG2MtGQr9lrJbhD8cCaeQdBsdtaBoOEX9sT62Ks83OyUPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jbx7q6/t; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAXn1Mng0pD61UgJImhD6x97R1voRJGFfeGnG63smK6SmY4CZa/SkdXvv6eOZX8egXNyTzm5OEqlrND9Zq+UB1g06psGPLE49CYpqNMvcwExno+pQvMB4jMlcXnCft70rtXHZmjxTq4FsThCQJiQ5SrqG68tip81urCtZ6aVRDlYeT65YIAtsmVw01HzB0wT7jZyqddm924cjwl8ZOMahyyJULrLTqs4V/uWVXbNMctWNIA9a9lMq3iLSvCp7AF9InkgXxDLqZ2iMUM2PS4yInR5nO+MxIqchrf3M4lw/PBiY+xNt++7KSFHb4Kdmg07LUjgSAc1tMiBmSTCqzz3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeTZHRXMBCLGTV32EXeNw/lBCJIEsbnPO23PBvcLozU=;
 b=lEnSwZRwDKgwD/mKAoDqRSdB0/Cbog/+cDT+K2ZMHEMOnbvMPubxm5Wz2LCwpA4v+G4T5zuDKCMsWfhCZWeK6zef14J1SodF7I3py7IPjZeOwVs+32L4u/rNYBNGr6DieRAYXY/JMN/ZeSrGD/6CMgUu6kUFsQwzpwtBDL7dASlz9N9NRheutRqp0QsFrQdrmcQsu0194bNoTCKm8LreNkwqHjSDKuG5RZtWBCOXwC2HtyEsfEz75Ndi4Bh2kxWZjNXg9etnmym0lFFJ1YyE3z+QAJG8FZaok5yAlLPyAKZCzHe4+ORRgKFQj/FPA0uxvj9zeQSp3up0GPvZ/JMkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeTZHRXMBCLGTV32EXeNw/lBCJIEsbnPO23PBvcLozU=;
 b=Jbx7q6/t7bKovx098xxappXjblGeC81CTymtA9/NaZEewuF0leW3ldav3TvpESagRytGnGahCOUYJpfJd+mytoWGPfR9f/CQWhgi9Z4wsy6tFbkpRMNug14945zBlNYUPppFYNyHganwmTOhC40iIBkgcNjNqFLFVhtww2juVo3j44C1f1TGEE+n3/lVzZgQKbfm6yKTyFyNy1rYHvLXWqDbt/RoknOWO3YBI84EQ13WmvOTuvYrR7RMTYmk84afVu9b0lt1xqSNvwcgFJaDaDCysUClXbwlnIuTaXqYmAUZyQPzPgAazPn3c6tkEXW+Iw1vNC/7Xfonm7302vymHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 17:08:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 17:08:10 +0000
Date: Mon, 5 May 2025 14:08:07 -0300
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
Message-ID: <20250505170807.GP2260709@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b867192-3905-4517-5d49-08dd8bf769be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KBqZ49QBTJl2XQMLDDR/0OM87m7ZH13oSdZYCTFrLDrZreTW9P4Q4Ds9GfSt?=
 =?us-ascii?Q?yH+HXtV40nP3/fXIlYFHlKyT4JXUT9EQwXVaICcmlASpN1RfavpMLy1HANYo?=
 =?us-ascii?Q?35zjAEpaXXiG7csTrJZU+fv22ldBX1lLfjG7mJQ3ZBifrTpyx5GlmTy/hkZ2?=
 =?us-ascii?Q?bkd+xJk/j1Rer25Ts+60jfHGZ4v8KeNhLaR3SXtQixDKyj41YmQQop+/shZ5?=
 =?us-ascii?Q?ai7jJcL9oez5aO7+NN25MOHNQn6wTw+cQVvWGoEcxWkP7rQ2Wc4t6TmAxlS/?=
 =?us-ascii?Q?4L8OrM0w0Tz2Dk/o5uP2fYcqz9PC1qwBEjyGiABzyPSvf45RSmJo93Gbgt/6?=
 =?us-ascii?Q?0HAMLxZMBS/wgD9fcI49ceRakwpfuwMpfrmqj9LDjsfVV5NR0L0tefJY8JRo?=
 =?us-ascii?Q?7STDYzfOrsCo4fcZqs84ZFfv5YB49nK7VV0jm5LGUU2yCu5dtMj1xmvLLo9f?=
 =?us-ascii?Q?/yy21PQV7JaMw7YYlg4023fb+SGVlwnL3uRLCbTpyEj8PNYPU72bQ04N1Ay7?=
 =?us-ascii?Q?gjj7nTkINGjh9fdg72fPrgb02knaXqDeMpj1BbEY+pdGSKtMs9ExwKFJiKSX?=
 =?us-ascii?Q?+EdYabwFfKSQTkrNytTNxwPlmOQAdN+N+ChYMzrgoRBqsNYw9+jiksDebai8?=
 =?us-ascii?Q?3prG3+R+S0ilC0g9eH4J+9pq74uNBN3jMVqQ2coRTYzqb+XbwHlx8/DrzcQO?=
 =?us-ascii?Q?gzBOF3FapEiNyj+6IOXHYaZJUqov5O6yv8gSjrrxfQKaNuLrnHTsmHnBjEx4?=
 =?us-ascii?Q?T9Aon8leFc1AaLGPIOkD6PjsW+/T1dVdYtm+KGiqOhABet+/TweNVU6Gel7T?=
 =?us-ascii?Q?LTeFVm4fdFcxZtOZJ1zkE35BaaHpGQ8JY91YrWA4ytXxWzGsU8YZGWA591rR?=
 =?us-ascii?Q?QPn577yRzeEjeYVQLVM9lnW5UwskJRooGZce49nqtICRipTWxrEe7A+2tyz8?=
 =?us-ascii?Q?wdB+lYTyL3DO4Ay1JFRjJikl51BtgpDXr0GpAUBvfD5R4GzCXUienWR2liIR?=
 =?us-ascii?Q?qYe4B/KJjT+HYzPP/dUyDUXtzA2yD4UNvCzxjHq8dXehAbN0pEbDNRolclT5?=
 =?us-ascii?Q?bkrlqPJwpRrwz52oTma4Mnw7ZIL2xDMTR6ZZoVCimVFj06dGH22xo5zWvsZ5?=
 =?us-ascii?Q?xv52RA63YoZnJaDXFm7NyRbG0HnoQ08R62dEvCeMFwOrnwWtM7izmZaF3dzM?=
 =?us-ascii?Q?Ik45/vTfDXIn++tqqMsH8rEd7DxsE1/zLnoLfMzYPwdEVgDAG+e0htXFpgQG?=
 =?us-ascii?Q?9sBNSfevptoMiRWvYRhY39gOthKQlz6AVii3ibzdJ6KfSyR+pQ3opT4DjsAX?=
 =?us-ascii?Q?8mFSV2HyiKg6v9WUdhnVjyD/uNA3zjNqX93SZtHXfUBSFp/bb2sMhftoe10v?=
 =?us-ascii?Q?92/x1shqc9Q7p8XTM/OLjX4q0DIIhsHGu5/70FbdkT2AwuXU16ptgxvgGIca?=
 =?us-ascii?Q?QsgJ4DIuwLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAk7H4e98Gw1JwdxEZ/HeCtGsbHb1H9QhTU9Fgvzf+MxavVd5R4oJcZ0A5uN?=
 =?us-ascii?Q?9E/tF+P6HdbwpSqYwX78Wq1I78GtzlRytJYBSMP3NRatB0pfT/rchBTo7PZn?=
 =?us-ascii?Q?3YdVfQBbpdKiJabBe+hTQSK7ne8voYfnA6Ck7IYNR8mCDyXuPGYSP9EhZyta?=
 =?us-ascii?Q?r73Yt8CS/mN+uSGxoLg+NdcwvRqCb+zbI2geCjCUyTbn4bhki3CtFpv10Bs+?=
 =?us-ascii?Q?SAN7hMf6aFYhsxFGAvqNKlgHsnUJWIV0R7aIwNRQdIMJmv47Kztxn+45RLDP?=
 =?us-ascii?Q?Juud3sEl9+84HKs3IIYknfT7ycvcH5A76H2bqCaQ8dLthaU9ET1TNBF1psnl?=
 =?us-ascii?Q?GJAHckB9Pj19Smify/Cdmf9NPiW/cGCg0la/r4FeUDrvOQy6hsMXcgQQ2biH?=
 =?us-ascii?Q?GoLep5IhnpwMHyIRe7/wHsIAWKYZ6XKMefs+B35ouQKiLcfLOasZVRonOdT2?=
 =?us-ascii?Q?fBCMQjuZsXe2ubP0eervb23dLZ00ZSbLbY80SfmrxmZ/xO1SRl7Y9k0ERyvN?=
 =?us-ascii?Q?1bQ++hU48Ng5u+RwC7eiYHK9RE+Gi1l0MTyUlbvWgOcZp8UVpznCBHBhSAOl?=
 =?us-ascii?Q?4YM9xAiBIR3wclW46pKyW75+EkzEL5v+swUpHgliMy5vBMRVS2QLc+AnqAeK?=
 =?us-ascii?Q?CL/5UlU6CJDDEj3UDOjA1BApK9TPnUlngEuXizLDjboCjWmXBxQ52VpeVl0l?=
 =?us-ascii?Q?bBFot/rbKLJsaSmG8y+yx+Nb3KtlZfPpyGLi1vvm2u7b+FOrg2bHHMxb/uSe?=
 =?us-ascii?Q?FwaxMsEb55eltCgGHQH6K1wvl4JgqjvIDsShTZwVPRFMYBwu75GY53w6QV2L?=
 =?us-ascii?Q?gGS4oxvfcfYtTXSQF+ukQygrnx4IVCH7M4A638ziAIvVjaHSMkgcqRYvzAAy?=
 =?us-ascii?Q?Q6A+I3Ew7kycLLzAZLEH+DtijfrWHTwKW/g4POgBnrdJnOSkuzlYWO2Qu+H8?=
 =?us-ascii?Q?9uSMUMYnIK9+EMgvdVreOBkWYhb7pJ8iFkbq/LQEWtYQkX2q9fsPvQAqRIKQ?=
 =?us-ascii?Q?Oq/yfAI6FOGEsKlIv9so7jy6mujsZ6zxIoeAa70HGWYn9VrIoBaTthz2Tfm2?=
 =?us-ascii?Q?jSxFOed+ZrmbMZnezqa96HiLl2FNvPdenOYV3oIGslTr2MFkWuVULwGlWBPa?=
 =?us-ascii?Q?o2CmEZBbh8LtRhE/Pq6JsSQlA+Dnw/UX59132mxANLekFSp2gq5HBawAx4XH?=
 =?us-ascii?Q?8q/tcIOpSXJ6SEbygVZ/fNlZRjR4JaZbKALT1ebUVkg5bx21xErUEB2/dI4k?=
 =?us-ascii?Q?SeHynxGmmfXiqIQCdYDhCYA0nFYbZIGbAOIrvg0H98KLTWujw4tw5LNF91xk?=
 =?us-ascii?Q?jQyrzhkdSh9MEi/m78j5Ohv5FYE5REJhg7O5uKSJsUU8kz4npHEQ0MP6Tn5R?=
 =?us-ascii?Q?4NKwmDAEiHv7u/bAy+hqE2aTJHPIOCs7vWvpcK+bg40q0iu144feTk9yBwP3?=
 =?us-ascii?Q?11GuCCNrWXarP+0rPcRWAnOPPKuoTN18FoJjKXkGPK4NTxMDyUd4Sp4oUiPd?=
 =?us-ascii?Q?JxRKs9n7RIwbq2jI3Gv1vKWt71+TWWXnL4tLO+Dq0PwlJ1jAxPq+Vn4vr7cN?=
 =?us-ascii?Q?w2wDbSphtuN9asi9PMAT9cXH2wGgk7sdwbOJ4yVn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b867192-3905-4517-5d49-08dd8bf769be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:08:10.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYtc+XXUBJcG1fcTl81/E/baRvJeE67yy3Wx8tVJ07lOYNfAmU0L4H5TzuMUcpCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:

> > ... and I just hit a problem with it - this is basically guest BDFn
> > and it works as long as I'm hotplugging the TEE-IO VF into an SNP VM
> > but does not when I pass through via the QEMU cmdline - bus numbers
> > are not assigned yet. So I have to postpone the vdevice allocation
> > till run time, did I miss something here? Thanks,
> 
> I have a similar case with QEMU ARM64's VM: so vDEVICE on ARM is
> allocated at runtime as well because the BDF number isn't ready
> at the boot time.

Oh that's ugly then.. So you'll need to add some kind of 'modify
sid/bdf' operation I think.

The bus numbers can be reassigned at any time on the fly by the guest
by reprogramming the PCI hierarchy.

Jason

