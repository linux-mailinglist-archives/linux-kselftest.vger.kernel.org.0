Return-Path: <linux-kselftest+bounces-42850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E82FBC24E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C719A36FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6432155389;
	Tue,  7 Oct 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5a45JOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220D2D5408;
	Tue,  7 Oct 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859659; cv=fail; b=KYn4+kY5A4JiA/0lksKq7ZzRlnnIBDZuArKQT1zyUIf22ShUQWWKwtfEAVOb0d9VlSVaY2XViiOzeMNVAGmmKJeaHRa5ax2m81xirmqqYGdGIRv3Ea7GehEpmTPp+BmMQj+f+9G/ZdsL0l9W6qFkeF1HRxVdKshBXQfxj++vHYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859659; c=relaxed/simple;
	bh=Wg4T2/lIjcYsEdUy5zvmzPmHM2aXeCCoyP26RygJE54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1i1ydMO4rNHGsxoDXpI2Sgl0vCyeIjxcZSntbGpCM6xE7Am4WY4Tmgs1v1xf7cYTt62ODWYP8S7iNgZidkLFbvcOIs2QCuOr+qlGuPgMdE0zh+dKRnH0jv98oP0/WpJOFQ0lanD6luqtk4ae37LCEUePuVHGsdG0retOpAeRmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5a45JOK; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn6v1CVHUMEHmfzTJzijTFrH4bbne/t5Unj2GHEPl7JdZijJDl+Ed6by+9eUUcduN7C003E5g3GXD8QE5eMaflqHJRmaucW46DR7guN8is5dxOZzH9Kd8BWiCQ50tRilFoFfPcwzDg4Y3/qGpzCCE133eXASzN1HJBdW7C00a7idEnryeycaJZWJm7XXDyR5X+hMtNczmrdwO99nLj+uTyf7dR00JSNCiEWePnJYs8EU5iyGqc7iIZuG0npvWDjJ2d7/NCnJFM9nFLPNVz4EKi0L9t9Gfxm9cMZay2Fg8NZIRJ1h7W+dSoXqanOnXXerQl03wC6E+2WO+TrhpAMb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg4T2/lIjcYsEdUy5zvmzPmHM2aXeCCoyP26RygJE54=;
 b=x8f26zegJnHuTPL/OumUz6WjT+ruGtXgICFH/05Un7c9g2KtUq8CR6Bmhth1E3cq4PJ0VmeHRRzgKyQJacOUjs9+9yPYdi2L9B0jmTO1cxKZE6M8aIZuj2KUroZG/g1lube9NGU24VuenEFnM/uun1OZ6OHhmf9pph24kbrNzZie+UUr8us1GV6X9xpA9hEwAk3BfIkxidWBKsOwq9dc9IncikgefAp3eEd6yMm76kKK6A0TGPhOxnHbakIJLvmGYdgZaSfaoHrmoXphd7Q4oJujAhil6nne+gVwf/ny949FDHwRMBGPn2CYLjnoMOfPFohSzoKQgelI8cz/Wio2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg4T2/lIjcYsEdUy5zvmzPmHM2aXeCCoyP26RygJE54=;
 b=N5a45JOK/Dzjj8AkmqmWcVs3G2gAON//JQV0E24mQ8zfTPvpJ/k5L7ZdYGHk9VEMrMj/oLjMIbtll4vuFDny4gssFUMm6mURycQiBsg6xhrXNaL4RlmyywgkvcF8EVaBEReNKCY3wevxZd1x6Bp6NIWE9HYKKCfWLzVcOwEHRAFQwqAXa8vlexAEnxrVI788bN3rzHD2Hqjz/ys3R9VIv88tpymjlkFASZliIbRYO5crLDOMCGiXORUf+ryTNJi0+bjcBnNt6D8h/uuz+S3eLgAor5qMTxmNUrDFYDlLKyWcNMdCi5rMMfy6ff+9vqdiFj7shSHyp4+AsLatYqMi3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:54:08 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:54:08 +0000
Date: Tue, 7 Oct 2025 14:54:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v6 00/15] Consolidate iommu page table implementations
 (AMD)
