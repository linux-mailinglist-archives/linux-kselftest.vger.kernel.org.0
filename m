Return-Path: <linux-kselftest+bounces-31800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F3A9F819
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2F21A80051
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F32951BB;
	Mon, 28 Apr 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUfIQcmV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F7289343;
	Mon, 28 Apr 2025 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863873; cv=fail; b=PTc4Hn6vSuLKOIe8uOOeng4qjTln5IdkpBBsK2P3tkHOyAHLLUPML+34NKNV0ipiiKnsRv0rle8nqnLQKzXtRym59GtxGGmxCqbG3CcDpbJExzaQWUWCVKPvPpXbUb2LnRWAGrPugRvJnUqTPTpPmRgoAEQf2gLDSjgw/UEdN28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863873; c=relaxed/simple;
	bh=HOBx24mAHZ4stcX1n2kZvFLWlSUXlqyX75+Xqe0aTE8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COohnmaVd5NGu3CCgMBzdiPz/EMYf2ObhEefPtydTlmg5ImtdFJH4AOD3ToZGJlluopf6wa2biJdtzJlqW/a1lJ98LEALC0f9jyHUSlPDFWR82VvDDa/lLz4YSEtx/yviBSfekENKGjz+5NIaRVe/SRq1Gx0iaRba9UM8D9E/Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUfIQcmV; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9ajSM18K/BWH39N1cARLtUCECOxbAXPCtA5JKIYx6GWcx9+74K/W1hYUJkY905gT/tqx4z7ZAL/XfoIC3TkTAal7l6WFgptpDvGTDbjBezTZb7RL22gNsm96eFQBeDwlnQcq9NA45ESj+P+R9ROQbzseELrZgLV44/pM/FnNbTxRspBHr2dHh6irsnSoX3hWUR3HyoNKx5W+DlwArrnQANvMtBMG3gBbb0HpwGIkCVfrTd6n6vPepsKn2fuvBcgRjxD4w25MQyVhTTHdVmeuQQpXSUpoX37VXI7ybiwgQdE2yOeN00kHPICNolOUy1mrpQlmNAERh+b1fRYf0eU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5863dNGJJp3eODoc18NgqrDBXKCW73pyjiHAStnh9lk=;
 b=yYYuUK5ICwOgPSDEi6AD0WTdYorXECoFGF4qN1qpjcIAGshNoZ1uCT1PZ4QF6lfsxrZE9Ata/HIa8xe7l9MfvYcCgW0eLpc9fSATaiD70GfMu+GpIkjrpNtkel5cNKBdPrCw5gIc2ewsNsmQBVUqVkxYfBLbeaKH03pFgoGoPt8+kSa06+4hESKkDfiIvByU8f5vk+OAjB45uEaw+uX6dcKckGQubzpzL990+dushqPVGuCR8qgIqDE3Ojo75geG6+HSil44j48z437ATyAicjXkxbU1WWPtlpVZOxTC403rA1Mxb/pachRZFR6SRtFGfnsbd6c10cvWNkqYqkgdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5863dNGJJp3eODoc18NgqrDBXKCW73pyjiHAStnh9lk=;
 b=AUfIQcmVF+ksOXDbLhFp5+yx+kr0DgsgkJumJT4psfA1ofv3PDF3dqwfXpHb4VUhemOItnjttXSTTeJN6+5gOA2SmXIgfelqhZ6GUW5j2UmJtMoZoJ1U0x7vnA51GcoXnaqTC1FHHr92Gh872IupHehIoOaXgiMZ9sNLwZwnL3ooIL9tFMMV8ifWCJZBTH5uLErckHNYAcK6bRijYvhAvLEXUm4dVxCDg0j0fjLRtpAVXkpngltarcG0WoCxHuyGlLrdshNesb9fq863OOP6cvyoWkHLp3xMYvsfMeEG0sTYsmOu8NvX9a2kIsBkTgpNMeKzTI0U5fTwFkn424Z0VQ==
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 18:11:04 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::9c) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 18:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 18:11:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 11:10:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 11:10:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 11:10:41 -0700
Date: Mon, 28 Apr 2025 11:10:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 09/22] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and
 its related struct
