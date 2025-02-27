Return-Path: <linux-kselftest+bounces-27776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03979A48306
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C53816F0F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4125F7BB;
	Thu, 27 Feb 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dFDuJiN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBA13AA5D;
	Thu, 27 Feb 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670369; cv=fail; b=FCm0nSqnwUedF4mEzDl72KW4NUc+T8AbMZ7X3sm1tj/ZWV/x66KFf/47X/gvjPA8A97efE+pQf42n4lG8RllkCem4NhMcZ6u95wF6lft9g+8Hb7kHLwSbaL+tPEOf5CMCP4K4dG0Gudv3yz0isK2l73YTqNKSFjb1tLFRhnB6X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670369; c=relaxed/simple;
	bh=9Zh6XMyampM+o+7OhrMM0i3Ot1PlX/e2mMFn4n+hEzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W0yxPx7/2fd0nrtt+pZ0+oeqeIGINLKk5gcnuBU97wDwwwwIjfRqn0VcJFgO5p5D8alsjsTO/GklpATW+Xpr1a1C5OS3ZDWuutv5Edpoyubww+tFj1IC0m/juPgB8re7z1mt+EOr3j26cLIZbluWzzAFKJeFVJzIzWWmK0j2Evw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dFDuJiN/; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+GcWN10KOeD8/YPlYYoqHfZVUyVD2wLp4i8RoyAHacRKtzVFxYYPZ0YPpOiSPIA80F3tvTu0g7OZWiw/sAp+tNK16lbe2nCPJFKLkfGGBxK6ELZDJDs1MnCoqH9Xxy1fQRFDlVV0pGFvvgCgQwCI/GU7d+aoD6a1y5ZdVPI01RTYCSwlC81AF95RVY8GZqbEdd5by8bVdFzhulVV496SQFLudaIBociE8MhjVMAZyIra2CjFJQKu3qPwN7GfZTuqSuH8bms5LE2mXh4tnPFVkhDOyhEI263ZsJuVMHVkoF+hbEmLAtFCqKk3rt6UQdpay6/YYIk77mZofptpLgrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zh6XMyampM+o+7OhrMM0i3Ot1PlX/e2mMFn4n+hEzM=;
 b=P2MUdjua7+im7uDoO+4YDW51m4hlLLIq9O4aqvzNKH0FALTyANcBu6fqxb8L2S4sDxuxrWjgbNepXWQdrNB8ZIE7okwaTCyfpzvxsfsRTtPwCLQ67d2gSO1q1F9o+CPRC53JcB8iFpgDjtP+v+AkHv/20z1MEYwnrSNFXKLkxhO0kiBppT2rxv3ucrY+5P+V1cDaOYqXIunlPBJ6Oro0nkZaSasObnyMeKq+oNvQA/LAiuy+ivlC1CXi2OD9TOTuTJkywxQEhrcU5xkHjaYL97Nkhcym3LuDnbPlzl8ObBYp7PjkhIs13LTEPNyqOSL0eHz3GEqphRqrXbFOcxCKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zh6XMyampM+o+7OhrMM0i3Ot1PlX/e2mMFn4n+hEzM=;
 b=dFDuJiN/fmsLtftrQePiE3VaQT9y8fc4oxTJ4G74gGfY1cVBAUBgoAsfUi8gY5a7WK7M5o5UDicj4ESh/7yHEGBLCL1Ad9mX0DfduVGaiiuTvEYrnzufIzVNeHm+y0ByUDVRee3Ux+13b6WDkEgZEgRyOvZ6ukKmS6+Rn+hQ6z8LVXpmS4/dWDLWoCr/H48wY+NgfkKPIYLjLBEB8tg0CAjYcfX2rkpH28PaC7JELyKb1Esex4gdYBCoiI/ULs3ZUm9zuPv220fUpb1QMjDqg4aEvVwy7ifKrDtNNsYIJX1q77/Byn9jKy6p2rwRU5fnVR9/0lRhmpcD8uZ5DD/01w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Thu, 27 Feb
 2025 15:32:44 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 15:32:44 +0000
