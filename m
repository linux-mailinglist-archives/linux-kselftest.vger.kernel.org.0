Return-Path: <linux-kselftest+bounces-18422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15A987980
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 21:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A3A1C22D06
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0615C14D;
	Thu, 26 Sep 2024 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r70PnH+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A118C1F
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377608; cv=fail; b=ZxGIaYWgBMszw3qikJqx7nn36h7h7CME/XVQRNR6k2tCtJEv4R50uSmQeFu+/UH2/xtY03e/2DhIPfgm57T0KqkMsXzAFheVBe8aVOpNdkP3bc5JiaaHPju5uh7vnNRvK+UMGk8RGqTwk9d0hwMQwyUyqXkXSe5aC6eaccoF//w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377608; c=relaxed/simple;
	bh=mkpyLHpbeZqQNixm7VLmMnvsKUmwVlM6nNn1YoHXxeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWgfYvariYqNIex/N6Yp1PRc4/tp//bNT6xMGrFioc+JBPgvPS9AugxULvndph8mj/IXx3rWhprjvXjFmBWRFvUDSNBO4n1R+ix0elVYC/6rMvVZcZzj6n+F5hno+ELxVOcUQ0xxSui/PxZnBiZtB8d5XH6QuLny6eJw1TK9plM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r70PnH+9; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJMfOorMwTKzUWkLhVEG7vUPcVG6XDO2I4C55Hg/5CLmjLIO42CsxGkUk065Pjq2nIYtT5+2Sib9XcT+Q458I1LKiw9ukxDpo8f7KMEjuvU6/i5mv8VG+BqF6/UEifyT4XGCWxH3yIBs4ejgDIcqRDDbOQ+5VwL4BQ1g4Be5LP4JJpJ64Hkc8ESe8Ldi2TQoJ//upoEYVjpg+N/enR6uSZpP71xegAGIYqesDDdL0spH0oNkQlf7uKryoIhtVF8pYzNrpho9CWK6ta5ONF5ivSn9r9Gz0s3B3NIutlGGb7LHI3P2w9D2Fi4kD5rdlvzFsA8sc+frSqd/7+SSqFKYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w12Ntd4dUetK3bfgyKwQMTDC/vGI0QOXjgnr7QULFXA=;
 b=egxueWSNupGLWWVQcYL/g3/p+H30GUBOuTHGXJGtWdo9Rd/HdjRWhKfmowpXNneOS+/wmMn8DSNVDOc9mhjXG98Ts9nlv9vw9CuKohSjpdyRGlG6d5Za9528gOkM5O7KyluCMY1Noh2JHAgKNVrdBOg4hCp686iG6H/Suaz2V8EV+mDliLNIatQcY8rgFzjFlQrwbzICEiyuQyhnSUoqBOYRltooC1BJ4TspCIfg/BN9uXeMRkCkPFqis9+PaFgEWbuyZuKyIzJbSzEtBplXameCSD8rQOx5+jYqnGjpKHIIrJrD0a6thcRpfRlU+x4oewZ0fHkbj353reUvwOdcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w12Ntd4dUetK3bfgyKwQMTDC/vGI0QOXjgnr7QULFXA=;
 b=r70PnH+9v/pVqP8fuImCO9+TfHoweonw/ZzIeJqsfnrQnzzXBNQ5qBgtNiMNAZXk6205coGd2gSBrOBr3oa02RJadJJQaTGDc3mH7N6fS6ldKw1xnrnZfkLoTIKkKE+FYOKBmJemjaUN2buyzEFq9wm+30N2OqSNpaPwUXCvfjgfzjZZ8rszHFTzW7dmt9gkbNVXyq+KUjYD1UwkWmzvljICXbA+xER2UWe1aoFU7Z65bpvvLnA0xRGfzY8vbrbR4Hpd9uOZo9gR/fR2rd89abZqCcL46IOHCeOfX2BoMTfAlBON03uU8wcKzYzKPj/sjVxggIUaL+WK6K25rokuAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:06:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:06:43 +0000
Date: Thu, 26 Sep 2024 16:06:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
	iommu@lists.linux.dev, zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 6/6] iommu: Make set_dev_pasid op support domain
 replacement
