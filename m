Return-Path: <linux-kselftest+bounces-44304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119DC1C0A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A42F580A91
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D133B6FE;
	Wed, 29 Oct 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gYaHruw0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C01DE8BB;
	Wed, 29 Oct 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753658; cv=fail; b=GiZtem0g9cXoR8omRVMfvHnqgoAysHc7ib6eCTqDeDoenpWusvfDf5f3Z3f3NmMAtZNJ5nVfwaOd27PccRc1hr4NMnBgLZHptFReSNyI5+MuWywDZzk7mk/90ZHM/gWneXggDwd6Wkv0nASauhHyvSLn7Wk224cfgo3mwl00pVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753658; c=relaxed/simple;
	bh=0jbJoHZCwJBgxVppJhjXrXlbqGCnVym9S12QCLkbR18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bC9/1WAlplQRB+PgsCCGtPiJFH8YHo48B2loWGy2leJmGTfFpOUauOMPPoU2/cAvfsdmNPXSZqVy9HzODqMS4D2jDiaUeOg+NmOEwyXKhGRui6Hm/QZ57KqJf1HzqNZeZmPW03dEha+KuSiH3ejYFn8Mezwi5pCX7b2ggYLyDr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gYaHruw0; arc=fail smtp.client-ip=40.93.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDKq+1/eF/sIVS4lUvQ2CePhzRTv6pqFt5DiIJdk4JvAyTC9qsD3yiNTLzkvIVE6Vk7TEkCTIpaIosn6nmX+EGNUm/OZSF9XWueWYrTQCpXbOvqgQgNi+jyskl6cLcUeQDlROTkPIWGglwXleLrL49MaRXLt1ayVIxX3e08TECO4mrEWGWVWdWXnknSyRoqz6KjOezpXAjcTQyH3TKghajY7+8M9dPwK2VKYV4ayuvjyl/ww5/tjYDDcUPF9Ml0MpqxErjIYwKT1mmHgtr/Uu8pi56XeDO9wzGJOBfeLbEw/b9ydgE2W5Og0xot4S46JYUTJGxwetYFvoX/mdJMZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0rVf4FwEBEtemx4M9H882dal8cPJiuFYf4pGGgbZi4=;
 b=KNx7Stns3fSveWeNGSq+TIl1a6/423E72Oug1z5uJYxiIPD5cbWXdvq9647tD/hECkzNlKVB90AYWtZTFVtheXAagA8BJ0Coln/xXVC7B/uCewlwkSiIIU5qCXpVTyQ5nLKMECKKzl7GX934l5hXp7jBNWYRp7UzI4HD7iM/zJLmiWraufKMbGZJaiFuGejnOdxaueTDZBQrCCSaWMZgxIwaX2mjKeLRLCfPD+7654uu/ZyoiFeYe0U4p993Tvr4OgSOy6JCoJQ2TSMuxxyZklDPBH7GVbCU8UBYh/N94EL5fePfXHukOosm5OnE6hzfgnFNVlAoS7YZVE6S7omhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0rVf4FwEBEtemx4M9H882dal8cPJiuFYf4pGGgbZi4=;
 b=gYaHruw0kKacecfkXUJPjQWJ8yBEkU0Z5d262y9JTgW4TbA+AhnTxKaCY6Z5EOx4U5sB8PEsrvodpJlTY8rZDyqpjCFVgV1AHHdJ2XfOSxj2hNJkf8oxVm4XzqAkapJeqrT6PDcC5QBPfqqi2ilSZuN2D+Fddi8QtKwYJOBAeykyfjVJ+vsWNAU8Y3erMHh2D4MaQiTDNQ8qVlhcHM6xuFRLhV0lTKQmQXLkQ3BImCfqyxmNiQ+FHi3/wbEgo1H7dYx049uJqIo30h4yAjjPXCRTHAwpMnCJIbamfQRFQ6D4m0L9VD3r9saKXN3NuYQqPt5pkSabEvu5TBzEJ03lxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 16:00:47 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:00:47 +0000
