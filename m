Return-Path: <linux-kselftest+bounces-31793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7CA9F740
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872E64616C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747225D8FF;
	Mon, 28 Apr 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8KsKcnW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C53184E;
	Mon, 28 Apr 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861112; cv=fail; b=ajfFn8FSSksi7YR+h7lzQJmraKO46UThP8vNno7836fQW6KYe6Ey+r4d7V2qxO5yaJl0qwCzUkp//ms2HtALbQH5efxo272FJbSjMyLHxLG5JOGPLpTSeuhFH3k8wCXgms8/lbGW9W0rKGtwQR0vDdry3AJrMhijdKdZrUZbhBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861112; c=relaxed/simple;
	bh=eaYrJrJgP8Fas88PdSvM0DbNmV2gOebulJbUVrxl+G0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPCDSnbfUEoLwXLz7yGU6FauyREMUrL4EqNOHwv1gLsyYWd+g3n+943K+3sSIhMxDCjMD2XMfr6F9yfxnLMz16aR9NlFnRPLYsVxYNERnCQn0rWiHlRK1sI3h51KI2DiAWT7KDTabqRyVVThzRImtD6ywP70jzFXgCubdho+E3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E8KsKcnW; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/0fwJM3siqwi636oF+NCuKFYZCFWALmKMKKxH3B7EauZlHbaRtMoDoVEBLUmTXYILxpM3VZ0v8vXtN2p2tc/u+E3zJf0CKLjJdeE07lhGlZcLdyj6obp6J85k87n3+vJcq4nN1ZqjAySlIweokxMU3jZzHb0QkqkgOcnPqoM+kViF1CcK8NALsXj00Nuaeox66kWVmmXaWGvzndALjdpvmOZZnT4oR3GauJd3UNL/rmesUMLOZu6iFK/zHA28zWYo1UmV9a2z4tnSxzXmFnBoEm02wuaPaSCIIEXF/aOP1ZTqNPxuaUakRXTnujGwl2bmFImbvYlgTCip9SVKj7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLnyjLZBE+plR+ovFWLaYuB23tx6Vk0luZbAwhu1Xkw=;
 b=tEPf1TNabEbrSxGgSeHnOEtRPxGtmE4A3kZCx8iWBsL4mAzZwTq3OwA/eYKIiRpb+Ksltkvr0BXBIe25OnFfQfQqzdtuakfhKzyV/mHTKf6lF3FagsKB7Tx8Xvn02YNCiYNJh6Qh0/hbLVMuZzpwbisMYZtdbCP4fBCOLybWJYYceW6pncZ6PMsAEmVhYjhTcD2yG1KM7CXo+orImDOd0GIQGhrOR1ZqIVfqg8J6ivvcIGRDubDi2HlLgrgwTZlSq/7dpqzoT68tb/QjAOgEqVlvecvL9xWZbkZrRqfur/AUVoNzu62gVdejGceaaNS4eImu3Z6ofsLRHxJn1Z9vOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLnyjLZBE+plR+ovFWLaYuB23tx6Vk0luZbAwhu1Xkw=;
 b=E8KsKcnWft5hgO9gAGgH+8vjGpm7spjapW86rwmRwnR7TNvFdV7VXCwxPzQ5M/GkINooclHs/X577/IIKsxckBR0iq+qGCsXpD5jQ0JNEAzcOdziLTD5txwBnv5rWX2UoILPDVBZwXPJ4AFUZnf87eFc/cuqyekarkvyBH6USx/1gIWmNLGeQ59MSnDHgdCzAxu/CcRIwoymVk9S9681agN9E1QYJ2T13Ao+mUNaWOPr82hGa1tuXWipWxKY+zLFIIoSCdFFtBx6FQzHWr1+icLacWZ2cTO2JR8VyRY9eFx1H9pBohOoyQhYJjvSsJHJy54shoSF+Nd8ZvUBlLJG3w==
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 17:25:05 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::45) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Mon,
 28 Apr 2025 17:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 17:25:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 10:24:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 10:24:39 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 10:24:37 -0700
Date: Mon, 28 Apr 2025 10:24:35 -0700
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
Subject: Re: [PATCH v2 05/22] iommufd: Add iommufd_struct_destroy to revert
 iommufd_viommu_alloc
