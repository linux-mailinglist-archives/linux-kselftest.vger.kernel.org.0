Return-Path: <linux-kselftest+bounces-36563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20164AF940D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BABF1C41D34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A22FCE0A;
	Fri,  4 Jul 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNaDlutg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456B85626;
	Fri,  4 Jul 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635569; cv=fail; b=bZKKZhfTI1NWttH4hLpAHfWut1HZFgxE2iFOT7icZlHrj1j1RtLlcHZvKKFF2yyetYFdnEtEolwR2pto71sU5Uo3OXSsRQGjNC/0GRTQ/pdfnFhEA3SnW5FF+o7ZZy42vVwRFKgcBhlk6WVmaoaXZBpiMLJ46QJQRULj0wFQs0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635569; c=relaxed/simple;
	bh=jcSj1VC31i3wvesZBYKZIVxs8P/xgIg0i2BVmjLE3Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PGkhhEFkMSo4iZVy19pZteRfDR3VaXHIKhKQ3cahMzL6AtwaT6a0+1Ey1d0k6KlDrndMfvbAvOKy6x/IPizZvyghgI7tW+ktg9xdN3wRC/8ugI5f7s/obZIZntwz97vGT756CZuKeXwPS+aoFubD78VoMTPxcSSQ/9a42oX9RPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNaDlutg; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOg5Du0L8rRYmBL5eNqXtHZ6WqZO1zkVf0HWwK5R/bhwrc/K7O1u1pmOYNs90uPcRhE8UQtVDXeflL8BSO8LV1/XbbZS0KDDauTPLIBLShKc0BTkQalZNtoOMrZ3Qo8bFB+8ebWs4tdogBq2CLPiF443bhfteoj+VwDlNeB8PQnhE351QZFQ2/OZ69j5uDC04Eh42jLp868L/2+/z6oKyaAPOVPZMpDbejewOz/cB+6t+m0fOuMwEjI5YnYSGEtH56Irqrp0Tyw7us1RQDWuyB/Bb0XTb7uUxgmRviK+oTcWQ9WNd5ebJGvZLYJ5CR1PYHvAX+pmJg+Mt2C2JjOLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OruQjtldIEQ57Alae2XvEF63aXdFWEi8D4Ju6j35MG0=;
 b=vHquJURSUuefGNikJzfGdrpkBprNaPOpCPxzx8uygP2pV2LSE8kTezKGEy0fqpA226Ls0F9Fd3M4DA2c3bixPDZdMlmtZmZfrVV0XFSHEAEuFr8NSeVrrSDTJXRaRpWWqT3mCd5NNVT5/iM3sdP1sZ1uM8Eydw+zW+eHD0wQTcED+8WIYzbD+EX6oHIndMXYmPzcEPaq1O64nonP8SBEXWkdh86ATVHghi49b2Q5R3yRdfG4bR26MLo0T++FL69URF5d0ekm1t0WwEUrQGFTfE7YBBcL4E9pJLdHBgy1ddoOrQB72b/XxgJH67MRqVzdi7bWYQ7BtbJMgsJVXCYfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OruQjtldIEQ57Alae2XvEF63aXdFWEi8D4Ju6j35MG0=;
 b=TNaDlutg91eX0xf14vLwKhsUpTSVTjer9UyQNOJTcFzeQno2VHxkKYKE01rrqMPOsS6mZeH1PJWxaY01dCqfGmAQjAIHsZQIA8FIrXzlkcQNDsmIsUY7akhHE+i07mDTO1tEPSy6snXQZayWPoyjpyNJIFMn8DZmXnh/ltkb/2jS+5lhOypIcBlyzrIWGh2tQghHYNOxo4UeIwqzMit8tvbFVI7wAUeJseHiJjuNAIe0090TH41Wwcv1aEXi4PWGry9qKjyTxPGz0XhAtsP6s9ckiBOEgZZtRQEBunopRRV7E/C3dyy4hU+jtrr9WPNsV/4NglWQ27HMyZJXWNLrnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 13:26:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 13:26:04 +0000