Message-ID: <20251007175407.GC3474167@nvidia.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <CA+CK2bBT80np3hZbSu=dRH8UOKT9RruHF3jtaXyTJUmNe8UfFQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBT80np3hZbSu=dRH8UOKT9RruHF3jtaXyTJUmNe8UfFQ@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0366.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: f4678395-eb1a-40a6-8da1-08de05ca8387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KECAYYaIcNca0y906i96IbbDKep49i/Y4raVhU8bTm5XtGksYadH71n3D7lY?=
 =?us-ascii?Q?uJDmYQw5wXUBjxy8k9r1LAiAc0CiQpcSkamAdpcxLRiVTwRmRVE3OvsdSpX+?=
 =?us-ascii?Q?fCoY+5ONQkQQGo0ErqTo2f1S3e902IpIKPawT/JAlaSv+Ok+THoD02ngdJdi?=
 =?us-ascii?Q?/q59588cUA1/ct2SJohesyrdF2i+d2p6prE63gFuACabdx0sDt1u2gVm5r2x?=
 =?us-ascii?Q?bRYQQRD93w8aZe6kX/2w5daJqb5ISYvmW0aYTjYrgf5PnK8BiYNuckcSWaFQ?=
 =?us-ascii?Q?b4Z3IHkLDprk6MPa1hdW6KzcSXp0PWR7+np6F8LwvD5S9Pyf6m7rkRTrim10?=
 =?us-ascii?Q?oOdNvlgZ8fRQQMC/qtpgZZ8IoQU/RNkehS+Ol4Tpi2isWWXSPeQZBAom59NU?=
 =?us-ascii?Q?C7lUwbtvgshhy/UGDWuu2oG+5N/jhye/nMi0Ti0tdedhhsP6ypD7rOVUbLa3?=
 =?us-ascii?Q?SHTaV9AKC2nN+Posb//IXhBdfAssFhq/GqMYdec7b4dyO3a8Uso9UJBX0KH1?=
 =?us-ascii?Q?awhrkoKyG6UmPRAlQgKEpQ65CFA16eLy2ZG7Bux0GaRvenDdPz8ZCDPvR6eH?=
 =?us-ascii?Q?4MkS5nbb3pMiHmCs36SYFTvoEWe8L/klpoPngO0BjeXwyL61MOgGYyj6QIzF?=
 =?us-ascii?Q?NKjQbndXlsB3S0JYgfEGF/L9l5NAO+gBcKfu0nqTbWocMLv+BQ6S5LGfpfCR?=
 =?us-ascii?Q?g4Py2t/QUnjXg4JIfSpRoCHkhZQ/jpY4lmtaeiro1SxgHQCgMBUNsIYVFShF?=
 =?us-ascii?Q?V+fQHI5XH3Qn/k6DgOnkhg1ojx2BSZTc6IPmPbmi9zCrpZ4mFht9BSUykfBy?=
 =?us-ascii?Q?jH8InpqfXPjq5Ub5Nep657lHvZF+nBykwE8jKF5LyByWBnpcJdgfNhY61O+o?=
 =?us-ascii?Q?VOluJltgq5/NVCs2saxr3YLSXEbEsKyB6ugp4d7m+2Er/15Jqlb8BS4oNLk8?=
 =?us-ascii?Q?r+LWDBSvycPeXqmgOFfNf9eJOvJ2iyPw5PreFLbrxOIk7IRsZdsx9svFsZSl?=
 =?us-ascii?Q?0Ppkjwgyd/Zi6d11+FvYOZaZNyET55AQrIX85dhhhyibq4EN8J5hrG/Lwhu2?=
 =?us-ascii?Q?DvhJ+qIoEBnhglCfORf/du5Ha/ozgO7xL7mXmRMV9+BWGvVwCBgNA6nATIRA?=
 =?us-ascii?Q?Gkel0VDeGznD9m7N+kQfCocSD2Cd9LgD+mKMBWr2T3A7OzfGp1Olr2v0LpZE?=
 =?us-ascii?Q?QsTWAC58b40Ts8sxxON8z2J7fy1GtbSZOety9FhObRJaJ4wuDPP2Npy2MsWw?=
 =?us-ascii?Q?pUdE3r2d+oIwH0FrmfHqnjbO8IfNMIGmm2snA5sxWvGqkx0FHV/tLVdUu4gy?=
 =?us-ascii?Q?/H2GbYbakXwCNo6ffoXu/eRZ9cQKr4nhop7ENBLfSMyBVPUomVEzD1pabF6Q?=
 =?us-ascii?Q?/Gg426hUB7xFpnD+W6uPqwyPMi9h61pG/50wN2CM6kP1b5BgRh6aXDLmbnZV?=
 =?us-ascii?Q?pdVGku/iHzJC2ROFHBYRRQU5cDJ0ljePW7+Nw27ANaawUrD3ek7D3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhA8IWdA8pnNWjtscb0ONdHO6Iiokmf7iCNwt2HsCpBucKSyaC1Cz2PUuMcX?=
 =?us-ascii?Q?hh4/LNJqe7+ZD0MHEx/x/IUgtx3aYsbv1Io/CjHrQdPAHBpP6hfSzucGAwjV?=
 =?us-ascii?Q?/CGOA5tnvIL6N8NNdnwWBGXmJhwMj1qkRS/Yd2RXOJxXZbNIc3TPBqHbFN3f?=
 =?us-ascii?Q?QO4ty0Am+9DVLaU3JZEyvYBktUx36Hu0h7REODzImVUrVhAEPGQPxfktEpbI?=
 =?us-ascii?Q?Q93UMAw6MHVi8EYGe0TFaCsM/Q8QN1cw/u2pRQGLlbEHli7/n5G7kDTpx3bN?=
 =?us-ascii?Q?SQZptOFAnfgQ551WtqDOXXIkHYaxs4CCgYrhWWh971CQG7ahAc3pcgyAxG5H?=
 =?us-ascii?Q?KimX0YccbgljMbyhS5ar2pKpgndflp3ThupuLhdhaW+DxIrkbJkecIdN2pIe?=
 =?us-ascii?Q?6dPj2YJF6Vjjaekv3Jo8QMJx0ucMcfrRZDfG0dLDimE5UCxhnJKZlLD7E3CN?=
 =?us-ascii?Q?6XN3MzWG8qoi0ndd56sO+bRbliMBDKjm+StmEMafilhFM258k8X4kpWu5+3v?=
 =?us-ascii?Q?Cwl7jWefgiaik825hgI7zDescxA/eMh7UmrldTnl9qLf2AsiABWXhcmml9Ao?=
 =?us-ascii?Q?Ifhn+etgs0hkmjZmn6IJOh7bDZhxpgfYxmrwyQtHUTFfmaFVXSSEN+kR/Gqu?=
 =?us-ascii?Q?fh2/ZqJjphKbCSumbr9T9zv4txzj3KltVS6yZ84HbHVy9F6Mg8mbp4fyRpWq?=
 =?us-ascii?Q?T6gsHw1qEoHUpES8t9XJP/5PPTCWWfgSjfjECoqsXTekuIYFaXx304hBa/0Z?=
 =?us-ascii?Q?ArKAlosV1dF/ReJkblXf8ylDCPpdZkbbeOu6JM/mzMGbm3TXx7OL0toYT+5A?=
 =?us-ascii?Q?n3dsyA5s1uV7mHbgE2sFddw+22hS0hsPiRDb9CIv2plxvEeETiYbRzHzd3Gr?=
 =?us-ascii?Q?kPlmbzWcHepGjDYDuRAM+0ckmuxD6PvaItPoXkD+4/Hy5rUzxF5ULcsh0Q0i?=
 =?us-ascii?Q?SqF7D8ZRNtyyl8cza0x8Sinfkow+du7rgfCeZ36XG5LCZM2kjQBHUNvbTeMG?=
 =?us-ascii?Q?gyJBlfYFCvo8gsqQcy/AYlOXv3l2VmsYvLN2wEN1fJJqFZolfdslJ4Xugk8c?=
 =?us-ascii?Q?qYjFMb1NRvM/NkftBTcM5oWt6HD+kwOZ+bFICuyUBpkfy0uwLw/rZNZVT6zF?=
 =?us-ascii?Q?DGLSCUEtZm8RcAtCMaYznQrYT9wU/HPfBl9FaLZt2XXhS00+qNoJuYTWOe/l?=
 =?us-ascii?Q?9bt7oD8crOvRSnYDNQrNmEa0pwUHy4KFbOED5cG0Rf7bDicT5I9Y3IB3IrvY?=
 =?us-ascii?Q?haAaOy+y3KglMgUUP3a9iYV03ciLWheZpDmL/aP0pEPKPjEl8BQ4l08401g9?=
 =?us-ascii?Q?6Nauxj95uAe1E7VpfVsECKnZIOC6D6fKmLow+ywiM6eubCwcokxy8ovzugPW?=
 =?us-ascii?Q?7QyiarRCgaqI+9FCEzg/Qnx05SXZN91NpqlI3DC1tjy5m6x0ZnjH7elVKKyO?=
 =?us-ascii?Q?pLKwxneq7aPZRXogKMK6I2rm0koG0J9EO/gNz+kPdb6EaTQNOhZRM+YhRsj4?=
 =?us-ascii?Q?5s+dqf2pLoDMHCHt4NPQZxQj1ycRSxuN77vZw7mQsXscJ/G/rQOjPHMAMIUK?=
 =?us-ascii?Q?FBtsE/QusZ/yQxbLeyM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4678395-eb1a-40a6-8da1-08de05ca8387
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 17:54:08.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4XR6j/XjiUqSNAzC1BqNp1/ycn+ULEtRlpOpiFa3rdmSOZ2nvVoO56ZQuYJXDFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410

On Tue, Oct 07, 2025 at 01:44:54PM -0400, Pasha Tatashin wrote:
> I'm wondering if this work could be used in the future to expand
> page_table_check to support IOMMU page tables. For instance, every
> time a PTE is inserted or removed, an external state machine could
> check for false sharing or improper logic. This approach could
> significantly help with preventing and detecting memory corruption
> early.

Yeah, we could certainly add hooks for different checks

> The main requirement would be to define a common logic for all IOMMU
> page tables. For the existing page_table_check, we use double-mapping
> detection logic [1]. If we were to implement something similar for the
> IOMMU, what kind of logic could we apply?

Mostafa did this, which is pretty similar:

https://lore.kernel.org/linux-iommu/20251003173229.1533640-1-smostafa@google.com/

But he hooked up in the core map/unmap not directly in the page table code.

Jason

