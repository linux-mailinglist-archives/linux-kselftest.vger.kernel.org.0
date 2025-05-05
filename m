Return-Path: <linux-kselftest+bounces-32353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5596AA9569
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551AA3A682D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734CB2505D6;
	Mon,  5 May 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oL/MNEkH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FE25A647;
	Mon,  5 May 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454742; cv=fail; b=qSmLBPeHB3QFmrtqQoN7iv0gRNToV1r4Ecn5rsUabAYW2PpvchG/5GiCsqfYRKZ/m/F6phXv1X1k/aOsL3pEXU7O80wCntgKESZ2R4azy8486BF1+H3NhjgJ6Zo15zKLBNS0aNyOzUDarSNMAOKh836N/+6elHVkpMzX8h5gZTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454742; c=relaxed/simple;
	bh=A3X/JwCkI8rbFjZieyYGMn9Q56DygMhWW0mO582N4S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJPXXxQYdFlGTSu6O3ByQkfjFP/++OGz+WOPpLfBKVy/l3IjFsKwWwAJFBmNMnQVo+2VC6hi7boDa2nPU1S/TkNpCQAMLIrfhgO4UNFPeRwc5t6PXM6uwPzbq/XnVAAGYeMEP2V0fShDU1h6zCopzh/BxdK8MriK/VFj9CepLuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oL/MNEkH; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I27umH+WkMCiVAfu3KqkfzUFxTrnYuYA6AERgSHD6JrAHOPJw4nKkMIW+1ghuEkwM5T9aSAIQ5cpf0ygkPZBauJkRPecwfjWz19TSUgYmDMwa13WwbcFPPU/1qv9ZSZuOeGnE4nfDrZGbEl5/WszIKdJo3qg/I5JkJaOQaFywYdGuTq2Wf8LpApopS0COK2tBMOmDXy7PZTcogTGluZZCT7JJbOwjzXqCljMGve3H3jDcUUeqT+XYibqHYX0nQKfpBy7cDBa5fK3rnR4aqu04AxJv3IKi3UWNmFT6Qax4iEbRDImfci84AxZ8mm0SRZn/bv75Ku9AjoDX7f/MeKmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ONTpJSw+B/+vsjtZKWkx1KYTEH5YGKxXpz5UVh5IXc=;
 b=IwJfyl3zZK2idPT2gN4WWkyW1OI2VOKtg5q38KNCgi7PPB4fvxL7wko+bYxj0fe+5tD/XwfyHMFYVL4SXUHM0u1Ws3ud7sCUBZbJK+nzE1eNHvaz2N7ibeZn1cIRgAsIaGhGemqfH76JKc0x4yLEAWlGmCAoiQsUjljHr4/j0qmUt1hu36cbdalyRAh7hCnzCgKcyj4wlqDL3rci28aQAzWSO5gyyqNshHBqTZTvMe6UdeOusbKmi6FsNoHI1OfubJ1AF+JemJu0+ghi8aX/HyLRjjfUuch1kPdjbxLtTQ6U7njVQup7H3JBKKkm7HlrQtlxyOPU6Q32/nc/oGM1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ONTpJSw+B/+vsjtZKWkx1KYTEH5YGKxXpz5UVh5IXc=;
 b=oL/MNEkHXjEvPfxANLHstj0Qy6W2vuC2WNBZWZc2F93H6XJRH6tcdrcCzR1WON97qAs2P6KDPwujoOL6TI5A3E84dIuLDyh13tSX3x/d/8SgEXJynePPIohmxfN8npn0+O8SE34DBct5hctMS509k1EtEBHIDDtIMRbwUIO0kum8O0RSmqhTGZ9iSJz1WYUEdlVc4DjFaAyNJyMj5adkdUBvW7xEs3ay0tfbuQa+owA8LLrwEVccNTD8ro2EOkCCEcHT4rXyEt92mky0nBHW7NprSLY3xVs5NYuLEdAUxa17ExqzB9OIbZxvnXFdI5MnuF439lByneE5LEG91LY89w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 12/15] iommupt: Add the x86 64 bit page table format
