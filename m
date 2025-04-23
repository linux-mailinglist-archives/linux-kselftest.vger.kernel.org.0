Return-Path: <linux-kselftest+bounces-31392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB3A988FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BDF3A756B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267C2367D9;
	Wed, 23 Apr 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kh5T/+b0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CF20F09B;
	Wed, 23 Apr 2025 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409358; cv=fail; b=JzqU2mh2Vq+NNojBEsPVaQmwAqjzEltTXU7OpRbHr7I2djYRU/TrM4bc+x6VDie3IyZlICUazZFXAFFel9zW0a/br48XP/ZT1PnF7tey2qotvPEknFrHF/VUff4XB6QHiQgMpCEN/8EDk12bUi45lmmJhIGoDf2QqKLRXwcnl+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409358; c=relaxed/simple;
	bh=sD16Yn3dMKEZiddsSBB+0rLwJry3Lf+FfnE2TUTL2MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7WsZ1IciRpRM8oADrW8R9kboeAxK/79SSKAwL4CDmw3Hq6rZVXp1Ljkhd5Xj3yBmwXwY8mFM4j1Xa+YdtwEPB8SO11z5GfqG5wUMIg0mf3wvCHqO7KRIDavhkRAWsSE8qv0NPUU25PF7+g5kIIaJ9kPLH7ivjljO30UyhNRxCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kh5T/+b0; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO931/JYrMuc39mvjVrpEaYsoIUoeSnkv7s6VdVRbgu/LUG1u+ZWgccWBlFtVkPLcy/w/bWR0u3cK8DJlRU1FEpBIMFMDKOmajDficMC/sCjg0XpzYQbd3p+4t0+umi3O15SEYCu5Pfk3oeY74tQ3onlnpYJhZ3Opjf0YsFhC/BEqr+LzrOqI2Bo3N/NdZX4b7NWXVUzm7Ied6FZJj3lr0NMA2GT8fSfiqA5+SZyLiHudS5U5+FpqqNlrZobLvPVPUI+DJtNIEXjKK0/W0AKzAXgLlj8FNU6KgpHD5Jy9ND+GA2EwIF6e4yzWVsWWbDF08gm2dff27z0FKaYoKdyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+XiOrnZpE6WuyXIiLGzlzPZHFQqLlnM01GU229a5yo=;
 b=W+4NuEwFDd3kdVjA/U2oQH5qzDD6mceRkKo+Z8OkjWbiIndE9nJ5FiNqPr8TrXXaqsL0jW/8DAoI3K5mfVSPERJyf4CPQ05wA8dT+RQH766J+c+GzO4nRPdPTlrzDuwMF4JAMguMRARDoqLzy38ns/G+m6ZigWNvwpUPulql1j0zYOBa0pFlXgsSFD6t8jTR3Uv+ZGaFx6wYUkmZWVt/85U1hqzAQxFrO6O3a9c1lXfrcUS2d1OzYAk67CB5Gzq/VfziRHRJtnrwZ2Z2EFb5RTzljeZjGOr2D0oqUK29GUUnUT6DcYCJlYvXXQbaSHpw/pprybfoS3wNKxpaqNOo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+XiOrnZpE6WuyXIiLGzlzPZHFQqLlnM01GU229a5yo=;
 b=kh5T/+b0KWfcg1bkCrKsRKOBfDabliObZ5sPqX576iB+/FjgVRoAJLRePWhemIoPPmlYVoI53kvV8duScFSv+P1nmtTmlKSGChMYWltKssbbDaW4xTNB8EX/MxLoddMx+bUxgiuinkp/ap6kR8NE1X3qDjUixM1OA6JYgYSlNEQ0qLO7Ly6feqMkKFPCmbwokOKdrws3/Dkd02eAUdulVftUlvKdCugig7XdUOGknnQZ+It6q6P4bb/G+Ow7WhVkCVK63ztLCl6fUeHNYZyOGOwBB1PCZwCaA36qkA3uCb41ySMse28pBKUUQJYJx3jXjaJ1ybuvMJQu8qMEYDx1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 11:55:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 11:55:52 +0000