Message-ID: <20240926190641.GJ9417@nvidia.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912130427.10119-7-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:208:32a::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cfaf5f-4456-4438-ace8-08dcde5e5bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpEV8rHwzsiv/RjpSjK6RK1fqIypOmtoODzsUODT7UQFnpY/3KlNTFCFDy2i?=
 =?us-ascii?Q?LvS/rFF9ere+Jw1cjb0XbBnvBOdtK7BUM+AieL6VFMqJwyxmxmxEex6NhVMx?=
 =?us-ascii?Q?mYc+EP9ABqCG2t7/38hLLjjmiZz7yQO/8N297+hK9GXwD+Ms0TtmHf06i9z6?=
 =?us-ascii?Q?6eHt2+VjEwkRbl/pfQ82kA/mL2cjCLHjtSyC/Vg4Jz8V/M0MW5DUCno/aGhZ?=
 =?us-ascii?Q?BPhFG3+mvjq7y2JIykvJypsb45D3nWG/VmM/YJBooQa+q5yJzvepxJR4EtP1?=
 =?us-ascii?Q?++Z1yI5iDA41ip+Arxr0TZV7Kw2NYZb0/1D+no60OcBoskIr+dMLLkmj8qdU?=
 =?us-ascii?Q?/egZdebgMMUiKCewGTful4gr5PBhdkM8A34I3BWPOG888K+nnHgWUX4Vj6Xl?=
 =?us-ascii?Q?Y8Nt/ZdTuV1vI7DpWYVpTvLZjs3uhxzU6jM9VHZFDIyoSKfDjS6aV3z1Qfiw?=
 =?us-ascii?Q?vrJlMTNDPoEOZ/iLGTNAQgB7FjFv0FHsKKrPDUXUmq+n7nmj2Z4MJBokHM3P?=
 =?us-ascii?Q?HYe8xpaVJLMLMgUUkhrEeaGtNVlXddnihDVGgBIsRXzllSM03I0VJYahUbVp?=
 =?us-ascii?Q?p+GZNkkRe4k3ln6K640NItIUlZ6EvE9QVhmYb+X4vybj4YWZTHjFFQJiAYwT?=
 =?us-ascii?Q?epT8lXSJ8wBJhgIU6w+VvoRgYqnSXuU/gmiKm9Dj2a5WiBxB2V2mA7oMAEfI?=
 =?us-ascii?Q?HgtkD+mn8eght+vpjlEHUpLhADvPNEaD2mtisd8w0lMnilNsZXwzd0rPATIi?=
 =?us-ascii?Q?xr8vasGIlBnfxC/eDXGndIKg4kEaPZ4b+pqJh9/vADxOWfTFsw5H+YHT3IoB?=
 =?us-ascii?Q?vJPV1v3/ZBLcW9cg4W8EEosMn90AeWgWr8VcqNyB7CUaSMZ1HGFYfU9WJeeh?=
 =?us-ascii?Q?bPEzFUX8nRgdwSAzPBmezLEIzS6Ni5auOk3eKz7k9oC103VKzGWVrnflyHzY?=
 =?us-ascii?Q?PfvER4216f2n+KR0Jwts1gIh6zp6k9kbWPh3UMkGro4aOlOsk2N/GZ7HMcsG?=
 =?us-ascii?Q?9z8Bl2HG4dXa5GxnKRWOrvnIyevE1hZStSr4JEzn0/ZFEnD8SWq0OjUJO+eH?=
 =?us-ascii?Q?bQtTmP6b4WoGLYMtoylZYLFcD78I3/kFgWRSTmZrFMdjG9KICGwBkVdxImJo?=
 =?us-ascii?Q?GhK7O98ERuTYDuygSW8wky29aNj4/drMuX+lbukdBOkSDGfLn5xQTnezypjp?=
 =?us-ascii?Q?TNoEqZ0Fq1HurFB743w0IpdgYmXXgDHVCLDFzsSfNbKZTEub7pCulWCMFG/I?=
 =?us-ascii?Q?2oOm6sGfKx7Wswp/gO0kRj3jlA8xg0Q1HdsVJcHg6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRFK3tZRNSuEPYL3M8+8AeIPmf7q90bh6JxqH9soliyJT/qg6SEbXSdO56Ri?=
 =?us-ascii?Q?ss8C61ryhhkUy6j/qE+XEoq07aP5ngBgv3auaWLxjBbhWdoRfY3sXzFBE1x4?=
 =?us-ascii?Q?s06GD7runWqegtQc0sXlluTABlfjFx6MO/KLQbIPq/OkPzXWcNu15dndRtIP?=
 =?us-ascii?Q?vbCow7IZRWv76osFn6Ut5v28bkJ0LE7A9W5lL//PHV6OusUh8duQET9nO2ow?=
 =?us-ascii?Q?v4ggMKM2/VpNVqx4VNTZTFzZAw43H9VIX/Waj+9Tb7Q9fxG0an5ZkX4a1vnv?=
 =?us-ascii?Q?cFX8clfiD7aAWGEtMtjDFqdqOUUJfhdQpO2KYvdWDAUZJtELV+s7e6c0muug?=
 =?us-ascii?Q?OnejX+bDVyLxzpRojEIY8HJpZdj2l5N/5/OncDpVYZld74JIiMc7lhQinHWo?=
 =?us-ascii?Q?BZeBwnAsJDORs1/tlkydXV6PH77HL14q5h4H8pD6cS08LL1WQBPNJ4xDU90M?=
 =?us-ascii?Q?kNhU/jd+I6bQIFadbGG/kULdZLKkHt6jBcXTj2lrYsxUo3nggF7BGyW+O27e?=
 =?us-ascii?Q?qvmaRw29uKL+amBlq9RYFypya444IsOJlId0SaATzbOl2h8Zzc+/uK2uDeeh?=
 =?us-ascii?Q?FaIti5lCwXlp9zSXn1If0exgxUF1N3NOF/YXuTn2/2ACWCp9Pr2eMHvA2mrQ?=
 =?us-ascii?Q?h9ajfw3i2F3TMQX7lhD/dPBqAItIjZrSaMqcFRooZYIfWYyJxqBmZ0SPLhvt?=
 =?us-ascii?Q?pOSJEvKNMBBLZyY3m9dBlEvmLivculThNymhknfxc751gaXEg+DAY2xlTzFS?=
 =?us-ascii?Q?BZeibQvoM7X28kUSCm7HMsLbYcr2SidHRZ3jJdLpV6ufxgcG1bqfkief+CMF?=
 =?us-ascii?Q?o1/x3lty4aw+XJYdKnAstsweHkt6Yk3vwAA8tc3wYEynItZJ3sbM/QzBv1ut?=
 =?us-ascii?Q?WJpoxqy5XbtTtguF9zLQFZCBa/h9WwRSJ5RHyFr6169e5S7mpq5qf9Kr9KmF?=
 =?us-ascii?Q?zm+QLu4D1yejaIcQV6pI5/+sXA+3hGri1FuhM6i7w+GfLBLL3GwNnlI5xXZ7?=
 =?us-ascii?Q?enhS0YXJfAkgmDtcShcnqdfrLU1fMzmicP563rbwvzZDWZPzb8xGL62Kf/x3?=
 =?us-ascii?Q?peoX4AtCTkNyUJzKHZm2jHVHgc6jgUmOCQcIN63qZUV5CaWOdue4t6PkJwl+?=
 =?us-ascii?Q?TWqJZzHjO85Y65AbILppLAgQICk1JAuetL6KhD4197/ViMEU23HezfHcMcCJ?=
 =?us-ascii?Q?CejZutWx4UCmwkC6Pm81YQ4mzFqq95r9thjUooJCDuyT3XjJV1z+hkSKWxrP?=
 =?us-ascii?Q?cvFVW0Kx3TYGUTR1UBdAPaWW+z73OoNPJF48YsiEHKZXw65IzqCC3+i79XMA?=
 =?us-ascii?Q?aF8I5pk85G5uv4H8bgud/Le+OverCfMOhVt5ZCWMOOgvqAwHlWxDhGLDbpip?=
 =?us-ascii?Q?OpqP4vM7Gxn2SamkWxg9aAIkjc50FGPUT5jO1jYXCLxIQUKRcgfCOerIpRGD?=
 =?us-ascii?Q?hW8Nq17dQeKnmEQwAjorN76+dhn1cTPJsdTbc3p5i/871FV9+cFMz0rBCVf5?=
 =?us-ascii?Q?vTrZy/SFn0JgvRYETb0qmw+ui2Y4fHZxedEZWuuSoySASBBR24WbYO4ll29w?=
 =?us-ascii?Q?PQi/zM1Eld0Ucyrsd6I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cfaf5f-4456-4438-ace8-08dcde5e5bc9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:06:42.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o86yLBoUGym4PI1BZ4KYKZyMw/7BH73Yl2WCdEKi7+4OFIDOly4pBIS91N51Yh7/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

On Thu, Sep 12, 2024 at 06:04:27AM -0700, Yi Liu wrote:
> The iommu core is going to support domain replacement for pasid, it needs
> to make the set_dev_pasid op support replacing domain and keep the old
> domain config in the failure case.
> 
> AMD iommu driver does not support domain replacement for pasid yet, so it
> would fail the set_dev_pasid op to keep the old config if the input @old
> is non-NULL.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/amd/pasid.c | 3 +++
>  include/linux/iommu.h     | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