Message-ID: <aA/EoEFtbnL2+zAw@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
 <28e513ec-4d8b-4967-a241-d6f63d533050@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28e513ec-4d8b-4967-a241-d6f63d533050@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6293ef-6719-48e0-8e95-08dd86800a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NFHjORpNmYiDZU/3jj6F3cLH/QGwqaiV+nZibujVSz4BDyd6H7naYTfQ849Y?=
 =?us-ascii?Q?Xdx2w54aYI274p84W4moDfD0Gm4mgdsQL04IrqxjDws0pBWr7Jt18EKssaXX?=
 =?us-ascii?Q?AwrIZK7d888McxDK9LDFq4JCL8NwcXvnAPXEjjFgij5bviyCVT3GO5QbkSdB?=
 =?us-ascii?Q?EDKwbQZjpjdWOvFIHp5iUL4aY1kFxVxlNvuTALVlS6gnxT4Ta5PsLfU8fVHj?=
 =?us-ascii?Q?T88/u9DWPQGEvW+BO77ga06h7DAKPxrWQa+auAluqQOq1T5mUQvtITFfyYPF?=
 =?us-ascii?Q?cjBIOFrkR23yUm0h0g3zLCcYSp7UKb2DwtspjFE7USuTjkZRlN37r+kKIzFH?=
 =?us-ascii?Q?0LeWWOY5MS9oc1x+tkrGVkVvlQlXkm87WwYqsdrY1yl8J2HpYl+OZotCxFSA?=
 =?us-ascii?Q?XSGwh9OnwXnco7Qg043BCN7US2XOrFQQ3sLOQLdZpEKcaU840fPpyF1mVWVs?=
 =?us-ascii?Q?LXdh9J69Vt8acRrwNmK2GfyM/Tck0EPMM8gi7a/VwWqqyZc2HUO04mpFg5T0?=
 =?us-ascii?Q?lUTfQ4CeUMQYXY9wNBQYdSLcm7CEBaOMlE5BQ/g8oex890UqcwdIMpOsfVyJ?=
 =?us-ascii?Q?UmD3n0HE1WAtDqop6lfW3Kabb5Nf1vXBYBiJ4SVSZqzxv1N8N4UeTVFjIC2v?=
 =?us-ascii?Q?YL57hzMoAB/K+/RIBZ3ABF3RByGKluPcig+sVzJE6l6g3fHS7HJV1aqHciTT?=
 =?us-ascii?Q?wgV3xu50rc742dYMSAGV8YUiC0STV2N38I85OhKTb04ZAXxOMlsNbYjsVYyX?=
 =?us-ascii?Q?QyQ17L9fA/g1oW9GMJVOIBlxnhSVIe+iOhnLyI2Ot33F3kUhbVIAft5wOKjp?=
 =?us-ascii?Q?ybe6KNbctoTVE1phiJq4LUGgHgexbPzvRpZnbRi1td7giKDmh2dcKhbZv8cv?=
 =?us-ascii?Q?vbMGxarX+o3romTeAUI3jJHYGdCFbkjq9/AX6d9z1L/er9kdsotmwvwooWCh?=
 =?us-ascii?Q?XGlU4hzN5jOixze+KqCu+NUr+wABjBaSeDBKFaFJpiVqgS08hKRuzm5t7AGA?=
 =?us-ascii?Q?r9hbpzMShhew6weM2SFj4MUwPs3kKI1ouYHhV4mmlUHLv0bCV6hYtPvR09Iw?=
 =?us-ascii?Q?1cz2UZ9l6aHcx6DikrtDii8gwslJsI24K9TfQMlj4uXWOISlnI2MAgIkBmof?=
 =?us-ascii?Q?d0Mm/1tYcaqxA0llN8+VzhuB4AY2X+N+/YIn9jMN53IZ6F+vs5ekkJzBUZ7W?=
 =?us-ascii?Q?mJwsJ5rlSheot5m/lK74tXWP8MM4vp+XMltEyn/F5uZuqxWcDzcz0+QeQ/93?=
 =?us-ascii?Q?x8/bFfI2i0xPgj8hVY7jFG2CmR3MK+ciIof7u6aP7de63gDzz5gtBnqin2NS?=
 =?us-ascii?Q?LT0oCMkb9ZrPlhzTk/tA+cD2L4ooRI+Zv6s4qvCHBj24CjusUW9QIsR07/TL?=
 =?us-ascii?Q?eiR0B0cXY3XGgwzD+r7e13FLK8to20XBpDMxuvJdBmWI0MP2VDEErm2imsZH?=
 =?us-ascii?Q?KV68XP4KOpEvPZmRCc60BoUMOvbtbRaXTxnroqjNDuxhcZ689wc8iS9OgKHc?=
 =?us-ascii?Q?955IK4EV4OtxOVFA6LlrVrGG9xwqB2Bi1S8n?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:11:03.9000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6293ef-6719-48e0-8e95-08dd86800a2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659

On Mon, Apr 28, 2025 at 09:09:19AM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > Add a new IOMMUFD_OBJ_VCMDQ with an iommufd_vcmdq structure, representing
> > a command queue type of physical HW passed to a user space VM. This vCMDQ
> > object, is a subset of vIOMMU resources of a physical IOMMU's, such as:
> >   - NVIDIA's virtual command queue
> >   - AMD vIOMMU's command buffer
> > 
> > Inroduce a struct iommufd_vcmdq and its allocator iommufd_vcmdq_alloc().
> > Also add a pair of viommu ops for iommufd to forward user space ioctls to
> > IOMMU drivers.
> > 
> > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> with a small nit below ...
> 
> > ---
> >   include/linux/iommufd.h | 35 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> > 
> > diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> > index ef0d3c4765cf..e91381aaec5a 100644
> > --- a/include/linux/iommufd.h
> > +++ b/include/linux/iommufd.h
> > @@ -37,6 +37,7 @@ enum iommufd_object_type {
> >   	IOMMUFD_OBJ_VIOMMU,
> >   	IOMMUFD_OBJ_VDEVICE,
> >   	IOMMUFD_OBJ_VEVENTQ,
> > +	IOMMUFD_OBJ_VCMDQ,
> >   #ifdef CONFIG_IOMMUFD_TEST
> >   	IOMMUFD_OBJ_SELFTEST,
> >   #endif
> > @@ -112,6 +113,14 @@ struct iommufd_vdevice {
> >   	u64 id; /* per-vIOMMU virtual ID */
> >   };
> > +struct iommufd_vcmdq {
> > +	struct iommufd_object obj;
> > +	struct iommufd_ctx *ictx;
> > +	struct iommufd_viommu *viommu;
> > +	dma_addr_t addr;
> 
> It's better to add a comment to state that @addr is a guest physical
> address. Or not?

Yea. Let's add one:

	dma_addr_t addr; /* in guest physical address space */

Thanks
Nicolin

