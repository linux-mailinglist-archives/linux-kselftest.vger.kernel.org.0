Return-Path: <linux-kselftest+bounces-43661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA97BF6FEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA72506F45
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4620334C12;
	Tue, 21 Oct 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxXoGnuI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A635502F;
	Tue, 21 Oct 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055762; cv=fail; b=E11yMth10Wn3TULTeVZHTMO3rtMU/o6rEdxtXLjso3gzXPbF3jMRMFo19I6AUm56fYdyW9WLh+rO8+l5gLG2kaqApNdgGZjh+/6uQl55G4chDKRLNmQ7l2gvHdOFVvh9GXCmiT3eZZN8tg7lRhXs844MRpoWYsWArVhOCDb0FIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055762; c=relaxed/simple;
	bh=PpTtSDB4JkrjTSmHczKpTkEXOSj0VjUSyXbyZMnvX2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RdsO0Gj3MsAe2+kZRdCMXwJPjbZ64Z3K+6QBU/78xQFR+zGD5eIgOdlM26d+YxR01xoixwzp885volzzfV6MvwOYcsHWZLXnnWMVT949ovFogKHxEDhEb1xTLJa7oKtQbLGCePMAd9cvV2L94rDY0cOaNPQOWwPBzGd1QnPcnO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxXoGnuI; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQD1RdZxz0gkr6SCgpKXiYP66NwG5luOJ4BNbM+GV1z0la/dy/tHMfK1oX7lo+fXBzOaKQZtLq+zf7LXh5Rym89rIwqOUXgBI5kI0d9MD0bSImjb4KefxNr8lzFjW8FdLGLsy6X1IWfNgqWOW3B6+bb3JWJitQnCxlhPFYLoYqqjMIPCah25a3TpNf6QpvP+JczJHhiSnq2XZhqWx5HtP5IykNuaRvRBo68uujadEE3Elt6MgBPEjaVSp7nuzi0OR3OYvy5dHlgg2hx8igR6ROfCTF/WXLNpm9/B8U0H2l7zxYdmP1CC0EoFhkJdwGjxhR7dfyYMTghcv2hWwnFZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liwidxJXH09nbdm42+LGTfKf6zOc1I+3Ws7Lfk4LvVg=;
 b=CQpOJXDgi6ZNDHGjbaYNnP2l7cTsDutzQ4XJDYVIoyigcEq1XYmwGNd655r9harm5SZFhVznd4nGu03cbX7dyUW8e3iEciXqMJ59xDdQdSlZmeHO4bUODwCHZCFFGPKADOYslKdeUqnNbBMomQeHL/GUM2+KDCwJLOB9JJs3y5NwJm2duZ3v29xvIp9v1bw0AwzgfYo4xqlhRoIhqn/S7Q7XCbA7gtU/LV4Oao8g6kjFj4xDOzmkiSBzziMtoGwUre6C7xGnhWpK6amPvNe0NxOHkyDL1W6kKIBmAWSUnzuCJnAOITqVe7M93VbErsH9GFVze4Mtsyii0C1k2H4Zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liwidxJXH09nbdm42+LGTfKf6zOc1I+3Ws7Lfk4LvVg=;
 b=oxXoGnuITJ3tRmuwElLTH2nd03dlkNwIZR+HGCKsNe7eN9IR9vhwkpMi2oLiN5Q/Wuy2C1yra5aJqFKuY7T56wqJ7+kMJpAoxUd+JslTuP8EXz53yewOFLmYWjBTPovhNksXTqnHR1XeWZKl+zlo9HJUYHzti97ZsjA9Op2ydKGLMNXoYLfwiWCrueu0VGvlxqNRDojSQ7Vik4zLimm4sT4DCiHwoVa6/w5U05bSCKxC9TZwxlkvw1JaP5A2XQK9A0ZreaGgraWrLnXxnSHGorN001qiLrAnMB9Tg1diCwL7y5YwpP390XvhEYTKjVU5v9d+z8A1djk2Hs+/Q9P5ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 14:09:17 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:09:17 +0000