Date: Mon,  5 May 2025 11:18:42 -0300
Message-ID: <12-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:408:141::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e941cc-4f20-44b0-94b2-08dd8bdfc05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58dzZj6oYK5kEPFuOYNTugI6s77SaYZfXg2Z9QDH+GgeaSvyqbDQnN3esd2U?=
 =?us-ascii?Q?3PpFPoNLbyli5I0DutUymwUjdhK8r2Mb7XWGpZHw5ISe5Hl6KLvop/oA8d+T?=
 =?us-ascii?Q?ja6U60zp3Ru2QyjunEPb5BW79lld9mrK1X/b3w31zQwvfgV2rANXFxaCC7lm?=
 =?us-ascii?Q?Lj+GMcUAZsU+0ktFPw2CkjWRZOK5H0yI05GviRV1tZ5xvU9aDSanIxhauRhv?=
 =?us-ascii?Q?m42zGskSEW7UmaJpOb4/8bkUj1hpqXTPdpqtCefuV8+iTuvshqLjI3okOCBQ?=
 =?us-ascii?Q?TRoy01ntiTAsoZFIozxb5cLFuGmbDOOnwbz5acTshLbuzyw/v/tB+nkklfUj?=
 =?us-ascii?Q?mZWAtRATO2n1IIfRKvJfmQbUusjDnXU6v/Q139nEZdc6ZFk1fAVqjcj0CFOz?=
 =?us-ascii?Q?vy8JCjoKa6ipLqp+ueACabN8fVSJwuQ+WfV221DeZOex930j5FeLSc3UsV/E?=
 =?us-ascii?Q?omSKA2POdPnPqnyHy6fXJwKJ3Wiqq35Jr6gyZQzIPkRZOQjIko4dQnggjzPT?=
 =?us-ascii?Q?uwOYGgl+CmrfgQRFKboHbw1Z/7wlEv1j9SISpvCZmVneT4VUGbmhwIzo0bg2?=
 =?us-ascii?Q?Wg2w0qCCbxp0lzjSznfm/At2It2DmUCrXUNogpiyPwSssVL6BBHQyuknB6ok?=
 =?us-ascii?Q?WTnDrHAgmQTyZxyj8VJTjR6j4sU7aqNlUG2ZgVBokGeRiwuVUJal6QWU7aiv?=
 =?us-ascii?Q?M34FyNCtWkK5SQlD5EByCAECakGfeSdha7udfI3OCcmNrCSZ40m/YTud6Vp6?=
 =?us-ascii?Q?PzQdvGRGKN3oBC6yoidnpdirlRgXx2C4I0tFaS0V0cXol4vgfru0DkWwurLV?=
 =?us-ascii?Q?6WpsvHPViUe8k8cLQO6C3xjwtS81c23IZQlpSGYSWP4of/polOxT2t7LmRXK?=
 =?us-ascii?Q?Rx8diW+qbfHmnkD7eYV/nVrUF0U4YbfcR7HiZxKSS+G6lEW+rf+pe/EIJsGD?=
 =?us-ascii?Q?VeiCYQT3ho/ScoVpZCF0p7FZjOBQ+t82FypKC/LRsA2ulw9QRj2R7POtPKMM?=
 =?us-ascii?Q?+bAcBBXahy88evDYc3z4HSwv4eBKl7JgNYLd5PWkJncDRqHzbd/53YTXk3kM?=
 =?us-ascii?Q?Q81VfaR8U1DImylPd5rnKQdyeYJZzIZ4kASNDARv39+Wcp6J56LctDNojki2?=
 =?us-ascii?Q?v7jakRpEyRLWrZME6kTOX+ehd2inY2OFC/87M+t6ihqpSheWzXSgA6pSNg9z?=
 =?us-ascii?Q?SS7vceIFDKdx8YhOwd8Y8navhzjb+OIIUKILKIBXtTQ5mDaNtk686dnCBSBM?=
 =?us-ascii?Q?cPw7RvG0pdSHPjbrDKaFLA78KxXgjP3bh97BVsipa18cgHLHVPAkUUcmGtXE?=
 =?us-ascii?Q?aS1W0X6vLAlYZFl/ELvVqMdfhK0mmTpUxKIlOubZ0NlweAv+x+xj457R2x3A?=
 =?us-ascii?Q?rsABR9ZOzLwv9mXF9y4VtfYB0Ms0nekhkX5xEbA6ZRupRKZB7XaSYg4QrK5M?=
 =?us-ascii?Q?nVgzcKeIh6iw7LsIYwjFj38EVpwJxTbx6K+xQwTpVFJcHcK8mXq1sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ag0sFBKTivkdzjCPQRsFo4xDi9RWvtllK3UkPbZzGDYVEp5YKKClV+7N97Qw?=
 =?us-ascii?Q?hLtZgqCHSWrVY0QWVrAbA+lKTwGvuIv6rY8s8LrK7pz3cieVRXIe32qgv7kR?=
 =?us-ascii?Q?PwiWHkGtnArMlMwK6VDMdK508PS4/uNf+ISFu88fG1EjxgxuLmOTkq5DDJJq?=
 =?us-ascii?Q?86nH/D/kcKXhDrvVGG4vRPPxDd7bIckif9wlNNpbywANxLHKepfEKVqWivxw?=
 =?us-ascii?Q?esrq/Jk/SXDX9ZSqE1EGZvyX1VPayiIaug0fj1nQ9e8qCDMhrm4oEfnKw+W5?=
 =?us-ascii?Q?RgWcoFrtezO6VkNW52q7FTyN8gkK68KtVPaE5bytECty1Z1SO5bTr7prwCH9?=
 =?us-ascii?Q?6JOF6X5ZfAz5FgUVopBfuMZdE06cLW/2rn9lINOrPHAN7ce7MzeZq6/3DuMZ?=
 =?us-ascii?Q?1aKcK+vCQaGnrDDxDcrwmDjpJpCD+Bv/pvJUvJ7pnhXj4RQJbrSUP0f5Z3FY?=
 =?us-ascii?Q?9N8ryrG+qFs9+/sSzZDGRRQbXWHZMxrZLdZlEhOYDVgLnDde4KISp296v7Wd?=
 =?us-ascii?Q?B4p5U7JsyHzUxlEY0mzVWwRBXyDjfiuYfiFXYvte1jnKSNJx+yLvopWT82nx?=
 =?us-ascii?Q?6nYyNC9H0uDraxw0v3M3Gp41c9s/uHLlxwzIHiXryxSuRjJUx8wubmReoQbD?=
 =?us-ascii?Q?oCmxieVWuXNSLPmbBO6aoTu60VLhtZA6+Nmam2MIBo/ByIXKhVIXF7Z35G3a?=
 =?us-ascii?Q?wRzKPUlxAD2U1DH9HPcQs22394VNGTc3cIk2jy6i1E6bZHKzY+H/Cz8d1dcs?=
 =?us-ascii?Q?K8lkOUzRu7aIclkUWP+wmFuPzLFft5hVsb4ks86cTO77pEZQFWz2gSMxwdAy?=
 =?us-ascii?Q?ATKUKXMHzUiKCNDDSFW3itMGA2Ir1e+yB3yvLmGcwDvmmxHjbYl3DwlYiTFI?=
 =?us-ascii?Q?VOs2FqNMQ+YCTLzUFLhsyYmPdYmjvKMn3w8098hIi1tUiA4h6Icu68xwoO7p?=
 =?us-ascii?Q?xL4UOu+QPLWDSd9xgbRFgVJKN1na2C7Uc0Yfu6ywd8lLFt+0PPUpcu8Dq8yT?=
 =?us-ascii?Q?chKjGnWLODiem6pJ0SlbFfR/cU7hQMzicYtqg0QDiDUke5IjsO3qkYflOU40?=
 =?us-ascii?Q?2mUu71WZXOPu0kun5xOme2BomHap0axhXDMynWyeawgmi5hudaAKQR54cxHm?=
 =?us-ascii?Q?qcNEwmBEZ5fFkJSsboMz3LCIAe/K4O/fF9GYvGhRnnWpkVNjHAmlVMieA3Hz?=
 =?us-ascii?Q?o0KsLnYUAdEuFjbKe3i8OF26wvREKHbPlEgxpxjq5ToL8E4gwrevHgXBeJs+?=
 =?us-ascii?Q?Q9HXGH5W2YOVeqASF1RL6pGPaYCXWYvPimPh/rK07ly31g4G5IUgl09oLoiQ?=
 =?us-ascii?Q?MOn3x00eyisi4dCDTVDYyd3oU0BXvfvtvdKejdlNBofNaM3ppE6A+Y8Vc2RL?=
 =?us-ascii?Q?3JVVgpAjvNuna2uqxuBcN2eBJYftawVGitWLhyCmdTrNfAM2Ws7lA6ucvHm7?=
 =?us-ascii?Q?Y5IgRPsfc98q22JeRCUmgAeTSL4j7M8qE38rpnr3IhNKti7CdTkvDyNK5adF?=
 =?us-ascii?Q?KRj1EqcVQ6POe4zJ0/SjiYfNxXr74jhv/eplhYPGDCZv45pvT+UvyPYrZaPy?=
 =?us-ascii?Q?pxNlfbnVyWdpT8Pu7P4c+MXORJoigbSb0ftsF2L3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e941cc-4f20-44b0-94b2-08dd8bdfc05d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:48.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avi1I5l9wPyhEa5pmDJFwBXkSF2sAqxi6HSKSxFjlz6s/V1FF/u7EZ5v5G3/fvpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

