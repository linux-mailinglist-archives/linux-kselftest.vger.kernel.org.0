Return-Path: <linux-kselftest+bounces-44800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE0C35AF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A94E8453
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D0315D46;
	Wed,  5 Nov 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aF3OhD/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379330DD3A;
	Wed,  5 Nov 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346604; cv=fail; b=h+7enJa2vsGC7ngzdaA8t0TLhHm/4RmqKL0ZLxIg6bQND7nlOiK4knwZLqvI4cgYP5kxSSgnkUDbP+5jpmh2vNZEc80g3SQRgKh/ZU2PDYlV/zLEqnuEcDx55LXeyOXkxHl6qt+3Caz/6uYA1rnUX6Zw8x80flrwZ9FB6m8ABY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346604; c=relaxed/simple;
	bh=M6qfK0XiPIooT5v1KKM/sCZy+vI57yuMJj4TSolNO/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aCUQ+vdmDA3afv6wFXIEYS34zdFzTGN+XvB3UwkuXx5p71+IcrJayCf4t0yHkky8J5LBeN1TxpyXEUm8VC9dpuDnGW7qqVcIVn0TDXsKY+9nWsWVaEti1RVCprjkXB8nf+6LOb4OW0iAxnEfSLyPoPedulU1Vc7BlxzDbNXwjuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aF3OhD/F; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUHvcjMJpMGQMAbPbh8ZALI5G/owmEULAdc/ykIn9GTLjtGJjhcTkvYAzm1wOcFlk9fJv/g8A9zHr5Rd2hcqgrW91iJQh0Om0Bhx9nABNSxyDL71MtgQ5TiOgaZp54VHpMvC58dOdKjGph1afG/rw31TEjnZEx+sM7J9RA5kr31wNCRv6h4BvhTNsrBO80zRqUXKhoX2D0N//oCUEmn0JBTvfRxFM9XDYGYtDRSbfe7FY1+i9BueRUdyIHbkxB/3D2Q5/N3sLovJAnbd9oprN4mhFoCKsxmkkj/V3AGPTqlaT3FTYTedYHp8Q5sMihCFliG8OX+Yq1N2SpO3n8HuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5HFSFUQhfWDx1HUyLnS1/MGOTc9ltmCc0b2AFZf8uc=;
 b=NKeh90VIQvq9Gyq9LID5NI3K2z6/4zcrCr42+I2Yt1v9zNDskHo1WGvQ4o/6zhhE6ujyy0/uSLA2TjisBRNsZDoM6RgdDBJzLUYk3oX9Tr/dRVYeTY1MLP5vR0wIgarJuqi6MWwJMD8QLy4NnX99wEvufC8E4TKHp6e6eIb/s21bqgYPQqUA0QK4a30koiyWuAebAoAN7H13eSCUmvJcmhCs5o/F+AIzxBeSA3qeyJH+Q20oAAlAbXVtNgoivVvkPvn5uYbEA13yZ+neJaOgqpREWRRFKfHUJFswzAhX6G4iYPiWhnXp8Y5kvQt5JnHA3HA2HetJZ55At/3E7EzVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5HFSFUQhfWDx1HUyLnS1/MGOTc9ltmCc0b2AFZf8uc=;
 b=aF3OhD/FXzVL0AyfgWEUGdFkmuOdc/qzY4Xz++6JN/PX5tCqaLEjSFd4QzdcvmFNbbi3Gk2c4SCsRJ4pAGcjCbV0H78fijN6Gnc3t2pJP1HsCzkjiTQCrHUmEJm8DPfGMYU0mucCn1zx1zweKk69T2FfsbCHL35M4ZKP+889VzfD84zP+0/ZA0MJI3Nkxmt+j4dn2ne8RnK3SpRdXVOx9mrZk8yF92nxm/MV/pJV0+FBMu2c33PNBjE0edGXY6uvdWiAJL2lNmRkp+L3OJORvwmbgLLyK1gNcrk3jUyzZrvxoNuOHN7MiX8DxAX8P5o5Mz7VLOfv2zpDYHimvMtqLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 12:43:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 12:43:20 +0000
Date: Wed, 5 Nov 2025 08:43:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 00/15] Consolidate iommu page table implementations
 (AMD)