Date: Thu, 27 Feb 2025 11:32:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	tglx@linutronix.de, maz@kernel.org, joro@8bytes.org,
	will@kernel.org, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 3/7] iommu: Make iommu_dma_prepare_msi() into a
 generic operation
Message-ID: <20250227153242.GG39591@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
 <5b9e15e1-8081-46ef-b9db-3872e98a6f35@arm.com>
 <20250221164400.GN50639@nvidia.com>
 <634c60ea-fec3-43ad-923a-cf9ba5e76065@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634c60ea-fec3-43ad-923a-cf9ba5e76065@arm.com>
X-ClientProxiedBy: BL1PR13CA0404.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::19) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b050f2c-fd06-475d-0742-08dd5743faab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OKn1r7/8vOGoJ1nkN3BHg/PP2nTBr/H13fwaJRfhyyUL+jPo8yN17LWaE+ib?=
 =?us-ascii?Q?7GYhk0zntWXjv12VrQH6Y/vAvkU7FmhGlI6JfyjV0Trsoo2hYFPX3SBqry7u?=
 =?us-ascii?Q?CweIWGiS9ImOT5XruJ2IuJxvno/52L/1eOWQKi7ekq8hNxCfjBFEyUDbaY2+?=
 =?us-ascii?Q?kUzzHcjHHRQGEXrNshfDwOvtlmrnVOXBF415OfpHDnogkjcuZ8g4Map2YbYz?=
 =?us-ascii?Q?TOHMwOR4OhwWorqNNGIa92zQaEiHH1+/ubWlgRuAN+GPUF6b32YllIli3FTS?=
 =?us-ascii?Q?qXURMKqBPJvODSEU8XKZ3BD8kcOjKINRbgqaaSNs5SFTozwyUlEvj32lbVre?=
 =?us-ascii?Q?Ha2DWoMyTL1SVBI+LTR9i/ebGwMDmi0FzQMN9PUi2CLiBjHokWi2BqKnReM6?=
 =?us-ascii?Q?2dTf6EVCS1DKHdKk5lDZZtxEbODN5tnJRfJs7lxBsRouOV8lCTW1SmlgozPD?=
 =?us-ascii?Q?wSQmUOQdn4hY3KNh6R7Wn+XvqEuPMtkZSeWPWx7sy5nyuv/dhxXD1+8Lhaa1?=
 =?us-ascii?Q?9eBlsmAh2QcMccUKf5GylDjWL4N2aOX0F8fNZSDSX8+aIjvJw1wpESa1wFJW?=
 =?us-ascii?Q?PFL3Uykb4gqMqYb1iQkpHjgJszPZElD7UnViflBIR2BKgxACMYS7xAvCAH0P?=
 =?us-ascii?Q?59nXmdnxXgoQ8/aI1+i1ec1gcjClowlH6vjAQO96ih4J3MdvGOfhplZLI7aM?=
 =?us-ascii?Q?z22Bq6AQ12BYuQrBR4XW/0qDbwuOgqcSeedcSba73L/J1rswtlreRV9p7n1u?=
 =?us-ascii?Q?X6qGfFc45Xiu58GQXZIJ16R00Nfxc4Joreerhnpa5u8m2qq+8yrBBfzkVMgP?=
 =?us-ascii?Q?L/6r1OJg9CODaI21ghRQB0qw7oagri2KfJ10V8uOsNCZnuG7ogEo4Nawb594?=
 =?us-ascii?Q?mz+2MAtB3na7slliPE7jIt1fiSzTihKw/Xb6Ay2+PXxQ0SHXXXQ3XrHvvn12?=
 =?us-ascii?Q?AS3reWrLUdQ4zFp+Hk6yXmNR9Tyj1GlUZJr+68BVLNcEqVDq6f5ocTH71Pre?=
 =?us-ascii?Q?Kbu0uwM6FfB9CFSj7q64EbBtbKNSEt76daSJqKubuq/ryNjkLV6vMNDrFe6D?=
 =?us-ascii?Q?4LR0jvJC2mlFst2GvABh5kzNTXpPcogkoo87QK6QplqTHq7b6+QAEkQgRE5H?=
 =?us-ascii?Q?LTVJI5prrp7sBiz8h/hpFeOjcFMBwn2XpZDnhYDEWzb59auMRE7qiQQM7HD3?=
 =?us-ascii?Q?D2Rg56lotIltO3MmILqXkOi7YuRCYMDqwqnHAbOLB8UprmAPsjJbiGI5krY7?=
 =?us-ascii?Q?FnfbMLnpqwjNdQpTgr4lDDHPI29HL+r3dpE27tttczlh+E08w1OT4KitG0P0?=
 =?us-ascii?Q?RTBVQRNdndszRn4CX1jhnvpDU8CK/ib5ag0f45++C70XarDUM6X6GzE3l6QC?=
 =?us-ascii?Q?6vgHMg8eS+uNAUFOaoVJ11zp8+8q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhxSyEfNBsD2t9L8dYKGVJqj1uPO7oRxkxmL19bDRQudisfs1ERwnHZ2TUZL?=
 =?us-ascii?Q?FMNiCXyELp4BFjpbdM71b/BHwnfOlso/q5NwJmjEt15qAwakDQNNupCWGC5C?=
 =?us-ascii?Q?r0lPzJLCVhEYdfT8Kt+Whu0YMHvG3lXHJKfOdxMOJ8UI+7x5UCat/5erwRfl?=
 =?us-ascii?Q?XXcwsUUqGvWSuF5i/c/xPNES5jgnqBjTivMCn451MnMPKHG/dOFXDzzXN8RM?=
 =?us-ascii?Q?1KOFyFIpTij62DN81AejxKM2XsAJp0JZBREBz36ZLUPXSmndy+JytYL0rP8H?=
 =?us-ascii?Q?lbVLpBRx4cg972s9r+ue8y0bGeg5Cl0VAo3D3FGpo6h2EYU1PWtuMwWC0D0t?=
 =?us-ascii?Q?YEkXpOYhgwK2fBBP6bUI2LAm2HJdvO6MELe9pT4BlVgkMhAsaDD5IKU6YeDM?=
 =?us-ascii?Q?FcHomvyiJe2BylTUaMjM8aqjkkPMTIsxlF+Bi2zCgVtnkk/E+bqOlfTRFHq3?=
 =?us-ascii?Q?GBw8ee5wrYo/Pih/GbqrWgMR3gIakbxrDKdSC0/ZPKSscNGbgLa76mpq4s/2?=
 =?us-ascii?Q?+kNp7cjLoz1eCNvvuP9DwIEj5hnCIaBWIx9R5W4Z3oPVLiOtaU0wLbSS3LGT?=
 =?us-ascii?Q?/8gI6Fbw25Q6A0e+1002pdQigspVUr6S1Kkz2sVSHSivtHfARip3qhZMwmkR?=
 =?us-ascii?Q?osmbfdujsdXVhNcW6GcbzsZdTg9m+uxHdEoZIoDrgVdSCNIOoImy8xurP+2C?=
 =?us-ascii?Q?fGbWnM7K8RHW5j98C5/ZPoF38hJQyHv6W80II0S4FW7Lf34EeHDuCwG91+G8?=
 =?us-ascii?Q?dFfNshs29cMCQiL8tErN6ZAilXs1mAJIdQFBhOcr52qPSd7NI+gf+SxnsfDR?=
 =?us-ascii?Q?ZdGHls22EESCNVu5tJl3vDjfsm60883DfbjkdCFmucuVKdclAOHsLhBDXIjB?=
 =?us-ascii?Q?SDtj9qrxroY0Mq/jZ1dhqfuYEoarslxg/z5oGzFA2LzSBJSS1i3TLgd1mGoQ?=
 =?us-ascii?Q?rTGkhgcoBPNqXLFRL2wnEQ2OrYbx0eMC6n51oaCEEu+GkMd4zw7ovKg2j25W?=
 =?us-ascii?Q?EmhUL8SvgT86se4Digi8gpmUXiYMIVu45ZJqrb9QzLj+S4lbHZqOobVZDmh+?=
 =?us-ascii?Q?90cpxd3bBPBZpFOm2nPXf3aA8BVnQpqgq3djG8+TidP9rhEEq/CnkKuszd5q?=
 =?us-ascii?Q?uj+XNqjOc2oJYbnwaPZi2I67YQgTN3hksv+QkyUdKILM6SuNjnZFrapBr9oV?=
 =?us-ascii?Q?ws6C0toJOiCHFmkh3ztuDXrj6Y9ctHpUIjPCE7Ujy94iqvBKEk7JeokKEv9S?=
 =?us-ascii?Q?V5es/54Fs25IgHXsqdxECc4BgB5dMjM8QJUSIaAqsw6Qsy0xmr7uV8VmQPlT?=
 =?us-ascii?Q?kAdjohqf2zppXdhh1c6fCDNYblnRKRG3VDcjJ0TytSkpgupJDbwu2ioTu0sc?=
 =?us-ascii?Q?V0+ajTmh/og2dn3tVkIt2CUPYbedAEMzr4w4vhv/WLrvhoUXlg6N1Y9P6a9A?=
 =?us-ascii?Q?J6JZI/hgrwq1SolxDSYvELPB+weRF6qUftcUndeUe3ONTOYdww6HRwzSYXDo?=
 =?us-ascii?Q?mxqQcKuiT9j42pOyb/tl9r2C/ptg4lm9nW2RnvXn4g7aFqLdmBFTZxajqPxd?=
 =?us-ascii?Q?NOaelLXjHKCoAL1FbXJYI57sw9QgElSx3S9bUq4a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b050f2c-fd06-475d-0742-08dd5743faab
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:32:43.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9r9e+NRf0+UkhnobGoCCpnXISXiWHJilEyOl70Z8pbuhyDNLdhCLk7qksOm/EJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909