Date: Wed, 29 Oct 2025 13:00:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v7 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Message-ID: <20251029160046.GA1187278@nvidia.com>
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
 <15-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0639.namprd03.prod.outlook.com
 (2603:10b6:408:13b::14) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 62671531-d1bd-4860-657c-08de17045310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x44QHODqktfXgbIaP5F4eSgY8t2Vl6w6/hQhwyU9ZSFuCU4GLnKhJgSfhzcd?=
 =?us-ascii?Q?3UplyHTnVvKANasjiPApQ5Lcxf5FU1x+MkUKOwHM+RN5hwjf9vyy+6tgivfm?=
 =?us-ascii?Q?VI29BFwIHWheJVUjNbHGVRx1Vdwmi41I1wKVwRIKY8/h6VykDTFMFaP8W+G6?=
 =?us-ascii?Q?JDFHJDV7zqoR3Te+vj2JrUqFG+DKhKEFuF7a/OrbZcSaFLEXbNdKzMCs3lFK?=
 =?us-ascii?Q?uIIU63S/zh9aasEu4xev5V5LcABPCn+3KY0N8ELopoXO41nMKDVTkUrINjkn?=
 =?us-ascii?Q?Sg3qSBwZW2o9813pJTU01iJKHFhd1NXglrVUnUONVn+77m0z8Pa8yUs3pDtG?=
 =?us-ascii?Q?B+0VsuOWP6r9lH0a7R4pduuyjxUG9CBGYeCzhQu7Yon0dc1rSFjd4v0710sS?=
 =?us-ascii?Q?W+pHSuftEgrvufBKBEhUZzweqY83eHGLDOmLRtvG9m1JJqgiVfoSPlZ5OYAC?=
 =?us-ascii?Q?1Q+9tLyEhiopJEcQOwmUsv7TDBRg55qx71q5/ULZ2y6vF3bIc7uY6JvMglQ7?=
 =?us-ascii?Q?UiXyohlLG2GCy5X2Y2JiRhwsx9wLBA5wp9Jq0rsryCuUwAkCBrEv2Q0D3A52?=
 =?us-ascii?Q?vjjlq03zP1esV6UuD/DIa1f+Cb0eKPXnnYBlAYHDHdCFbHPhixfN8OdQtYF6?=
 =?us-ascii?Q?NK8+DZeLDTPdixJ9TAToo8ATIQWrI8L/zyacgoP3Xcjl3+ZyEqsay2RHM0Y4?=
 =?us-ascii?Q?yZlmK8K8PpLbunmhhGJONt5+nrvG9vJWA+YH3bqbsKPj7oOqJ3HHSL8VgbLh?=
 =?us-ascii?Q?Jqw8SQ7w1BhvSPqzHEdLexHno6Jqaed4R6UmccxIgYM8Jip4jUBoZ+m0Vh+k?=
 =?us-ascii?Q?53vT7ejRp8c9m24OmSV8e6KKf5MpVPPa2Px8u+1suYmya8THXQ5im21CKqXz?=
 =?us-ascii?Q?AUFmZcfTVZJWAP6iesUhVAlwnTk1ZXuOXelyKN4DlFvOZ7DWyDblkeckIEyx?=
 =?us-ascii?Q?T7znOfTBgg+JQn+xvWxDoxN7PU9qRdcS1dgzhlkXxUeE04NV2e9hmLL8PjsD?=
 =?us-ascii?Q?nZ7ERaUn5NWd49zCFqR4bjEWFgHOOhZGLVCTZFOhkpH20RWfcmtAJwMs7PZq?=
 =?us-ascii?Q?t28ZnPkha9rqcamdi8KlUj5w6FbU+VscU07VcoaRVMALJ0QeqmYTUb4ugfBD?=
 =?us-ascii?Q?4FMZ7zIkPAxLs7OUZhHDobrz9jWPzgt1Rx9Ss0ymNeQFzZ/oxP73qhCNkqGs?=
 =?us-ascii?Q?X0G2C/xiF1PHKboTBb8Vmh0+D+vTRUwbXLB3zwlptqDpF4bhHmFW+OLDcDOT?=
 =?us-ascii?Q?DNnWG6v23ryvFifEx+iLkvux9Qo5AjTYgocrb96zXWamsnlrIcZC9EiXPirz?=
 =?us-ascii?Q?KuJhhRN7QQeaN8x8Fzdp0W5lIXJMv1Ainh2flgAYG6wAv3QXyqjPq8ijortZ?=
 =?us-ascii?Q?T74A4JNwgGBQ3y015ueW2V2lwfRSYLf5Ml53ZId3vDB5asbzYWAV0mLTI6qv?=
 =?us-ascii?Q?Z6eLJSSVxAxoDQDfoXxAJ4iLb+e1B9SbZHuJEQ47KJFyEOrQXsnyvBqqwQ3T?=
 =?us-ascii?Q?kDiC8RmVQkyfoEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZMVNKwqJZthW/41Rno5bw/A0v/x2N7L/8EAeIsv6lp1AGYzgRD6kQQRdreu?=
 =?us-ascii?Q?V0PBM+f4LnNK6V8gTe4Ry2IUuICAQ6pVcg97KYAKYk/g+L8Ne0DU+KqwcdVH?=
 =?us-ascii?Q?0Bx6Qe27owPHLP9+9C+LnezKYGF94YIuZczHrend+dZmOMpWTxiojZlDRghl?=
 =?us-ascii?Q?GuLh9N2QuHPEjvpWBNxgRcEQMwP1arZZPAe7oLMEcZXNUiDTRHTHzfI4MW9D?=
 =?us-ascii?Q?SzItQxo+M+RUmp17g6PfHR9U6kMrkVvf83y9+sBzpy9+14Dt6Z5bOKju8iW2?=
 =?us-ascii?Q?W8I2oOekEIThXdqiE7nbkXluJT2CgywJTC9gHqmnmZzn55OWXxVOM77k37o/?=
 =?us-ascii?Q?5J/9z7cWhX0EYlMS4jlO0gRhvwXFPp1x+hVxEUSkfVaHAL2eYA9UM3+pPMPj?=
 =?us-ascii?Q?S/ei0MG3t5NpiOBxEIh0//esNkFOWbj2myAmHthBsZSCJhqioBGp7k+mdjHY?=
 =?us-ascii?Q?Zndv8gfzlGqVQJMXi4suW0dvh3oMMSbEbmiK+33S/jnrqzgpPoWEd7kyQd7S?=
 =?us-ascii?Q?RBVtIolmzHxis7aj4I57PwLi7U2YEusdA4hMCrtfDdhQ5UkizMUsnA281fnq?=
 =?us-ascii?Q?JlmNyc5wXDoMGAIneSgYrRqhCb9amHGs1B/5lGeMv2lJd1S+OWVQHtopM4t2?=
 =?us-ascii?Q?j4BPhPeGwk2wdmMBMBsaZygToaQh8VsnjfQQGX/e/epW/zA0sFw/+IofR311?=
 =?us-ascii?Q?D9LVGN4OZDgMMoqqM/LoVnZZ1Ei1/CvxFdtAKTLChopON/dwevJgq0nc7Bee?=
 =?us-ascii?Q?HtYpGJ/F18wuj0IIDT/oRGzG/51DnS+NBDxFGEWme0hu+aeplbcFQRnsAuGX?=
 =?us-ascii?Q?JxjasrgEYbWshvg2qXRMpZAP/muK8tKPrsM5PJUbyjKCrnJkK7AGRvn9895C?=
 =?us-ascii?Q?L+vL+PYRiJUvDh9A+KHoJ5gaugYLUt1gt3GcXTgkAQ5Gn9fd/6wiAo8TyBqr?=
 =?us-ascii?Q?jRWH0NeL0PSeqeVibZAoYiJK059ZNzvmkimYVarjzJCDdVw/nMFyIwKu9Mp2?=
 =?us-ascii?Q?vHlbTO6cQmFs9PGJyldLdCBllcBauzMHml3B0d7fyvuQ2D7c2kH5zR5iCglA?=
 =?us-ascii?Q?0xP+bxjPQOeZG7SfFGwvYI+dWHsmh2Lwjh7bXXT64GZHFVEn7ZbTOePr7oI2?=
 =?us-ascii?Q?2JMs26dKfjI0hWQyfvFCnZjX7RG70fDAhotdbj+U4ZKEPYbzlq6AFgs5dwaS?=
 =?us-ascii?Q?597b1ugoA7KpQmVdnwfMNvAP5DnYJGR8C7w8U7p2G1l40ksXKSEfqLWN2E+8?=
 =?us-ascii?Q?v+uZGssxCOrubsLvD8r1JowfoLsKBXAWhlO7R72Ntj5qptmfEFEoRrRbRhxn?=
 =?us-ascii?Q?fnZv8URSqwuDQvtRoQfk79eqCFzWxPZ6VFWXO9h694h1UM1ltrn9rfh8HFsz?=
 =?us-ascii?Q?2sstROa5bm4Yr9mYgyaIJIXG8JASgA9ejZwrnwGkKsPphh+kDQmPPcq0H72I?=
 =?us-ascii?Q?tzuICw+7kBCpKIKiQnYR6Jbj84PFUiMzM2SiNKez98z4t+229ofbv3x1gYlU?=
 =?us-ascii?Q?hdGawAAOKgvXTui1NQ50NTu/dPT1tNYH2zN/EzUuD+7IOemza2P7pUx4buf9?=
 =?us-ascii?Q?YZ5V5RvuumxCs8CMoao=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62671531-d1bd-4860-657c-08de17045310
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:00:47.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxfLdI6cpEu7S9BkA+pb4aPDNvvhO3wsuL7cw85NAkRnW7D6civisCdGTcRsbwLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511