Date: Fri, 4 Jul 2025 10:26:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 13/28] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250704132602.GQ1209783@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <31ab67fa5c4fc1f2c8bea74fa23c1da7b97b9a93.1750966133.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ab67fa5c4fc1f2c8bea74fa23c1da7b97b9a93.1750966133.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: c287433b-045a-4dd2-8aa9-08ddbafe538b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vk/D3t7RvHHq/yVe3dnKWClWyK52uy+Ug+QvcxrPXVvKfYjO/BbHxA1NDcOb?=
 =?us-ascii?Q?Pvt2KfS657JdFEPrVoP+8t1gqQxy4Qmg1j8RJKiImSC51XZpVNZ60ImGPGuf?=
 =?us-ascii?Q?U22Q0u1+z2Lc/RIj0zqsD3k8dOMvlwYAufdT518nXQtHK3MrHwwAyseIux0X?=
 =?us-ascii?Q?jNA5vCfdHWWCOBx7jjfeYuxeMyo2dbQF5E6bDajQIeGgeiaPaxNE8hN3c0A/?=
 =?us-ascii?Q?UUM782BKsTDqKt+G536SsrxmulUySzJg+cLqO8Bz1CKOPQ1tQnBeJMb9X0/9?=
 =?us-ascii?Q?5oLU2B6I+sic0vG7SomFmN0SdHAcV43EF52vjN/QwlBkKRBe8Qgetp2rpzRV?=
 =?us-ascii?Q?l/7C5tgDruh6ZhEM0eyxdXt+gRo3h1b3EZyY30qzVi70u0cm67s4Ywqqbpzw?=
 =?us-ascii?Q?H3YwO+2q7cLVTAsGSqHX8ReeqKSuCZseJhDo9eLzc7ACLGpQTlQW8xB/S1An?=
 =?us-ascii?Q?rntMaMR73RgFbrq5hfcKZ5phxG+NJQmONJB+5LhraS7ybEp+3E60RdsiJO2/?=
 =?us-ascii?Q?O75iEyiYXbhzxzjVheiD128s7/kiDwJt6iS0WVPA5ouAnn/oG4fxS/9q5uFn?=
 =?us-ascii?Q?XKjVrYJFzboft3bwYiBpuQzypq5W9xY5lvqPnHNYVFOeY/5Hjhn0+HTnjxRH?=
 =?us-ascii?Q?4HPPcku/Y3AvuBrQB9vNFHM6OvkhP1UvD0p1pXx8QQykS779rvxbpP0S73Rs?=
 =?us-ascii?Q?V75A5Xhr/r6WDlVqKj6ltknj78wVZpAHReB1PyjTyIy+c3D2R+j6AI7k7Kdi?=
 =?us-ascii?Q?vIv6Sw7seBdLU2VthkfjlY6uZ9OadyHnnEMIknSmTQ5rtX9s84sm5SZIV/SP?=
 =?us-ascii?Q?J5DSZCOaFbY/jPIIGDERw2YoO1DiA9mFeGBdPPvJDYokvftvKV5oMV66ut5s?=
 =?us-ascii?Q?OTgmb9K3GUwv2383lvJ9eJseQT8lv7O2jWvLAYZPd7g+IbiXJ74FVSZwHPzr?=
 =?us-ascii?Q?Nh81D0hyEuktb7l8Gw+WyEVzn3yNRIPS5NzzvXurJ2zyHb5oX3VnGjat7plZ?=
 =?us-ascii?Q?2HKflbz/CqAqiXNyI55QMPIiXcCk26yYD/wNF1TEGo2DnGqKlHycwNeiLb6h?=
 =?us-ascii?Q?Py2WDetzB+k2viR29W8hNeRKkyC7bReZ8oNmFnUjo7b7qil+sUWSfRB7TsX8?=
 =?us-ascii?Q?F3NKtL9WwT/N5VrLbxuFMLordcFlybTCI8oLiddfIZSJqzkI9Hr20PhQ15el?=
 =?us-ascii?Q?G7i441KTDgvOmZTcCI7FdApgljzIOZNoqkgDSv3zVeUPOVSMPlLKbc3USluQ?=
 =?us-ascii?Q?Gw/t9G2XJO54dit6VPCApuAV+87gVbB86xgwZA9QXVRt7JCqo44a4yJuy1Qg?=
 =?us-ascii?Q?4r7DjqjYxTPcwsgNLcRu6NwfUYLyPIeTvLw30wsETVAiNYC9LOwBkqOdv3BY?=
 =?us-ascii?Q?o0PIqFdReMkehs1B6uRuAZU43MuPSIsXWxsfuDE2b/kEugW3HmEiM8vY/pjs?=
 =?us-ascii?Q?OZnPqQ1zGpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ua0C1yOeYCwkUg8qSffAJYMBesPCeBi0TLCsY1oxJD6sGdXUMc7CEUlIfbUS?=
 =?us-ascii?Q?dLwauLrjfXybJ/OH+y+SIetpZGAD+uzItzl1KNz86+kkCAB0IOmmlzR6Qs0E?=
 =?us-ascii?Q?JEr7w97QIcu9F+gyS0sWNK16PV8xsOTNJr1tqwEVg1qAP+AsdS2mT4qggiZQ?=
 =?us-ascii?Q?wXPToBb0uWv5ELD4yeFXARytEW0LQkG7cX/G/C1g2b+5Y3OxSDu0on5XDCh4?=
 =?us-ascii?Q?1L7Nhs5E/L8Xel/7QM10EvTjWJSj4p+Y6ateSVYwi8OVv4XgofUbgVxvmUN4?=
 =?us-ascii?Q?BfTsxcptJbhmHe2QMIw2DWVVpPv1oet7tLhbpY8lXk0uOCMG6QyNcENGBpJ9?=
 =?us-ascii?Q?d+pjVq7n+3hNkpfIg+lZuuqnozU7kC9en98x553QZLz3Mg15JBraXwu9CM6b?=
 =?us-ascii?Q?u0ZrnOQQj+DatTtg6dS7QBwV645t3x/Y4X6nhH/Rf97wZjJcE0PCC3fVAtLN?=
 =?us-ascii?Q?ni0CTLsg6A6CsSRdVMJvh6tv172PckY5rD7+LH/HwyPFrnYXEI3bDMaYPyqu?=
 =?us-ascii?Q?sXkjkjCvE1AdpOJVi8a1b24mEBYpnfgSZkzHI6SL14k7Ddywihz6Vvb4TkkU?=
 =?us-ascii?Q?0hzeE9m5rMWDY2VV553tQT0GEBdZpQNnVdHdRJ+POCUQ4q3dTOZk1Tb48sG0?=
 =?us-ascii?Q?cngekDg+kyooaGnOK6tvkoAujf9I9yNes7Fh/uLY7fztosn2ugibyDfLdfyq?=
 =?us-ascii?Q?hzLBRmSEjW4dyLArfgWuKAX8QgBy4NS+IymLHcUjbom0TzUq0pS/7D9kX+E3?=
 =?us-ascii?Q?aqSqaLxWSo7soiA/CmL7D6cQcQZs1k3E1zwL/+BmrYh6wYxqxbsb45y6zwyq?=
 =?us-ascii?Q?6JourrEAFPXT+9+GbKotBx9l6fVFD9mo4jVNoS7Xdcf9i/Xv/H/euz/vDUma?=
 =?us-ascii?Q?OKvZmgLgo1Nq6ZFPt9BfJ1245b/6HPUQ6YHIW1LCI46oZaUF9BfDwGUTWpJE?=
 =?us-ascii?Q?0hD0UkRLptGFgRHztsrsm3RyahUR5WkLM50bWQ/DkWXAHkGVuzQ5k28uDl30?=
 =?us-ascii?Q?+YYE5NKite6ofLw1/VCZ4SVl3hfLfqo0Z8ov5Ys9Wssmkd8QJ9fTmAdUqe2W?=
 =?us-ascii?Q?yQ1zbvgn0iM4i8wacDv4Nr3hasN8K/2jj/R+HvInfJdD5vZxgP+N7haqbuYs?=
 =?us-ascii?Q?+2uuta4lXBDxeQBIaqfWq/YkRUGlc9K7Xzkps7kHtPmlsB+6VGiym4p5VBh9?=
 =?us-ascii?Q?wZtaUFG3Kw3B3cT+dXToGtDmkuPXbxgutDnXpxpJf3Gs6AwJc1XDecgL8rQ9?=
 =?us-ascii?Q?CAD3UB3rx24vLW9nVpStB1habtHiZ3C4dJfAEWkCKe11dJNyOv2esjlJ+spe?=
 =?us-ascii?Q?tl3PjZSKUa+QL1LhguPxOpM7UbFtB6lJ0OTvvbQI+w+QIiHqrLZ94PdZlh4r?=
 =?us-ascii?Q?qWuGXAbjWYyYnM7A2KzMlem/0C6Y6u74+bFT1KzdQPFbzgT5b+B2qarZp4gA?=
 =?us-ascii?Q?jixMKInekqEhaFp+sBz3PckND3dNeSMzHoS5mLBmUbu87nQMTJNnKwO5zDYT?=
 =?us-ascii?Q?caeu9N9E/6npVnRKmslIw2lAlz8+DWZvukWfrS3C8lu/9/Jw+GFpbw8iXOZC?=
 =?us-ascii?Q?tah0OUkiUS++OpKXQK3ePvYQWcqzvBItKwcTYz+M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c287433b-045a-4dd2-8aa9-08ddbafe538b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:26:04.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT6VbvF8pXvO61RDV52F5xPORFvQDm7emxKfLA75TJyw5fL1arltUzOL0Oc1h8B7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550

On Thu, Jun 26, 2025 at 12:34:44PM -0700, Nicolin Chen wrote:
> +static struct iommufd_access *
> +iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
> +			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
> +{
> +	struct iommufd_access *access;
> +	struct page **pages;
> +	int max_npages, i;

These types are not int..

> +	u64 offset;
> +	int rc;
> +
> +	offset =
> +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);

This is a u64

> +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);

Length is a u64

It should be

/* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
if (check_add_overflow(offset, cmd->length, &length))
   return -ERANGE;
if (check_add_overflow(length, PAGE_SIZE-1, &length))
   return -ERANGE;
if (length > SIZE_MAX)
   return -ERANGE;
max_npages = length / PAGE_SIZE;

And then max_npages and i should be size_t.

Otherwise it looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