This is used by x86 CPUs and can be used in AMD/VT-D x86 IOMMUs. When a
x86 IOMMU is running SVA it is using this page table format.

This implementation follows the AMD v2 io-pgtable version.

There is nothing remarkable here, the format can have 4 or 5 levels and
limited support for different page sizes. No contiguous pages support.

x86 uses a sign extension mechanism where the top bits of the VA must
match the sign bit. The core code supports this through
PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
new operations will work correctly in both spaces, however currently there
is no way to report the upper space to other layers. Future patches can
improve that.

In principle this can support 3 page tables levels matching the 32 bit PAE
table format, but no iommu driver needs this. The focus is on the modern
64 bit 4 and 5 level formats.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     71,61    ,      66,58      , -13.13
     2^21,     66,60    ,      61,55      , -10.10
     2^30,     59,56    ,      56,54      ,  -3.03
 256*2^12,    392,1360  ,     345,1289    ,  73.73
 256*2^21,    383,1159  ,     335,1145    ,  70.70
 256*2^30,    378,965   ,     331,892     ,  62.62

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     77,71    ,      73,68      ,  -7.07
     2^21,     76,70    ,      70,66      ,  -6.06
     2^30,     69,66    ,      66,63      ,  -4.04
 256*2^12,    225,899   ,     210,870     ,  75.75
 256*2^21,    262,722   ,     248,710     ,  65.65
 256*2^30,    251,643   ,     244,634     ,  61.61