Date: Wed, 23 Apr 2025 08:55:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250423115551.GC1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: d724e292-cd1d-406a-e438-08dd825dcbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1SI80xwaGN6yxnm9WgUsjHGHsq5UZOS2SjCEIDRrX1XrOIpFg8JEYbK0yX5?=
 =?us-ascii?Q?DgF0l0il+hlBBiV1embD1egDgf85syzn41hJjJRvkinFXZIDvLKBQ/4kqek6?=
 =?us-ascii?Q?XiTUY9NBnVwCHxq/423aurxhl+pmBMmJtorZ7PVUcFq6zXWkQTYIAs0zCz1e?=
 =?us-ascii?Q?WhTED4qMkWKqrF/GFIpP+ZpxtN23JNQ1gEVP39n42obw3R0J5aX6tEcMMB/a?=
 =?us-ascii?Q?Hw4k0KXaN5zz9BZViFapDyC0lWJm7F1YCEPCebzhlRvfLyqCx0GNjacnkMLL?=
 =?us-ascii?Q?9k8oKv28U5pQ88XichqS5gYQKqqYJkG+C2bzTjRV/9cd6q3Ar9WMHM7/QvQj?=
 =?us-ascii?Q?USbHAS+gIGjByZFg2UmUq8qn9+R2/9u6rVVv041DHNnEgob+3xlzTPLNonPy?=
 =?us-ascii?Q?l6oNfsfgYmmb/N/McL9ECr21n9ixPXzEuZWH4eTpXHOA97n9W2vqp4BF+x20?=
 =?us-ascii?Q?UWVPqN/v5tf1O3DbBsNttSfv2ShfnltcpkMpbS7218yDpEMRo+xon6mK7W6l?=
 =?us-ascii?Q?QuCBJdHMNqRvTQhPBKR1IIVgkkEWmON3WEB483aRvUtgdWHv9RG9XFvJumYa?=
 =?us-ascii?Q?lw/+hVihjjnJAhmKcUHJBQ7IhRbvGog7mun2kmfvMB8f3Km9ORAUaE+MMDq3?=
 =?us-ascii?Q?3zo5AJ3XDdPJvOSBXRuGOf2hbAl0da3+zAkQoXMwgSrYtChuXe8xJ+Ks4FEN?=
 =?us-ascii?Q?MkP+/r/bZXBfaynGTKEz8pXHZCNyQQCSdy2/G3OyOmnaFz9tTp/6zugTvCum?=
 =?us-ascii?Q?c4mtHAa7UYE3rbcvVKf7oucvRLIwxyn9ylj9LzYMMFuK28grhpINj5/0rw+7?=
 =?us-ascii?Q?pBi4CCwDzqmkqe9u7mZsuHSiVdFrxkHkNiIfHpIaI/buHkncsJaiAjuLmKhZ?=
 =?us-ascii?Q?Cwntpag0B04fFggdGWrear0qy/WViJuS7mTOoLNsKvLV2cvqkkYL8KiCI2bF?=
 =?us-ascii?Q?VuGVbw08TXhAp9QIq1gfUpK0jlCbneFIhIuetiBo9uN5jo63j5B2Yx7A7ajK?=
 =?us-ascii?Q?gNEUKjE5GocHu5PRDxjYdL4k5eBYFERu9QOSOFKlFd53A0d5BMfRGlUTODq6?=
 =?us-ascii?Q?k0WhtQj7c2omjVGIG3kkQBQ0Scz+xEUQlDZaSeCIgOgC94l7JlvWWEyrrJaP?=
 =?us-ascii?Q?Sk6Dta6dXqnOPchbBUoso5kdt0T7zFolrt1vqKQ9bTcwr6uqw475UomsfVKK?=
 =?us-ascii?Q?VdFtqYF1Wnpy+nT42mQX1qeb96bUPdE2Fj4CBn7R8DTA2oaPq2WcYVCvyG7p?=
 =?us-ascii?Q?/PCYmnwjZ2AlQO7VP0G9LqYhZ5xJ5VV6B2cz9b6hZigXc7RJThKGGDL4GBBS?=
 =?us-ascii?Q?SDgnBU0lbku5F0Msb20AodlrIDGavl9nFMtX4EGrgbGLEzXJgRj/er+Cgutb?=
 =?us-ascii?Q?Bthk3rCzii9LyUagr7HhdQmAjiJMZnW56wjMLEEjtXMuayN+PGdIBVjiSZP9?=
 =?us-ascii?Q?35M1MBmoZ94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVFmE2hQKr5Jf+jkRHiW6FLTSAKcwJ6w/YloX/7vUW+sJvcq+gbb7BpIiu7B?=
 =?us-ascii?Q?VgtXEE7dGIrwdU5dUctK384XL6KpWKCwGxRcUGwHDA0cL8EKHW1h/wb3PhKi?=
 =?us-ascii?Q?jmAwyz+yr+LSI9KaGa2ApOxq7AAkTCHkP7vOXwoqt4hcwh+h8XK6qgRNOH7k?=
 =?us-ascii?Q?oU1hJLtYI1cjPfJj2+h7RRXmZGWvW96vcboJeBet0UMsrTvm8UYX6ySNN02P?=
 =?us-ascii?Q?+aqQO73RkXZnk+Cht/TztHGDMzjDSLK2tzNbOsQvV0c/eT2WMxUIgY+Dz7aI?=
 =?us-ascii?Q?H3g2+HDptKLDfDbkAM1bZcU1MG6kPbdSYBmaOgKXymB66ZVU8Jkv2OmMqqZc?=
 =?us-ascii?Q?P2k37e6h+nWF2AQmhyQyw3BK0zu9fpIwhyiA+pDykIk2VrBGMeb8HbYOoX4B?=
 =?us-ascii?Q?C5DJ0TaIYpkBlDmYFqKeC0Gow5fBRVAR7hPPF9u/OV+KPLGcuC49mCjnZcpq?=
 =?us-ascii?Q?zO3/ZwiCaNUXhb8N6/61Autp4kx5QnqdT5xo4q4rUjOaOCMKuRWDPXX/qqrg?=
 =?us-ascii?Q?aUWipgJ87dE1Scbae8Y1rr1N8SRQxv8btk9xikrBJRnIULeuvvob2RL80+Z8?=
 =?us-ascii?Q?A3nCTLz277E4342oblAQkqAHIGRwEt+qar/wbvWjFMZ+MMwvocZUAxObny8r?=
 =?us-ascii?Q?RGIKlewgcIBsPTlltHF7Y1CkzOtQsM2vCdcE4nl2eWh6MiD3unuNdvqnX/Px?=
 =?us-ascii?Q?oeENq29VAhMfzFYlyuSmkVMOFdlbyIl+XjXZKf+CqRpFemx46LduU0gsrfd4?=
 =?us-ascii?Q?JQ52coO1JBplKhgqK14oqxkcq1juFfqzFVRbK0zjl85HmdHEOLPpJ2zwjcq9?=
 =?us-ascii?Q?pPgnC7nrNflkcpHDIfwDQ1/P+o9NcDXvht7GF/msjxSFygqBEQ0YIlrjZDzh?=
 =?us-ascii?Q?1NAUYRy5PnldLSV3TspWslogk31XIzdyJ3Ocrnaj1CIJcv/5NwKrEHXQyM6j?=
 =?us-ascii?Q?yxN2dnDNZNzWLa7U0WbdrR7PQut5s5M+KtuZQP71DcLktl61QO1KUIjNzjlf?=
 =?us-ascii?Q?NOEnHxIZlizWo0XsaLhAUclVxnKEa3vMV+Xi+lXSPLCRz/aWsncrPphZ0TKT?=
 =?us-ascii?Q?7m+0mLZSyaZmpBpmGJSCVW/JBqfCuYIKqMYyNutH4+ZW98jzDXWqOCIwr3+S?=
 =?us-ascii?Q?BffhqHCK9RTfWAr+0hAgB1Vg9NIKpxmioPPVqcx6eKkhFNY38MD4uZwz6MPT?=
 =?us-ascii?Q?76XegKIqukCJlRxqYwFmCrf4fBEFud92DuiyH6qTHJivY4Fbgnyn0svmXO9q?=
 =?us-ascii?Q?OjSvhEd6w3TygSgcWlUlRb/hODCgQP15RINYpIXHHAsmydeYFH1nui7wRZDQ?=
 =?us-ascii?Q?RiwhFVPaIse93EI2Q/ioJnFs8nqQmh87JghNdEOup550wsnjA/ZC7E4Y/85q?=
 =?us-ascii?Q?3bPOKlqkbKoWqlmx46Km1szCbbgmKvjB8hwBGBpwGvFj2CTatmYvIOF0eh9X?=
 =?us-ascii?Q?+d3xbw25W1t6dw7dXm4FK5U4mVmrSSs8UBS8A3AJimzJhBeKVqarFOkh+VTc?=
 =?us-ascii?Q?maPIJhJ/b/5NUcWGAI/NLk6/JaprtWAn3UOlk5+pljg/T0ihscatLxhnaBc7?=
 =?us-ascii?Q?GEFuDBGijy18Plgxmg3kOrSgh+1mZgdTxMLse314?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d724e292-cd1d-406a-e438-08dd825dcbea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:55:52.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv2Ba+okItAPqUI2+066uoj1ws9VQxeGevCfkN70inbvJncPC5bRrpYbRpkUPFHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

On Wed, Apr 23, 2025 at 08:05:49AM +0000, Tian, Kevin wrote:

> It's not a good idea having the kernel trust the VMM. 

It certainly shouldn't trust it, but it can validate the VMM's choice
and generate a failure if it isn't good.

> Also I'm not
> sure the contiguity is guaranteed all the time with huge page
> (e.g. if just using THP).

If things are aligned then the contiguity will work out. Ie a 64K
aligned allocation on a 2M GPA is fine. I don't think there are
edge cases where a GPA will be fragmented. It does rely on the VMM
always getting some kind of huge page and then pinning it in iommufd.

IMHO this is bad HW design, but it is what it is..

> btw does smmu only read the cmdq or also update some fields
> in the queue? If the latter, then it also brings a security hole 
> as a malicious  VMM could violate the contiguity requirement
> to instruct the smmu to touch pages which don't belong to 
> it...

This really must be prevented. I haven't looked closely here, but the
GPA -> PA mapping should go through the IOAS and that should generate
a page list and that should be validated for contiguity.

It also needs to act like a mdev and lock down the part of the IOAS
that provides that memory so the pin can't be released and UAF things.

Jason

