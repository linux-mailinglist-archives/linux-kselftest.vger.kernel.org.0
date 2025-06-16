Return-Path: <linux-kselftest+bounces-35074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F092ADB2C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74811885535
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A62877E3;
	Mon, 16 Jun 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p6NRnFVl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A82BF002;
	Mon, 16 Jun 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082324; cv=fail; b=MpshG7e3lkJito3nW6iaXfivBGEeKMdPcbWtGA05FibchltczZ+8gB4QQhJIqD9FR7bwxucLDLsn4mNSZpcS2UzLcAfaiqAbYTpq1aWh7fJVAZeVVXohC4fjbWaY+nz2A5xJ7Nqh/IxXFoM3bzOrjWmg07PUpuKwl0FZblvzdZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082324; c=relaxed/simple;
	bh=w/x7w00Y/rSDMv/kaduA0cfvhN3PAt9wc9VE95wT/5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tqe/piCW0t837TH0YGoCTstNtCGNzx1W8/S8z38zB11vPe3ina3rxkFZZQDe+TDfJiqqvG+RpPjo+q3iw/Irb+pfq13mboxk0h1nbuV4NR7SJVIAI3AiXM9C9EPeyv1ZIUQhyHvSwSkIIjMg+wbRzEZo3kFetL77O446+JBb6/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p6NRnFVl; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK6bxhWHPB3YMCF1ffuH9zklnszFU3oIakr5BaD5QklFie+XDcbhtpTmQ0fNO4JlVHE+r3aG86VBaGcn0gZFZVUxzO8xBT1lkexkokIlSck0X9f6tWtRJ/bllACBYXv3DHPZaDpZJ1vK/7EqrqD72F017OuyiPDiqGgqC6CWPrSNlAsD0aO1Mvaj5eKcpD9nQSx0XCdg8c23PeEmLHhFEJN0HeQ5aU3a8pGUgKCsvUZl6ClCqXCczvUmb8mCCjxOPzf6Nh56x1BLvFU5dk8eEUfdqkKzuEOABQnWFbhtzxCXar0mYZmxSjK4FeXAMz9Qc3xAHwGhYh1/OK2ZjipWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bTh3JyHWUWoiIiRb6ioCRxj9LT1AO/qAGMTNwJsBxk=;
 b=qyXJkIoSfOeKrISkc0s4yCTkh7JHl3wdbc3AxWPw1rSGjGdyDOHEN/waac4HHvJSmUhPwR0Nuc3EZsIAn5eyPEt3lWOvzi/QAEUfMLO9R758Tqge1NvOB/oHdcW9b96vN8RQ8v5vvgEL9Xli4mcOp3FJ8j5bGzE5gy6roJrv911XbP8D7/GRJPDYZ+AofqACcNIvoCLAwSFly4Qrkj9GEL/x+HSAbXLZTK+JB4Hya4p+y0Z/NLk8FocwRJ2JZCfXCCZyQV6s1h58jK0RgNQAMaxWA0ki1IhK5zQuhQsF2JP6IfaPnXvZZKOvIyV83Z8UrE6VzRMspxxn8o+kvYQnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bTh3JyHWUWoiIiRb6ioCRxj9LT1AO/qAGMTNwJsBxk=;
 b=p6NRnFVl/3BoWaZL3RlOO/P7ArvgPAbb7KwZFcYzUeg+TfJMUTyj6KwY1CDA1JPt3/Ssd9eo5Aqo0jAq8RgO9O3EvBp99NTGOR/jq07fyJQQ8hwh7tD+FHsxBTZl2nwvKomuUjEvynL/AbJYR7P62rxwjIoApB8x/OcYGXjdZsQDsLt/bW+zNkLCknD5uqW+XP+yyR7Z90Oez7RpXSrH7U8tZ0YVGi/7PyvYkdkGDLIJZ2gmiSUrkfezWqnOQn/vJ+vSiDQDJ0AS0fft+fAUeKffOPUWp5C3CKdUKfQL2iHmDjbFtef2PCjDYuuzpBreZhmSY4bU3D85ymMzw+lDag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 13:58:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 13:58:39 +0000