The small -ve values in the iommu_unmap() are due to the core code calling
iommu_pgsize() before invoking the domain op. This is unncessary with this
implementation. Future work optimizes this and gets to 2%, 4%, 3%.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/.kunitconfig       |   1 +
 drivers/iommu/generic_pt/Kconfig            |  12 +
 drivers/iommu/generic_pt/fmt/Makefile       |   2 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  12 +
 drivers/iommu/generic_pt/fmt/x86_64.h       | 241 ++++++++++++++++++++
 include/linux/generic_pt/common.h           |  13 ++
 include/linux/generic_pt/iommu.h            |  11 +
 8 files changed, 313 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h

diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
index 936c327f0661cf..2016c5e5ac0fe9 100644
--- a/drivers/iommu/generic_pt/.kunitconfig
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -3,6 +3,7 @@ CONFIG_GENERIC_PT=y
 CONFIG_DEBUG_GENERIC_PT=y
 CONFIG_IOMMU_PT=y
 CONFIG_IOMMU_PT_AMDV1=y
+CONFIG_IOMMU_PT_X86_64=y
 CONFIG_IOMMU_PT_KUNIT_TEST=y
 
 CONFIG_IOMMUFD=y
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 835aab50dde374..f3a851f2804b88 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -45,10 +45,22 @@ config IOMMU_PT_AMDV1
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_X86_64
+       tristate "IOMMU page table for x86 64 bit, 4/5 levels"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	default n
+	help
+	  iommu_domain implementation for the x86 64 bit 4/5 level page table.
+	  It supports 4K/2M/1G page sizes and can decode a sign extended
+	  portion of the 64 bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+
 config IOMMU_PT_KUNIT_TEST
 	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