On Thu, Feb 27, 2025 at 11:21:28AM +0000, Robin Murphy wrote:

> It wouldn't need a hard dependency, it's easy to have a trivial built-in
> stub function which becomes valid once the module loads - you literally have
> the iommufd_driver infrastructure for precisely that sort of thing already.

Yes, but I also kinda dislike using it because it bloats the built in
kernel for a narrow use case..

> All I'm saying is to hide the callback detail in the IOMMUFD code because
> being IOMMUFD modular is unique to IOMMUFD and not the rest of the core
> code's problem.

Maybe we could use a global function pointer set/cleared on iommufd
module load?

Regardless, we need to first find a way for the core code to tell if
the domain is iommufd owned or not.

We should also make it so we can tell if dma-iommu.c is linked to that
domain (eg vfio or the default_domain), then we can do the iova_cookie
move without changing the destruction flows. This would be the missing
union struct tag you mentioned in the other email.

What I've been thinking of is changing type into flags. I think we
have now removed type from all drivers so this should be a small
enough work.

Nicolin should be able to look into some followup here, it is not a
small change.

> And frankly otherwise, what even is the benefit of moving the iova_cookie
> pointer into the union if we have to replace it with another whole pointer
> to make it work?

It makes a lot more semantic sense that the domain owners all share a
single "private data" pointer.

> This is just adding more code and more complexity in in
> order to make struct iommu_domain... the same size it already is :/

That we get back the space we spent on sw_msi is a nice bonus.

Jason