Date: Tue, 21 Oct 2025 11:09:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20251021140916.GF712833@nvidia.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <12-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276AEA18D4E2BA4132B90458CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AEA18D4E2BA4132B90458CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN6PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:805:de::18) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b4e691-d132-417f-37c4-08de10ab6c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qbc+xXfKJ5d2MR8WwrkY7sfz/pkettdp7Qj9bp6Ep94tSPC0C0Ubp19BYyjK?=
 =?us-ascii?Q?/KJfiwoRDvDJfJjouCVilpq6QZbtunBMSfRX9kY3das7OIAsk8oOg0LrwhoY?=
 =?us-ascii?Q?Bk/bacZ8x945MRJ1JHNr0Mw8iCpDYmF/wbGm8tOUobtsorcdb7X1mzwS8BRj?=
 =?us-ascii?Q?pKERTaMw1IGJVq07pLbNjD0/uK5DUhbDNvxb1kpEtQVGKAa0sKSxh7nLgxoF?=
 =?us-ascii?Q?G6iZAu6BRic6TjskH7rGGTsla/kvqNQC52y+Piu6tvYPIBtszTeHa+f89+9A?=
 =?us-ascii?Q?ZPFJX/wsNtwGIRJjdwjCtkqlOyq53bWW0Qfx/RB6QcHadWCYXyNwb/Ulvoc6?=
 =?us-ascii?Q?Bd7s64emzrro54EuklqrKD4wGTNi1gWV0WbcHY+c04qSo1mp56bb9z43HzOj?=
 =?us-ascii?Q?NNoNCoHzzAnKqNXdkRRi6pVJ+68vS7rfKsWDwucgYQam4wM6Gm5Ipt04Iepe?=
 =?us-ascii?Q?w4fDAcmXS3BRAUQi54Dk1er0N8ccYNjjfW0z3YXuW9IFG38ZxImmsvvq06MD?=
 =?us-ascii?Q?ezQZdBZ+KXZHblm1GONYP2WVDhK7zH80FkZzEMvY1FXez/z/Akm1dI4lYtkG?=
 =?us-ascii?Q?VXqdLWdMPbteQTH4GX1aoEAwK75t+ALWYwqDcZwiLReTmiUfDV1SPGbtHv5B?=
 =?us-ascii?Q?85wU9lFh5KdvOGebdMIOE3HytK1/KC+6C2X/oUnUSz1awW3qQi4nwu9W+iLn?=
 =?us-ascii?Q?vqFedSaVGIKJlxRv12AqWtQFKy7HlCueEg647nh2a2hbTg9JDDG1+CHLl6OB?=
 =?us-ascii?Q?6KasCyjyNX95G4k3haXNI8DckERrCzaxuIgol6Cay41KhQx+bT31RJZ7iNvm?=
 =?us-ascii?Q?RsaMKVqTxSSQxZVNRxtMFq4bCCv77ZfX5yeXBLHhbGyTbOi89eM7fzdTN/f/?=
 =?us-ascii?Q?3FqK6jzfJ9KEt+saHDSZzR7kMqkyScV6Or+U0BqGUoKmQf6Z/MMD98ANtgNo?=
 =?us-ascii?Q?MoWRFT0qS6mZ/WuWCl3itwT0jhD3jDFvAUzPzes5g+rMi6DdS23wDc1Hcb5J?=
 =?us-ascii?Q?I0MkrJOS7QWlvtf6oZv1qIJ6yjxWxC2wqsD81PUw26gc0kznz8Z0VzKLq/ib?=
 =?us-ascii?Q?zMhGCUsOGrFPmP787id7Gedc5PPR8+Y6xjC5qk3Jizo18bPnA8c6Up0JRYwA?=
 =?us-ascii?Q?qXkziqGVgm9Q4uCVgZrGbtARqj/8FbgldEni6zA1CPgjtwwE2fyLVLaliYQs?=
 =?us-ascii?Q?Cn6EtE2fJGmdmaDZGS2PVSTxBWRUIIRx5sauuMDGb5CrttKs6q4EyauS8AM5?=
 =?us-ascii?Q?kKyEuRkhO44Br6LkwR5+c8iHrSUlFKrnH21DdFgTP4vHrxLviTySWoE46/jN?=
 =?us-ascii?Q?bmg3/2B74v9lZFo8Q8UF1FComjNht15Hu7yePVQVZNRngReXL4FFFLxLxd3t?=
 =?us-ascii?Q?nsXwY8hleRlhLUO5B4vBS5hMg//RRrn3l7tEQkM8uPxuY6HO1T6HHguNdtid?=
 =?us-ascii?Q?ofAK/WY9b7x5PPRhZaJ/BGKFMew/icI0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ChK7cBiukmy67YkhWYmYTGvsN97f3xbqNpdncFKO8R3ntZZ4wQk8Pvg5ZC/k?=
 =?us-ascii?Q?t+j3j1PK3X9OAywQEnJp9TA2qdvjnsrinXUs0CtKjwwIDgGfUjU2gBiOQN6q?=
 =?us-ascii?Q?VHPj7OACr4GC39XS0diGHm5AgAi+P059pWIZpD1Ih2VpcRS+Vp9v++rTetNc?=
 =?us-ascii?Q?3uNr1ib+ZhuRLlB1EZ4xrkcXgyAEYI6ZUKJGE4HGuFtPvW3ExeqCmTxRQwB/?=
 =?us-ascii?Q?8yNioCxqSR54J0cxMuANjHzGuLy+QVIxlEdhEOmfdgtxmZ1rp47H0CpvE70G?=
 =?us-ascii?Q?2xXMFhJKKk31lI36Q/oEiuwWShx4UfcUxdRfW5nUhDHR9ODo3V5r3drg59cN?=
 =?us-ascii?Q?K5Io9MPm1o4Wk9CgfZcjJIaFLuDLwPefHUwNevRVubMnE7qFdvYBa9ehCsrk?=
 =?us-ascii?Q?Lfs+/GUdflZKTxvYJzUZzhwGCSPVi66p4zDbELueS21kHXLppc8s1xBuNvfK?=
 =?us-ascii?Q?ThzUs+NL7iRbvwp9VqnCi5iYis8PHkqQGcV0RdT0NYZGuKKVdvD6SNCdOERB?=
 =?us-ascii?Q?8MHvmRfmtJspbwEP0Yxm0QxmuAHYnCvu70oUkPy4fCsYCB2+1Vx6NjIb1ynn?=
 =?us-ascii?Q?2k6uw2guizRvWyKVSvYnbo71qnaqF4gAF7+zTht4VVuglOArFpAWBE5zw1Zr?=
 =?us-ascii?Q?sqx6rCiwoN30cUW4l0l1ebkhXRNO+5QnsEXOasr3j80u+crpj76Chy6EhZ8n?=
 =?us-ascii?Q?GRZ4KiYONzpZWy7YqIQncW99CugCD0JmuYdBvJW/ROAqDvm3M1jtmXIfSPgS?=
 =?us-ascii?Q?RIQFoHC7U1BxedFHU+DcitWsS/XiZ4QmY5NP5L0hNHZWf7ljUHsXL/11nA3Q?=
 =?us-ascii?Q?HFCrTbhPw9WO7eU67a3VaNsphW02x+BTuGPnRus0rRiXmnnOUbItWaDj6FfI?=
 =?us-ascii?Q?MmN10rOSr9j5UXGhW7IJ3giExE1LMR1A0Oi7nZMylwQ4c68AxE0v+qe1K10+?=
 =?us-ascii?Q?2h8dL/XBfzVvNS24y/+DZr9N9g3kI5VnNFWSSUsF2K7GwbhGYZdjzKjB4IOJ?=
 =?us-ascii?Q?YhEMsJJUwk1tcumq9zFVszS5cysNN1TfHkalofqqNgS8a2cJW204bOkezKSk?=
 =?us-ascii?Q?7dZV2eX3zDHI7TQqIetEdCtIAfCQPA7oV6JusDcf8ZrSXDlqVHpujFXkY4sB?=
 =?us-ascii?Q?o2P94WSHjA0+pjo9ewA1i/E5szqvFaioxQ7BhJg6UN9Yu+JGTsyazUVOeX4z?=
 =?us-ascii?Q?vhEws0L9x2BD5kogUOZ7bBNyKa/W4dwYuEK1VNwY7ugI2WMyX3Qcs0RARE3M?=
 =?us-ascii?Q?YWual2jtcjLyNV1ReV2RUNZJuBGVzEZZE7QsEuCzaEk9yeJp60c6SfzYoCzl?=
 =?us-ascii?Q?VrKpLr25826GYZwnMXcSRM+0mEPp7RRjWDTanAHtTctazKj22VTM7QUut5sL?=
 =?us-ascii?Q?IiEGsg2PETBrW3dhLmsbbEmjbyV3gpjZ4fki/zTKCaZ/dte0V2/BVoEvrghO?=
 =?us-ascii?Q?DghSTZql7NYKBEaXcCjJxF/U56Va3vRk4cLgvcEo8HxdxnJTw5254ZkNnVYI?=
 =?us-ascii?Q?zYf1FKIRwS2zio9hXVxdoKnVDO1RxhQHP39qgFpNELEIqe9LXTJ0Rk1LlEIS?=
 =?us-ascii?Q?s4gPquCMTGzzvBPNn9e39cXwpLoy/e6hsJZmkAfk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4e691-d132-417f-37c4-08de10ab6c4e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:09:17.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqqO+eYEGODvyrgemlP/eNlvD5PuKETrdE1AaAviKYLoAPmh0qobC9Vhjwd+lWCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026

On Thu, Oct 16, 2025 at 06:55:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 8, 2025 12:12 AM
> > 
> > This is used by x86 CPUs and can be used in AMD/VT-D x86 IOMMUs. When
> > a
> > x86 IOMMU is running SVA it is using this page table format.
> 
> SVA does use this format but mentioning it is a bit confusing here as
> the SVA page table is managed by mm. 

This is used by x86 CPUs and can be used in AMD/VT-d x86 IOMMUs. When a
x86 IOMMU is running SVA the MM will be using this format.

Thanks,
Jason