+	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
 	default KUNIT_ALL_TESTS
 	help
 	  Enable kunit tests for GENERIC_PT and IOMMU_PT that covers all the
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index f0c22cf5f7bee6..5a3379107999f5 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -3,6 +3,8 @@
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_X86_64) += x86_64
+
 IOMMU_PT_KUNIT_TEST :=
 define create_format
 obj-$(2) += iommu_$(1).o
diff --git a/drivers/iommu/generic_pt/fmt/defs_x86_64.h b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
new file mode 100644
index 00000000000000..6f589e1f55d35a
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_X86_64_H
+#define __GENERIC_PT_FMT_DEFS_X86_64_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct x86_64_pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs x86_64_pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_x86_64.c b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
new file mode 100644
index 00000000000000..e65ebf70cb1d91
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT x86_64
+#define PT_SUPPORTED_FEATURES                                  \
+	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
+	 BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) |                    \
+	 BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+#define PT_FORCE_ENABLED_FEATURES (BIT(PT_FEAT_SIGN_EXTEND))
+
+#include "iommu_template.h"
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
new file mode 100644
index 00000000000000..92cc12234f8c22
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * x86 page table. Supports the 4 and 5 level variations.
+ *
+ * The 4 and 5 level version is described in:
+ *   Section "4.4 4-Level Paging and 5-Level Paging" of the Intel Software
+ *   Developer's Manual Volume 3
+ *
+ *   Section "9.7 First-Stage Paging Entries" of the "Intel Virtualization
+ *   Technology for Directed I/O Architecture Specification"
+ *
+ *   Section "2.2.6 I/O Page Tables for Guest Translations" of the "AMD I/O
+ *   Virtualization Technology (IOMMU) Specification"
+ *
+ * It is used by x86 CPUs, AMD and VT-D IOMMU HW.
+ *
+ * Note the 3 level format is very similar and almost implemented here. The
+ * reserved/ignored layout is different and there are functional bit
+ * differences.
+ *
+ * This format uses PT_FEAT_SIGN_EXTEND to have a upper/non-canonical/lower
+ * split.
+ *
+ * The named levels in the spec map to the pts->level as:
+ *   Table/PTE - 0
+ *   Directory/PDE - 1
+ *   Directory Ptr/PDPTE - 2
+ *   PML4/PML4E - 3
+ *   PML5/PML5E - 4
+ */
+#ifndef __GENERIC_PT_FMT_X86_64_H
+#define __GENERIC_PT_FMT_X86_64_H
+
+#include "defs_x86_64.h"
+#include "../pt_defs.h"
+
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/log2.h>
+#include <linux/mem_encrypt.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 57,
+	PT_ENTRY_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+};
+
+/* Shared descriptor bits */
+enum {
+	X86_64_FMT_P = BIT(0),
+	X86_64_FMT_RW = BIT(1),
+	X86_64_FMT_U = BIT(2),
+	X86_64_FMT_A = BIT(5),
+	X86_64_FMT_D = BIT(6),
+	X86_64_FMT_OA = GENMASK_ULL(51, 12),
+	X86_64_FMT_XD = BIT_ULL(63),
+};
+
+/* PDPTE/PDE */
+enum {
+	X86_64_FMT_PS = BIT(7),
+};
+
+#define common_to_x86_64_pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_x86_64, common)
+#define to_x86_64_pt(pts) common_to_x86_64_pt((pts)->range->common)
+
+static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
+{
+	return log2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+			PT_TABLEMEM_LG2SZ);
+}
+#define pt_table_pa x86_64_pt_table_pa
+
+static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
+{
+	return log2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry), PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa x86_64_pt_entry_oa
+
+static inline bool x86_64_pt_can_have_leaf(const struct pt_state *pts)
+{
+	return pts->level <= 2;
+}
+#define pt_can_have_leaf x86_64_pt_can_have_leaf
+
+static inline unsigned int x86_64_pt_num_items_lg2(const struct pt_state *pts)
+{
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 x86_64_pt_num_items_lg2
+
+static inline enum pt_entry_type x86_64_pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(tablep[pts->index]);
+	if (!(entry & X86_64_FMT_P))
+		return PT_ENTRY_EMPTY;
+	if (pts->level == 0 ||
+	    (x86_64_pt_can_have_leaf(pts) && (pts->entry & X86_64_FMT_PS)))
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw x86_64_pt_load_entry_raw
+
+static inline void
+x86_64_pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			     unsigned int oasz_lg2,
+			     const struct pt_write_attrs *attrs)
+{
+	u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	entry = X86_64_FMT_P |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+	if (pts->level != 0)
+		entry |= X86_64_FMT_PS;
+
+	WRITE_ONCE(tablep[pts->index], entry);
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry x86_64_pt_install_leaf_entry
+
+static inline bool x86_64_pt_install_table(struct pt_state *pts,
+					   pt_oaddr_t table_pa,
+					   const struct pt_write_attrs *attrs)
+{
+	u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	entry = X86_64_FMT_P | X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(table_pa, PT_GRANULE_LG2SZ));
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(&tablep[pts->index], entry, pts->entry);
+}
+#define pt_install_table x86_64_pt_install_table
+
+static inline void x86_64_pt_attr_from_entry(const struct pt_state *pts,
+					     struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits = pts->entry &
+				 (X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+				  X86_64_FMT_D | X86_64_FMT_XD);
+}
+#define pt_attr_from_entry x86_64_pt_attr_from_entry
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_x86_64
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_table, iommu)
+			->x86_64_pt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_table, x86_64_pt.common)
+			->iommu;
+}
+
+static inline int x86_64_pt_iommu_set_prot(struct pt_common *common,
+					   struct pt_write_attrs *attrs,
+					   unsigned int iommu_prot)
+{
+	u64 pte;
+
+	pte = X86_64_FMT_U | X86_64_FMT_A | X86_64_FMT_D;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= X86_64_FMT_RW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot x86_64_pt_iommu_set_prot
+
+static inline int
+x86_64_pt_iommu_fmt_init(struct pt_iommu_x86_64 *iommu_table,
+			 const struct pt_iommu_x86_64_cfg *cfg)
+{
+	struct pt_x86_64 *table = &iommu_table->x86_64_pt;
+
+	switch (cfg->common.hw_max_vasz_lg2) {
+	case 39:
+		pt_top_set_level(&table->common, 2);
+		break;
+	case 48:
+		pt_top_set_level(&table->common, 3);
+		break;
+	case 57:
+		pt_top_set_level(&table->common, 4);
+		break;
+	default:
+		return -EINVAL;
+	}
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	return 0;
+}
+#define pt_iommu_fmt_init x86_64_pt_iommu_fmt_init
+
+static inline void
+x86_64_pt_iommu_fmt_hw_info(struct pt_iommu_x86_64 *table,
+			    const struct pt_range *top_range,
+			    struct pt_iommu_x86_64_hw_info *info)
+{
+	info->gcr3_pt = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(log2_mod_t(phys_addr_t, info->gcr3_pt, 12));
+	info->levels = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info x86_64_pt_iommu_fmt_hw_info
+
+#if defined(GENERIC_PT_KUNIT)
+static const struct pt_iommu_x86_64_cfg x86_64_kunit_fmt_cfgs[] = {
+	[0] = { .common.hw_max_vasz_lg2 = 48 },
+	[1] = { .common.hw_max_vasz_lg2 = 57 },
+};
+#define kunit_fmt_cfgs x86_64_kunit_fmt_cfgs
+enum { KUNIT_FMT_FEATURES = 0 };
+#endif
+#endif
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index b127d8915d48fc..d14919f94a9448 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -150,4 +150,17 @@ enum {
 	PT_FEAT_AMDV1_FORCE_COHERENCE,
 };
 
+struct pt_x86_64 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_X86_64_AMD_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 03a9b692f82531..ff7edeffa8197f 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -248,6 +248,17 @@ IOMMU_FORMAT(amdv1, amdpt);
 struct pt_iommu_amdv1_mock_hw_info;
 IOMMU_PROTOTYPES(amdv1_mock);
 
+struct pt_iommu_x86_64_cfg {
+	struct pt_iommu_cfg common;
+};
+
+struct pt_iommu_x86_64_hw_info {
+	u64 gcr3_pt;
+	u8 levels;
+};
+
+IOMMU_FORMAT(x86_64, x86_64_pt);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