Message-ID: <aA+5009M6QTjjIpO@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <3d8c60fe9f1cdaecd59ce3e395eb6ca029ca8ded.1745646960.git.nicolinc@nvidia.com>
 <9737606f-d3af-4c20-b1ce-7c705a7c8590@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9737606f-d3af-4c20-b1ce-7c705a7c8590@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9725e643-e74f-45f5-8339-08dd86799dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QoO+AgFx2JijW7X4Z027Yo0lp3zgvl3naK5RtatDnSaIijNwBI0g99UyEC6u?=
 =?us-ascii?Q?wnsmpB9rD6Hy68YPSfxGECUsU+zF5EsGHkqS9WlRWkKY7OaICh8f3WBkraV+?=
 =?us-ascii?Q?id8sYY4gUhA6lNAJoYR9pkgZmqVbZYRs8c6GB2pD//74N1BO/PfObcUG/Hxc?=
 =?us-ascii?Q?LzRW1M/UsVhFv2/p6jxUF2KmX7iIhLd8yGIvPQz8QhDAtuSykIGqPrWHd2PN?=
 =?us-ascii?Q?9hd9/jE+uL1Kg3U0IOZlXzHeHOtD/0iOX9z6EQaSjGmi4FgvyRWbci63IFnY?=
 =?us-ascii?Q?/ZvrOAuQCqyA4n1JnHT7BywkztQoOllbqK8BCJrFhXVQey9F+RPl7UbwQOWh?=
 =?us-ascii?Q?F2wAxDHCItC3gV/MnPdRZMQEUFGcBfgcrpsKXXejUFP/z6DcPZx7cl8RlO0p?=
 =?us-ascii?Q?SppVN+4PQBi7Oj41vNTP1fAC5Ikm5J5vdmRLWlhSt168FKHNi3JuIc3xIvk6?=
 =?us-ascii?Q?zCxxqXlLau+VzqGyeOnPfOjFH6k2bVQOkdM4pB7quxHehPiFin2xOInmhVL9?=
 =?us-ascii?Q?L0JUAu1UFvh8aHhkl+tFWMx79d6li9qcxm+/nfU5aioIXBtEgd7XCyJVV40V?=
 =?us-ascii?Q?gWgVEro7G7Vka1rIN4Oj7SNrXsmPrE95ufcccVWfxD+8EjAUtGSVSsBCnj2C?=
 =?us-ascii?Q?l9nVywP7tMzffVlFC2mT0EtGu6cbPsOUvf9Mamn8YpCcm30MEXhw+Onvii3J?=
 =?us-ascii?Q?/GbC8MqpuOgDxapL1lDWstByhxxvFBsxOS0BL0VT3wSM5kE2tvdOIHH524uY?=
 =?us-ascii?Q?ZHmrJQbjcdof6sI6ABV/M5APwM9WqEy6rIBSPoMhNmCsaLe+7C8rFEh59inm?=
 =?us-ascii?Q?aUYwzHNg5kwlcM22N4VaaIA+HeTbdoD7gkd96wsf7nE2XD86gfUBH5t2FG6k?=
 =?us-ascii?Q?hIs0ba8PcyYUXz5ya0ANB6ELA/oEzw6lu9V56d/7iOlk5HlOQogsCeWb+bnH?=
 =?us-ascii?Q?g3lokM3syuuHBzArZVt+J/C10W0TcVF5ngKVjURk6w3+VoZKA+yTsGMG5CTW?=
 =?us-ascii?Q?w7mb1qZc7pIOzBNwIPOgNMedJUL2UfhWctthKYnH+iQtfTxo/DiToNPu9bAd?=
 =?us-ascii?Q?BCGowgNoMAvSAwt5caMGWBSufE5J5LNFVQcEHtF9Eu8heXz7RIZnYUciW4aq?=
 =?us-ascii?Q?d6HXRUFdy5/FcJiIms1NUViLACpCfwxsM0CJFi6CLc+eqdIqq3JEl/5JUXe9?=
 =?us-ascii?Q?XZ+0Ap6w9okPc28v8OCmAQfCZSgmKsg2LTmlFPCu6bHzEdMcGKOlzcwPLpbs?=
 =?us-ascii?Q?RI/GhyPjm2vdDzNfUfLmfY2Ms2mRJL3XAK1s2HeZhVUo3ufHhKTU2fS4X/vI?=
 =?us-ascii?Q?YcPiPJSbgavaF9rfNxaV0P05n4dvLNy+WqeedrRgtV6A8rys5v/3XaYWi6Nu?=
 =?us-ascii?Q?O3jzkZVYmu0xiuVIottdNwWvv/37uA0kj9J5SEy0UjexBqAHJFUzNtLHYfxY?=
 =?us-ascii?Q?87Cy91Udbdu4yxJtoYqGYySPDJQlnva1Zuh2q5m/ww2HDiNmJAHC+IE1nzFO?=
 =?us-ascii?Q?mJ+YDRqM6rrx72wPZU0Neb2Qsg5d0fW//ICd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:25:05.1988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9725e643-e74f-45f5-8339-08dd86799dbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C

On Sun, Apr 27, 2025 at 02:55:40PM +0800, Baolu Lu wrote:
> On 4/26/25 13:58, Nicolin Chen wrote:
> > An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
> > if it encounters an internal error after the allocation. So, there needs a
> > destroy helper for drivers to use.
> 
> A brief explanation or a small code snippet illustrating a typical
> allocation and potential abort scenario would be helpful.

Will add the followings:

"
For instance:

static my_viommu_alloc()
{
	...
	my_viommu = iommufd_vcmdq_alloc(viomm, struct my_viommu, core);
	...
	ret = init_my_viommu();
	if (ret) {
		iommufd_struct_destroy(viommu->ictx, my_viommu, core);
		return ERR_PTR(ret);
	}
	return &my_viommu->core;
}
"

Thanks
Nicolin