Message-ID: <20251105124318.GO1537560@nvidia.com>
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <3wwyr2kqhaj5icznsizcu372uzhygubkytko3vueamwnf6vzr2@hlas3nx53tps>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3wwyr2kqhaj5icznsizcu372uzhygubkytko3vueamwnf6vzr2@hlas3nx53tps>
X-ClientProxiedBy: MN0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:52f::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ede946-52c5-40dd-6ef7-08de1c68e63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/exktVM18gLlDhXZ/+RuqtaAPIHmsaCdTa7gzYmZ8t5D0ZChWKoLPBTdD6Z?=
 =?us-ascii?Q?fblQdzsVF+FL90YDFcklnicHBo3L9mPduDrUEzox0wdYzNdUbJ7k22/G66RQ?=
 =?us-ascii?Q?0cqHbTp7G+/2YtXbOuBwPBBey2LHemWkRVD/e8OFBBcKOVIdPBCuHxwIJ7Mo?=
 =?us-ascii?Q?jhAxfC5D9j5pn6BtUfXXz1tXVhLdfx7wWFLbFSGFBxxjHMif6w5v1BhW4iK5?=
 =?us-ascii?Q?barqkpXGwzAL9USrfRY50ynJBhTuL7W1202+k6lST24zj3jvZbgiDzF0ZJWi?=
 =?us-ascii?Q?pBij/hXr68qfyza61OikfpYyG38532EG7gck3obBc0VkmUrvNpwlVkgJqVIz?=
 =?us-ascii?Q?bzcJ3hKm1a1wG3oI6fMMco7SCiGmXLAPAcQ+3W5kgQtUasC0mSr2Ec7AWQWy?=
 =?us-ascii?Q?wGZ8mmBvIdYfBn4uRNftODdzMRt9RtLCFDmenONL+4FtZLE4iPuX9lrirNab?=
 =?us-ascii?Q?u8+DR0PEb7b9gZc87nTJhFSVYOIM6Cgvv5iWcrs2b4EG031bpJJ5veBnxxVY?=
 =?us-ascii?Q?6oVLTYa59V4THuqsTOHeL8oZEFRqgCke7QiE8iRLxJJhR0HwuqOIY905xNzg?=
 =?us-ascii?Q?kI3XFrWL3mR05Wyx/lHjTHgZLnEUTsUOqI+/i0VVmwDOaXFrUbofv6ROp8pH?=
 =?us-ascii?Q?/tAWcks8vz8OcUj6islEwVc6c7A9qMjliv4ycIEqV8M4NkC1r2c/VbPvmXhX?=
 =?us-ascii?Q?EZCYE29T3ewWWIIUghgZQggTVng8CqAUqGnjqPGpo4dKOWgdnlSZV7LDgH31?=
 =?us-ascii?Q?6XyUbm3/muT9Dz5cx3WfLRgJWdAWfC3C3Plm+NVZGGsJ1SAD03EuFxb6It7s?=
 =?us-ascii?Q?00cAnEq+wFoCMZhrmDvYsQ+x1xajft2GXC8mk7xb65TqFNev9LvwOT6XY674?=
 =?us-ascii?Q?JJcVxLaVgicgzrnsHzrUzIAK9JCUIch6q/HuDt+cwMxI747gcDeiiWJmWTPp?=
 =?us-ascii?Q?3ZzMuapYe/QFvetf/auug9Azezr1DnCOg93icHkzzWPSxYnHFSmgxiAQ1Ia0?=
 =?us-ascii?Q?zuT5TWygqSes2MK4Kq4KPUIsblPzH6OQeLVQT08+hZKX77/ZK2kYcjtEh4pC?=
 =?us-ascii?Q?mv21HfwraA/NdmR8GRbAgAF6isNp6mDPmiI3/TmsYt02WFzNQpYnxyG9kf8j?=
 =?us-ascii?Q?gAp3VsSWKStbL5afs6ffDWLW0wNgfidaS8rnj5Ee9WMNWYy89owAWBJfo725?=
 =?us-ascii?Q?25CgkgwOZijA/73yAppKQrKg5NP00CY8P9oqo/ZHR/2TyDf4aoENzlYtmljd?=
 =?us-ascii?Q?oq2GhA/Kb0FAMGxqpxVc4AGgGdY92R2seMtF2IfCPrXBDnYdXZmVcup1040w?=
 =?us-ascii?Q?7IBPkVB2kGX7jl/E8afkAj13FZDCnlneSjAtw2CdnvI14Wq8u4SmLwfQXWpJ?=
 =?us-ascii?Q?mp3/NBfQfCOOf5CBFYdPGewQdE/j422KZE+HjtoXgFCgxJlCDFlUW+a4+bCX?=
 =?us-ascii?Q?wvIwT6aBmEBmq0hRO+lnE/6l+E5egzrU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+V23VLZJI8zapsv/NJfHLlMugByNvhlPHMOiYa4+BtHOEtDx/trgU+eEXCZ?=
 =?us-ascii?Q?vQ36QqpSdcGROEIno6WObqCrEm6Af1rCyMR1xFd3r6GqmgtV5ENSBtsSclTj?=
 =?us-ascii?Q?FDxPwUd18krj67DKn1K5StSsg9I9zzOOxX3OsXTGkoA5nDsVcjS/zIdKpbca?=
 =?us-ascii?Q?lKNR6OFfvtPpMjN0Mx1/SvKmalzUOUq1ZihWdylgjtSgJegu8ijhxOuqpE6g?=
 =?us-ascii?Q?rr/p0Lbi0qFAJp0Eo6w0DbypTFx/02UMLLOCCVI2zfL8CpNawvUbq2Kh1FYr?=
 =?us-ascii?Q?oSCofOtSuOPvMvtvcDnoVKyLMIFFTDiYlBiCJOw9R0JvA1i2ZAM9hJd9NWKP?=
 =?us-ascii?Q?985DWZMUBJkT+VvhthZ/wvn8KILkVvjHkpok7sGvX1mFJUkXjies8wiQ2PR+?=
 =?us-ascii?Q?0FDHR/f/LINIpJpjNx0Ro+hUph8R9pqd6SVSzrg69b8JfiyOz2z/3YB9Uugb?=
 =?us-ascii?Q?j7XfRjLzQ1qrYR6MMe4kstRDqd70KM8UHw4Ija8ZdkorMHnuqhnfIUs0lR+S?=
 =?us-ascii?Q?jn4gR0k9uAmefO8PFWCYSe5y/SdPV0TON+HeJqF6V4wygruOvNzYyjXRXH1/?=
 =?us-ascii?Q?u7pFoiS49dlNExbMkRprtkeiBvluovxDwe1w7qbXBGP0D5xabswj974bHZwV?=
 =?us-ascii?Q?wwB7mqpqfsWgtyzSKTjrNfIyL+mw1shri1f0y9ihI//ZFJTPweLdVRaU9JYI?=
 =?us-ascii?Q?JfH/T2Q4yRi3NbWzH1Xxsw4S8LDR3qYjVqp8ZniyP76JWnSf99ywcpmv2IKY?=
 =?us-ascii?Q?ZiYjTKE0tEDSeSQ9eeBU48og9jwsk1tgEUHW40hrekRRs3OrEvPtNpVtWo51?=
 =?us-ascii?Q?oWEbGca1zzP5EHFEea2LE1vXGeGSyCiKFgReDBDaTkxg/rmTzsfrVw1tVhF0?=
 =?us-ascii?Q?xClfahBRptk17fSogZK2yxAvEuop5z0fal3lInhSxDzxFeBs7KDcSPnTBtvT?=
 =?us-ascii?Q?mYa5PX85IL91ZvlttaEOjEBFZ/uAlefOCNYbNbqFKIeoGluyLi4bp3PTRI8i?=
 =?us-ascii?Q?IyDbPUCWvDnnfNh1Oh7qfM3WI/1nPJv3z8pUP/kuDtHFPPTamQ5FXcc4LcPu?=
 =?us-ascii?Q?VngFIv0Z1yNgTzXIakCTH0n8l+WNg3PJsqatCTy69jsoTiVkH9gkD25R2bzj?=
 =?us-ascii?Q?mvzYBUme7ACiOZqmmI1B44HHnKxwM1ZLnDg3F46tI0VIercwe8XK5Swj3HZX?=
 =?us-ascii?Q?znhkzCrYyMUGpFUCWGVOe3oSnS0dhqJatxTNYzM2pG+HiKif0Dy4+P02r75C?=
 =?us-ascii?Q?giHgG3ykazWUvn0VAeklfhSr/a2K4TlUoxbm03x12SZefTkuLVTTm2jJAyBK?=
 =?us-ascii?Q?nzhURJhS/f+5tvoaqHlPmXXtsHX9ObZFr0j5xh6pzoC4k/BAlJwHVZfx8wfs?=
 =?us-ascii?Q?CapnU8mYupdrRH8edv2I1dMDnVzC+DqgYXwRm2klGWZnIu2EVeRR+cjU2jAK?=
 =?us-ascii?Q?InGAk6+11jXNEhdxZh38pMoHgzxS6ZtZB/3TsoCvK38MPDOqiCijp0GC7zif?=
 =?us-ascii?Q?R+aaj+0GyuYXHIdknhSjwVly2bmucd/tKfxp5Hb0LixLwR/7pT0KUnjwr9/X?=
 =?us-ascii?Q?ekuGbvDXvamY4nw9JiU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ede946-52c5-40dd-6ef7-08de1c68e63b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:43:20.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msIoZuP/859XL72lGZw2QXn6aaa20H/p7Ka5A9gE/aqZ00YvQrQ0z1+kYGK2PybQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

On Wed, Nov 05, 2025 at 09:45:07AM +0100, Joerg Roedel wrote:
> On Tue, Nov 04, 2025 at 02:29:58PM -0400, Jason Gunthorpe wrote:
> > [Joerg, can you put this and vtd in linux-next please. The vtd series is still
> > good at v3 thanks]
> 
> Applied, thanks Jason. Please send the kdoc fixes which address Randys review
> on-top.

Will do. Please take the VTD series this cycle also, though maybe it
is easier to let this one sit in -next for a bit first.

Thanks,
Jason

