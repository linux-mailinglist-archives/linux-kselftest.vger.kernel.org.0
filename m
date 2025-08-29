Return-Path: <linux-kselftest+bounces-40329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2AB3C221
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618611C80860
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9433EAE9;
	Fri, 29 Aug 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H19A9Dre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFE32039E;
	Fri, 29 Aug 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490232; cv=fail; b=U6lFTS65vJ7OLMGSTkx4DF7YXd1zdvhEubQiAva0p7P6lBl0pyACNC6qHWC7XJJ2jZS0I7u70WS8qol/cF40TYrz6RpIbTMq5wpApCfWvm98iTyou5bg+8BAJpW91UeLgcjk/DOx1Qq7R/f7Gm49uJ+Z9zZK4irW41xw7iu8FSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490232; c=relaxed/simple;
	bh=tDz7sfV8vx5/9FOlADz+s1q9GYRrxVlCXZXYqThy6T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gkTcwSKMOO15xs8mYLjDBRhoRNrgGiDdM7tuhvu26P0a0KJFlTekJhBFH7hqEJKjeZT7XzMfsDZ8PLU6kWaBdLqrCAoTBxPdHQl+FvO6qr8JIUUAv6tkk9E4feVzEAaZ3Hy2xfMhHkxwwCiTRmoCMicM6BdS5m6oVMqzr27F++8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H19A9Dre; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgeHd0kPmVYYZfx7UE6gFeWN0JhiEjXNtEjtvlRyEhC41e93qhrvFVl+BPkIkYEIddvtn2l02oy96kWwHs1ki4NPttIX3m4d4bjhGRvf95OBvAYMy5XdvGV3KYzzbxyZReR+DUXq2RGnrLfALFtX8Q2idJrGt3sfe0WSIQFViB6qi40RRsLjqynr6e+bPrkVeW4Lis82YHBRESJ1QtYhJKKZrK1SECRu2Q5nhm3d0BXc7fKpot8m1FVGOJBTxAAqzpzqcgV0fgdKKhUtMcDAtm7OjqvNFi9po9Ip1wZjuuB/yEP/8aI7wIihLACGRnxoPxECJKjJYrFhZu+LVWRiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwv697WQ6UF2V0WRWqmVF1DF0IwBf6cAOh1yLzmSCAs=;
 b=vkKO227bm5ViPuCqxlZcneS94f+u9hKxTtTVggsT/woE2XnEVaMXI46PvB3F6c4xBfs9wyXW7c9bS15t/+WvmYTxsWT0u6DAydbMkzKUxrbb83oKpL0sot19vosSBv9dYPNIhqj2w9d7PNsn6YziSz8YtHB0AlzfZmY/obwhXJVh4ly6r9FBm7dbvpkADPrwZbJHoui3xgdtgIGTJ7WH5MyXH4ol3Tu6LlZ4GwaBRNUskxuUwXdeRUWYa2fan0r4TSWnGR7Gb9IraPYy3VHfPot3RSCOHTHa7X6zSIfFrtNc32SRdmEvHlm9NBmMuIg/V+L/7eQyUFVSKv8UCL0Rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwv697WQ6UF2V0WRWqmVF1DF0IwBf6cAOh1yLzmSCAs=;
 b=H19A9Drev6HUxOrd+2hdsrY7aLBu6eGk49aujYo/8g+gv7TJP3vNUMvtfKfz/1ja7e0rjCEZFNLZxNc6RuNj5rXInJQ3awFhjZW/uDJx5QFpQvwXxMM63tfzzN+XmftmjP1fkqg1BZu9ZK0AHCkvkFAYJobNkTGUiBokNxf7L/BZpJSux+Qy4q41ZfYkW3x/I8xJUApHuzKqBAz94ktv0t0BeBhV12Jv+eZGcZQXsjkDHF3vxIkofMZyxx3mNCEr/bMP3C0u9a54u+YbUUY8Zt1VKTdp54eDslbeL2KPHweQLpTsxQlIHjEIcLAZmD8g+7rc7daOcW7V/EuIG3XY4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:57:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 17:57:01 +0000
Date: Fri, 29 Aug 2025 14:56:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v4 11/15] iommufd: Change the selftest to use iommupt
 instead of xarray