Date: Mon, 16 Jun 2025 10:58:37 -0300
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
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250616135837.GE1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 9129a65e-307d-455d-3982-08ddacdde50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r2Dqcd7ZN4BErRNVpgSu8MN7iZZks6wgVEKWvY5Wv+a51G4Us325JVfb5rNu?=
 =?us-ascii?Q?kbhMzkNXDSMdrjV86wOYv+N71sS1HTuw52/EbAPILPedQdviUt6oB8UrmfJv?=
 =?us-ascii?Q?HTCcM77ifGdNSegvcV2k6sy528d5xNpdYjH9RQLjRSGVM9ASET1t+mO5H6Z3?=
 =?us-ascii?Q?gJuHIYuAn+m/rhJVNvzLWcRmDnhs0YjqT1RGB9iuohlLabLqio4/GdHxODM5?=
 =?us-ascii?Q?ppcQuIWlHaKrsJzoUDi01fAauDSh4Njdub9yTZEH34dHlgGI9FW30rXoLB5Y?=
 =?us-ascii?Q?bz5jZBN8mixl+wq/aaTcZLmycC7zmCCvvukoXVj7ci2DckKxiH5HcZ/WOwW/?=
 =?us-ascii?Q?CYXEd1A2dDDOpQ+QZSkWhImVxlYytyc7WtBotc/00IQZLOXdRvmQq0YkU5qi?=
 =?us-ascii?Q?qULj5TkKgc7OB29gpC3j+ejTKpZLUZiR9BtE74IianbQhvzJ2Whbzm6HJy59?=
 =?us-ascii?Q?u1gkEZH5Sgydejv5v0jthSB7iWIBY/wC+5+d0l3f4pLefonqCcDqQ1k2CSOo?=
 =?us-ascii?Q?qDEQQOXkxrGoKzabShBkK92o+ciWipS0ilqGIOObYXY9yiGaRhiD9anI9/nQ?=
 =?us-ascii?Q?klTMUgbS7ZPQ5tZUHU9fu8kZYEPTAkJGvRnSYi3X7ft8mu/BTmO59+sQGfD0?=
 =?us-ascii?Q?z7SpfonKppTKhR2smjjWG1+6JzRAwvB23P3YUFjNw3sqInfmMWfHf61zHhdG?=
 =?us-ascii?Q?9fMIOnghqHQwrtUnSWaXITVNu5c8O7CYbaHvkOXWz2ZKiRMdagbvUXBLiMYA?=
 =?us-ascii?Q?uySpxBtJl4rIZMSqP10PSDTqQdkvIuQZa2LQ7gA9jlA9i4ugerMA0f7CUN9j?=
 =?us-ascii?Q?pCAW14ONhAEf7ygXpE3kCB07xkzcfstNTClSXW2GiRM4fCBTHrqwJqId0CDT?=
 =?us-ascii?Q?AkGyOoc7TU52Dap+TugrGWY1nHtB248qZecEB93nrXNSk//2h3z4JnBmZ7f4?=
 =?us-ascii?Q?Gwm2JDWR7zublRjLE3chxdQn0KPt97jirDKhB1T0qZV1izRm6C6nJHymnQGc?=
 =?us-ascii?Q?LNsLDsanJdcdsuL/hvpob/F2bgg2btJ+2H+8ibJp8HIsZN05YQ5CkrOIDWIp?=
 =?us-ascii?Q?i+PI0D6rtTq1646/RNEDlljA4Y6E3Rt3jefOjhirDB5UUKrUiS5/dhfp/7uD?=
 =?us-ascii?Q?ULFu/AQcgORex5UGv6eKcbkt+LbDfa0s40IhZYHLUKbxASW0sMUT7H9XYR+a?=
 =?us-ascii?Q?tPOGqsiffTQXWYUgWQysx/xlZSSUark0uOEh4X96p6JovfShCxU5pZPdUbBc?=
 =?us-ascii?Q?EeWZ4hv+3Hfk/N9PoVT45Y75aqUqtuaqMSlEcCPPHDFqOv18zGqsEwy+jmLI?=
 =?us-ascii?Q?9B5U8AAHZBfdWtedzdGw+Qk+FmINw/F8GUEvpfuW6UvSn/2dMIUongWLSv+7?=
 =?us-ascii?Q?n/Xg1sO5onVU7ReOFNECTLdJ9GKUhSZGRY2STH1Q9gNNKOPWhfYrNOcip71w?=
 =?us-ascii?Q?6pKBX7yZQQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpkEks5qlWQKPMF4Ho4cSokrOCnDXTPjgeCL0TCNgsP1WiCJNw6ADyiBsVfP?=
 =?us-ascii?Q?O+bmwoc+wAxckJRCp2l3A0fpdU3P4t+Y4IYbx+wXsERQ1CALVbkkxwcOGxCU?=
 =?us-ascii?Q?uQlDxjcCqNdtrKE07THZ0T6KvEViM07qCF45Ym1K003jEwBlgbxTTbHGxW8Y?=
 =?us-ascii?Q?rTRqhJNZr9X7HWMvcTI1ZH4RjQCmow9XHWUf+QGh9xq0Bb7jh0uUpaXzaSDn?=
 =?us-ascii?Q?qAFhkr65P86419bFBPPDMb3gM6uwDrRC1FTFYmrWLWeP4jm6WlW6hgBiwiB0?=
 =?us-ascii?Q?spgkWtxdFR3Mhfcd98pc/8vGPDHS9FQPZCKtW4GtmQauL3XwSeg4KwroofOL?=
 =?us-ascii?Q?efUbcr/75JHRBamKlD125iMuPiEEji23smTt71+Kr1uDLyLeoQOjQ3S1P2MZ?=
 =?us-ascii?Q?vHs9GPQh50+Rg0/SKgzcoHNxVGtuo9M1QS9PYTW6fyxpBMTX01ROZ4VjYs24?=
 =?us-ascii?Q?rnVTubHk3EiNlNkaCRkyQ/o1CsdWw7JZp6saE518fQ4Q0tGjShCLZu+d5Tzz?=
 =?us-ascii?Q?5oX8uUtkTyc81SmxkFS3HUGKnrOk8B93e10QlDW272X+/VX0aLTtbIAkXVuf?=
 =?us-ascii?Q?OclkY7yBcVf7wK71g52hgZZwbyIss0qE4I8G1bG/cm2x5thRCbv0a4r/6cqm?=
 =?us-ascii?Q?WH/dtGqgr9xJBDDapLvDb2PzpDQG2E/o+wsvLirgKI0pmOXYRi9EI2/YqCFq?=
 =?us-ascii?Q?AgKbmh9QrQOA787EznW56pXiob8X/A33WCMyBWYdwIl21Eir/KCW0y8THcQB?=
 =?us-ascii?Q?XrFinrbMpQW2URPCgHqNwnPoeV422C7ZS5bWRC81c/4nNQ6VBGDFyQo+bo/V?=
 =?us-ascii?Q?ij6DeWn8V4C9ccf3bISIEe3TXEXMa+Q+qDZOBrH3DdL1ysEnOtLnkKv3yGVd?=
 =?us-ascii?Q?fB9bTmVZ8W7MXw7UjxUgqO8BD3//IYXif+2aytiDJPntQ27dmWg3znZkiJVl?=
 =?us-ascii?Q?plC1Hd5KN9IjeRVkRa8TG2oJLDyRMiCSCB1tkorht8BWjW2Cjxm6IjdM+Jps?=
 =?us-ascii?Q?jZBWqfgVu96oSKD18zh1vGZZoAscUe6eS147RF7yGp02S/XHPKPp7RIdQ/21?=
 =?us-ascii?Q?I/cs06AkUnkf5uqhyBshFD1Mo1qk1OInYmU0Ch58nqHS+qX9vCj95iv3rhRu?=
 =?us-ascii?Q?xJ78+I12FfY8wP8T5AYv7Dkyir4SXxAb+PXi9ZpmqXEBdX6I5EXmnaF6vVt0?=
 =?us-ascii?Q?o5kWJTTOlGxZcuEKOjeIw02l5QAxp6xQkMuzIFrb7aLBAdr5PKg+UWPCDklb?=
 =?us-ascii?Q?X1hCeG+WWLG4FYeIG+WBAgFvzrXe8JhWdaJbTMgyyrnWw89u4vByFCwQsv+G?=
 =?us-ascii?Q?iyc/zNdeLIAeYwsKKCAoXB2Doy+4bUwIeyxIAL/oErt33yZlXMUQ402bHfzf?=
 =?us-ascii?Q?I8wjU93WYHOogIV2SFcncHFsAqEdCkhg77Avy1Wb6iIG8SuYtoHKA5BHyYXS?=
 =?us-ascii?Q?fzCjPr6FTWXe4jWR/RgTppWWcoIt9CftudVxP/Ul2wX4eqb5RJ6z5vrq+pOl?=
 =?us-ascii?Q?RNX7lUmh+BV4NNFN5wtYT/sGVkvFJRawKk7VI3BZizHs4IPo2LQTYkQLyiCt?=
 =?us-ascii?Q?1dOLtx3dg/BvEbc+H3StLyvoFtlZzUr2k1OCt/+A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9129a65e-307d-455d-3982-08ddacdde50b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:58:39.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBCysUCCtQeA67sOcUU0ljXAgBmKxjybMi6g+SqmRimIAcgy00xaDpQ/1TVcDV4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On Sat, Jun 14, 2025 at 12:14:35AM -0700, Nicolin Chen wrote:
> +	/*
> +	 * FIXME allocation may fail when sizeof(*pages) * max_npages is
> +	 * larger than PAGE_SIZE. This might need a new API returning a
> +	 * bio_vec or something more efficient.
> +	 */
> +	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);

Use the kvcalloc variation here then. You probably also need a
GFP_NOWARN to avoid syzkaller blowups.

> +	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> +	if (IS_ERR(access)) {
> +		rc = PTR_ERR(access);
> +		goto out_put_viommu;
> +	}
> +
> +	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
> +		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
> +	if (IS_ERR(hw_queue)) {
> +		rc = PTR_ERR(hw_queue);
> +		goto out_destroy_access;
> +	}

I think these two are out of order, alloc the object first, then
do the access and set hw_queue->access. Make sure abort will clean it up
automatically when non-null and remove the out_destroy_access

Jason