On Thu, Oct 23, 2025 at 03:20:45PM -0300, Jason Gunthorpe wrote:
> +static void test_map_table_to_oa(struct kunit *test)
> +{
> +	struct kunit_iommu_priv *priv = test->priv;
> +	pt_vaddr_t limited_pgbitmap =
> +		priv->info.pgsize_bitmap % (IS_32BIT ? SZ_2G : SZ_16G);
> +	struct pt_range range = pt_top_range(priv->common);
> +	unsigned int pgsz_lg2;
> +	pt_vaddr_t max_pgsize;
> +	pt_vaddr_t cur_va;
> +
> +	max_pgsize = 1ULL << (vafls(limited_pgbitmap) - 1);
> +	KUNIT_ASSERT_TRUE(test, priv->info.pgsize_bitmap & max_pgsize);
> +
> +	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
> +		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
> +		u64 len = log2_to_int(pgsz_lg2);
> +		pt_vaddr_t offset;
> +
> +		if (!(priv->info.pgsize_bitmap & len))
> +			continue;
> +		if (len > max_pgsize)
> +			break;
> +
> +		cur_va = ALIGN(range.va + priv->smallest_pgsz * 256,
> +			       max_pgsize);
> +		for (offset = 0; offset != max_pgsize; offset += len)
> +			do_map(test, cur_va + offset, paddr + offset, len);
> +		check_iova(test, cur_va, paddr, max_pgsize);
> +		KUNIT_ASSERT_EQ(test, count_valids_single(test, len),
> +				max_pgsize / len);

It seems alot of compilers figured out how to make that divide into a
shift, but at least one hits a __udivdi3. Should be:

		KUNIT_ASSERT_EQ(test, count_valids_single(test, len),
				log2_div(max_pgsize, pgsz_lg2));

Jason