Message-ID: <20250829175659.GC79520@nvidia.com>
References: <11-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <08421ad9-12cb-4d1e-b777-343b27d82467@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08421ad9-12cb-4d1e-b777-343b27d82467@infradead.org>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6810be2d-fbf4-4e2a-70fa-08dde7257474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vp1Loywyt6+Skri29TJ1SKwhvla5HAv+G2hF0FTeUXSgPmcMCa+D4biUlGcu?=
 =?us-ascii?Q?X8FJBZDIoj9EpDTvDxY5jSjiXUOntf49MGKVc9lMdsPMYUNlqlXEaIGvI1A/?=
 =?us-ascii?Q?KIuMUBxS3NnCS+MQuS2haxqbJ+eNHOU3n0uXC3QSv/egYGPprI4pZslxOtnj?=
 =?us-ascii?Q?YLSsrYeOE3p3mDA1YQO25laGMeciM+SaF7c/SrP/Sh4OUxujtIfk7ScFju0S?=
 =?us-ascii?Q?/TbfKjWNxxU2JopQXBeQTGrPGZAmFGSZsDyA2veZWaq+FjSrV3Wp3F5cwc3Y?=
 =?us-ascii?Q?k9To6tG24M8KkfVdf1x3atMNzd/zal9dyCA/KO0t69KJnk/U/ctn+BKjSAIK?=
 =?us-ascii?Q?ZvtVKrhRqONfYzBKgk7p3Pp+IOi1mb+BXZosTlX/2vsP4QQtA+jKBrGevOIX?=
 =?us-ascii?Q?kBdWryKabVfaVJWbsy/z4mrIwaE9pQ3k8cPkKiJ9kEmlIkGOEPF7Nea5BdUq?=
 =?us-ascii?Q?9JgvEN0ogD5AaBJQlVCECkgkbCh0FiysEnF0cKn+i51VLOFX8126312ZFkyT?=
 =?us-ascii?Q?ahCClPjuL+sykRkYS/G65Q1lLRdcE3RkGPp2045Pkjut1qxsU6ZyqHhiLrA4?=
 =?us-ascii?Q?hnW9TZ5XUr8caMEP+1pvZKgDrMV4nwld7Es4IfgVybv3mYuPsht5ZSaRqI7Q?=
 =?us-ascii?Q?QqWpA7ZdhGB1CB/GQFnFcC7IGEIStDuiG6NaqUsViHNDKRHlhiKtub3n93Ys?=
 =?us-ascii?Q?+KFlhmJ9H51QT3Jbb6ie4ZBDmXtX7oye1QRjPocYkzjbOuS4RnD/c9yqohB7?=
 =?us-ascii?Q?RlY6z7soIytKDOV2Kd+tfV+ZYHi7XQ/92xmddn8AXOldNabtU6l9Ck7uILOK?=
 =?us-ascii?Q?t7MiVr5vYe3lg/XFaQA3fKnZ61oUoTQozAWASu2iP08/VsJ1SWtOLcG4CAXz?=
 =?us-ascii?Q?niRwFAKkHqpha9CWydlpgHTRQgqnqiOpGguwZY/RxVDh08u4bgNtCWYpKbgn?=
 =?us-ascii?Q?GAFvd3icpBmSjIvht/+fim653Fxm/o20gxDeaUsWjG/k4HMmcnpSQISGLVau?=
 =?us-ascii?Q?oKuISe71apJ2cbSfqqlIluf46cZK4vFtw99UAbxXzJzLd2NHXtWxJZ5bWzxp?=
 =?us-ascii?Q?01zE/dnqFjWYnzzo2P3fsD2vwUc4SzjZBIEjQC1piWPhl5ke4cnwy5a1Uzdq?=
 =?us-ascii?Q?IrPC5I2h3USee67xPbk2u4QG8KHUXysXieXGQsxnUcdnb0okB59q3nexSyqw?=
 =?us-ascii?Q?oXZFExeL/lc3hBkWBKELRew0+2ToP8oVjtmHns85REyzUH11yDgqJGpqYJax?=
 =?us-ascii?Q?7oW93IZEo9p1mB1EBYrAro0qmOh1W0yFxsHA30+HYqv2kSNUzrmJwMGyPbL0?=
 =?us-ascii?Q?Aou2sbwPSxNVNj0qZqPxYRBERhnHVSsWnjURQzubjwteeSbSyhY//539Mltw?=
 =?us-ascii?Q?8onTR8uL8kahWppD5DTvt4T7l+QW3IV92QdSjtDQsGWZs7bejY+UAiriIEEP?=
 =?us-ascii?Q?VunK2gUuREk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuXJZhJF7dP3e/Lyzp1lVfdC4AUcno3h8Mw7HRgilU3rapmx8N98p0F1y8TO?=
 =?us-ascii?Q?zCEiTQcyIjOJzrQs6nkvpskN54I04mQKmbrWzbiGf17202krSamDPYIb4zx6?=
 =?us-ascii?Q?pG4cBroXUt6agKF9llxPn+WGGl8ttxCmwQJyuXgr6k9X74FwPlMs4YNSDSim?=
 =?us-ascii?Q?tM8zj3IjVcMPOfLykPumrjVEYT6USFJawul543YRGLy4ebgH+O8TUfSwM33I?=
 =?us-ascii?Q?bAi/Bs3BgDb6bUg0V0NuChz8Nl5a/7O5Cjavxc3ktCDcIjfFnE4UvmYP6RYh?=
 =?us-ascii?Q?HsrGkEmywvSKOGjRQnRm6Q4xBYIU1BIUjEJCmKwbcEuTbE1JiX9YtAPH9cfh?=
 =?us-ascii?Q?//cy8XX0nKLgenYGyhx+UqlBuOT59ozDIyz9LI3VP0Cfb5erJB+Hd2/LWCrp?=
 =?us-ascii?Q?Z4t8KJkW20r+VBL8vcDB/tLyGTiH76ZJ/ssHpdv1dt4dz8G+Fl+UGDWdFjEG?=
 =?us-ascii?Q?QaEH0tSx4XRHrORfFipIDIdZ7drx0BZYZ3pyci/Uw+yQUT1MPX1X3W4BrcT6?=
 =?us-ascii?Q?XHnjS66KRlx5On8LEpAyNKoEpWzJyGqJ5IzalYBMkZN3PsuwgswYXlHNiVpF?=
 =?us-ascii?Q?7w5VdtesJ3tQe13S+VxvzQYe8y8yWtL3elgfi9nvp0qubHrd65sJifSJ+C2m?=
 =?us-ascii?Q?OQcYVeoB74KgFvTuKPY7bUsSFJ7cDBqEDDNBf3b3eVvGEuGY+HQ11VAmtIRm?=
 =?us-ascii?Q?IErb3ygK5Awj7sA5S+x/5AH5XBSWPniVLvYqP7ESUgiPS3sUg5tb0/yx3pZh?=
 =?us-ascii?Q?MzASV0EjC9CgbmHKItQb4eWUkVkh+u8K6f15zIv+3buYgTcRGhgyg4/lRL9Y?=
 =?us-ascii?Q?A6gsp9PCNog6hv2CnDp0UUK0GWUDhRUb6X4aRFc5pc+V6atGJbK0+MCVKSBZ?=
 =?us-ascii?Q?pOtgYE4L6OYegXT4O/gG4fc2H/H85xop2+pQK0jNmVlSVchGVpBryOQnTU8w?=
 =?us-ascii?Q?rvWwg3SRYeEW1X40xunhU3z9OYM7C1M6TfSqBSjt7vIhUlhKRjy5ZrUjrN2U?=
 =?us-ascii?Q?pXL84s37K+Z0qekg5oIJvhzRu4lQGInlPUdU77FqlLUGfrlNCtX5EBRa1t1M?=
 =?us-ascii?Q?MRRIBRwFrZcy9VNJjiRfBZIjtwtBqUu6xIHBqWNHFSpNGfoCF+VomkG9vePb?=
 =?us-ascii?Q?TIXnhEKrREN8WX6Yp5xNuemBVHgM18dStcrduDfn9jmRDW01PPCBkn9QW7xS?=
 =?us-ascii?Q?CeJbBqHQPgf2/4BjmO5nHEjhmY9wRzqCwCtD8DK1P3gjkd5bpG7SBg3604zc?=
 =?us-ascii?Q?aHviXTjx8N2zPrh8gamxR+KPdkyIDn8M4iPFLX840g2VUGnj43zNS34tYCUj?=
 =?us-ascii?Q?297yU0WzgU/YcjftgmjGfT+kzBRHGHIThm8UwDeB4i05Mr1RNSArb6TaCoRw?=
 =?us-ascii?Q?vrtfu74EaQxl5xUOpZv656dKnCuHSZjChrWecHWebwQkhTQjAjc8xASwOVY7?=
 =?us-ascii?Q?lixRwCRbmq4x1H0WW5LPMKd/MzOQzD/tEt2spSoEfovn8ew1APRsaS6ZLlnn?=
 =?us-ascii?Q?zY1/MzYgL2u6ekNhO8VJw3P2w4CF+JHg7P/Uy7i0aG+IKXRYvsujPO8IaeTk?=
 =?us-ascii?Q?cr341vWegG9Cykj5Ovkk7VVJAVTWMjt/RtHoWUbf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6810be2d-fbf4-4e2a-70fa-08dde7257474
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:57:01.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BugHqDn7N/SuoA6b0H68CG+hj8c0iBwOiowQ6TGr2D7CinD5FU+SYjg5MQ1dfEsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

On Tue, Aug 26, 2025 at 04:33:51PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> > diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> > index cbe6433550f380..58c9fa74fb0701 100644
> > --- a/include/linux/generic_pt/iommu.h
> > +++ b/include/linux/generic_pt/iommu.h
> > @@ -73,6 +73,18 @@ struct pt_iommu_info {
> >  };
> >  
> >  struct pt_iommu_ops {
> > +	/**
> > +	 * set_dirty() - Make the iova write dirty
> 
> Should be:
> 	 * @set_dirty: Make the iova write dirty

Fixed, thanks

Jason

