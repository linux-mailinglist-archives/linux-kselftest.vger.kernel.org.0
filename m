Return-Path: <linux-kselftest+bounces-24383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBDA0BDCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 17:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A7616A38D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C912297E3;
	Mon, 13 Jan 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ju1yMqRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D51FBBEA;
	Mon, 13 Jan 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786445; cv=fail; b=IUfgZlGMbijveRyvXNoMyTwx8xD07Ca9p5VkLSj0tFS0gW1iNR8nzgVO9/WW/+gao37zfkZVjoRJsKHc+6xWfDeS81kfI2FQ7HckKH5aQtQwAaens0UCeX5OO4A3RF/VkIKkIKbUHIRLx4yY6R3sDc2bK17ERiNmGAJSm3ueKK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786445; c=relaxed/simple;
	bh=QnKlBB4pWTLJhy4Pr3OmmpwTGLhoORaF4yly6b8dUvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bNh+y/CQBy2Jj6jAa55TiLaODPgp5bP4xSG/jJRCRx8oTM6MAqm1P76G8kb8bbc2yVxAG9Pa3+0jWvknzAGPDVksubLwYWPwVff0I3sNlKE86BACL7IgWA7M8RLKeKqgd23NTzvRdO4sOeAPAFyDEByg2Pf9G9WjTaojMTAFwAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ju1yMqRo; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNObtvM5/NMvHxiHbtfcNYDVVhNfBLiJBYRc9iICRKPiCB8gSrar8Il+5rMygLwByda/zF0e+ya7U76m/fwALoZILmcmJkP3eBUfPJ9RnU9/tp4S8/pjPwdSg6lRSPu8e0VSILlHE3QYxstiXTYKmok3PipX5YzsyvExKHztjX7uA13GXz1zl05Qe48CCSJ1ZZDI97nOFu2I/6YORDW5WVF7h6vV/mTmphuqgsZvYr0AJiqJSPnMjCVeGKeZ/xPEYf0enacYXosn7QI6axE9XpgGOOjL7UAyFbt4FT5OM4ulRf8vSsfscrVkdLml3PqYWNATpHVA4L4YrgqfqYCHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnKlBB4pWTLJhy4Pr3OmmpwTGLhoORaF4yly6b8dUvE=;
 b=JDNAyf7tRT5CEQ1pMjNpsOmEQkOrdJRLyrTq8Ik7gs5EY89TNq7ihnXPZ97F0GwtV6vk7zY1p1uJOFYs8ZCUXiWhDINqEiAq7Fyf1v75cOtXExwGDCcdJCn6tVkda4HlP4AoJYCXua515HqdMaHiVTqWOuoPtOJqcEKIQm8NgHgZsF9Bu+GxOWekledijxas0IuLk+xVXu0K454tPDKybayHDjM8m/tkzsDcHBtpHQlqNNrYKBptAMHi8QsSRo1k+ex1zpgjxFd1+C5qVVa+YatF05kG/NGfNfg4PNDSRa/nYz7Xu7CA9Oeek9MHGn9AtzAipylE8fb2xqIUGEyLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnKlBB4pWTLJhy4Pr3OmmpwTGLhoORaF4yly6b8dUvE=;
 b=ju1yMqRoOuDkglKXbBQYO/dq7GWUCSoSuDIeALnIbUOMRLkvpIzkk77XdVjJyeJnQAqCaZFSKSF0FuCKE4zjg5HmRVh7iZK/7ovQmIUWbaqE6TSAOZUBgikCXKgKNmwmm/XsSlclrEYPrMs71wh4OyHmRGYPSty0Tcd9fffKHeBTX7zyDcz6918wut5xlSPAyJvqS8Psp0MTsecGd9SXkFM2fKVlgdz38EyZbQX9LOkCxTDqIo6dueC/V0edyVHfpyJmx96A3E7p+TA5numPe0jD6qZlAbrfuRftT53Lms4W6Dt8Qne7OjYwRLv4COf8/k+fLZYbVY+UNcHsh8aIgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 16:40:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 16:40:39 +0000
Date: Mon, 13 Jan 2025 12:40:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	tglx@linutronix.de, maz@kernel.org, alex.williamson@redhat.com,
	joro@8bytes.org, shuah@kernel.org, reinette.chatre@intel.com,
	eric.auger@redhat.com, yebin10@huawei.com, apatel@ventanamicro.com,
	shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
	anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFCv2 08/13] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <20250113164037.GO5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <42c6ff3090636146a86501528eb03df99f83381c.1736550979.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c6ff3090636146a86501528eb03df99f83381c.1736550979.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f35b9a3-5bc1-45b2-77e8-08dd33f10323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uWMU17Z/9vkV4ZyqZ0LNEsH0n5X4a7Zfbjc8NJW+Nt1gkgSfoQlNFbFFxr2L?=
 =?us-ascii?Q?kXpndaaOuWqtDnpfrW5O3mWU0jqdGHRCnAvWQGGyMc73B/ER9/KjVkBpGXMv?=
 =?us-ascii?Q?48m65kVF2Rrv2rQxL7gkyAjYKuYSX1aFgfsH1hLYMTfqkkqEvNke0a22yF6f?=
 =?us-ascii?Q?aKhTVu7jWbfs8W/m8aW5pjv9GJdqdmzp5q3dM7Osb94QjAApwPeHF7v25ICW?=
 =?us-ascii?Q?Dv8jgDHuz4QmByUMcLbyAkbhjJNuDjOLEpnsdT+DdRCBwT6Ck09K16TyNPao?=
 =?us-ascii?Q?pBMN2NmRszyCb6pCPd28ub1rc+RkqmbK4U86n/zHcNUutRp/CN057gLJA/hL?=
 =?us-ascii?Q?1lSpUJLjIFgMu9FONH7xW5USG9vR2pXCdbflh8atND3ogrGeAd0w3DT3ZIH7?=
 =?us-ascii?Q?STH7ea9bY5b81cYEKzsBpyUHdLaWZnc6GVaVa4A98m5zNZqNXZmdLci/OTmg?=
 =?us-ascii?Q?t99p8vb37eSc+MhF14DdugnXeC1q+mhq3C0hucMd66fzGqdgWYqvSrYVTjjm?=
 =?us-ascii?Q?pQLa8g+V3HkfJurxP18U1EKQb1aomJweFJN2x+1vOCUVBmBuK9X2lPLqomN9?=
 =?us-ascii?Q?RfdnR2+wkIkChBc5dXQgGHWxEBFXR+REm+8G2S1bIhi+712e7EdO4HaYfXI0?=
 =?us-ascii?Q?caMEZ9yGVzMUcScKNRfwHup0U5yWLwF/2gSTTbSiroOjc9Ub6XM0uXODrdHR?=
 =?us-ascii?Q?BQGIrF0zGS1mA9RVmwgFOCbmOIviDxYY6mFM6g72fkOCBgnaXv2q/jQyRuzO?=
 =?us-ascii?Q?dRTeydFaeg46Zyy/fsbeP0icfYWiIv64fJKtLBhuYozrapUXVa/AkqIpFf3O?=
 =?us-ascii?Q?DREJIr/u8UdXg53jxsEM3YsvgQ9a/OAyVYD5acf9Ghk7kjgqL7SWltkxes0g?=
 =?us-ascii?Q?JosWFB1GzWHXEb26WTFj2if/6YgKZxtsvj3AYJ8ecmdVMKxy77gkHqKfDQWM?=
 =?us-ascii?Q?5QSO48cf5hq9VJkkp5hm4mOTFnH3Sld0cM3xjIriYFATew1LZvNZ6CXGvI1h?=
 =?us-ascii?Q?qfHkLby4yhz09vy8yMXLwZIdem6VkcA/nXM8ArQyHT0LC8t34b9uTaR9F4ew?=
 =?us-ascii?Q?Ne/8wG4HLmuFZDB7KWsjYn5YYJHRF/O0N74Gngh1bnpxxPinRDGwi9cdr/i7?=
 =?us-ascii?Q?/1HWFPvc8Inv84mOvDYPSeYabh6kCvKiCoCGfYwBjDkGPjNuNrS2Sc407kAZ?=
 =?us-ascii?Q?lurvHetwEEW/rgm6R3R9XSUNmKnkurWe3Z8k1X7ifG9msCFIs3empF4O8Qam?=
 =?us-ascii?Q?tk6pEYRONrwsUVT/WfIYKcMT7emLMu2JWa8rMw4zL8sfwazx9shepzn7L6tR?=
 =?us-ascii?Q?YjfSx/oPQYMY1ZBWmv5VB0267KRB21nPsMJg0TfA2l8ajOGwK2jwnaYin81s?=
 =?us-ascii?Q?Cxuq08WadGYes/kmQ2awdennA4JH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLfzxvzDhdacreZHj9GsiSlpyekIhQ2oFT+H9CphBDviYQQC0H3Z9OWCmKSx?=
 =?us-ascii?Q?LTmtdeLGaW/drWBRTPUK2BnTjPAYNI6yQSR/BgHEz4pscGs7JYh4OJ4UyEaq?=
 =?us-ascii?Q?1SnLzUo/QkDgCH9LQETXFnM0/X2gw29KGnprHIXX2t+XSGusgGCLM//2QjVi?=
 =?us-ascii?Q?eY5xxAoRQkkgE4zwQ+dERmjwNCSgcqiYd8UiaR9ghLr0SALovR0Fc0J/au44?=
 =?us-ascii?Q?FBVTTc7X64BApGhI1uBNDZ+iZqOVBNU90O3dgObl/4UBikc3A0c0uGe6EaG3?=
 =?us-ascii?Q?o76m2CqvoHFaPEqVXRPCe+LFwAi6CZJwDypsHtieeU4CRf2gRgzmj+wVaNYP?=
 =?us-ascii?Q?0WVPjfmGYIWTCsmeVjdOuKv4p4LvgxmrDVD63DcGM+z8D50ywSJL6uWC7+Ub?=
 =?us-ascii?Q?ctSegxbIza1vCt6m2fKZOoqPU43W8HU3ix9KiP6udSjfJfRAiK1uTT5aKyD6?=
 =?us-ascii?Q?/d29WKZujJFUCMxB7E63x9uwtfuCt/mJsoUMIBUSOwpNmL/V5NIB3xx4oyCD?=
 =?us-ascii?Q?aJ44CIpNug9AgvjNERHgGIySVUlFWXA3y7wCWtL5yxQeK9UBVEihGiyDnowB?=
 =?us-ascii?Q?HiWwMg+PXy8H7MgQuopbQt4YYpxSdnQGAxAzovLSTAVlt3BKLGz78qAg3DVV?=
 =?us-ascii?Q?gttHPjErJ/Dt04X9KGLeZjUAW+mpLH+oiSjEoQRCkWYWKi/EjHu9NtWjrPBU?=
 =?us-ascii?Q?XnaeFkeRct8Muwfsw4yIKC0icRvdYxB3V5QRI+85626GEnrWYVuM+Vrc+WMC?=
 =?us-ascii?Q?j9iyBovHuLJ0o3JVH+UILYT4uV4pHSel0wGN6+H/IIwSiPlBl+2pfOplyjFh?=
 =?us-ascii?Q?3oMIPeSLN4Ir+HXWDvaeS8YTfJYs7mHpU0skc49fIxWNaaDrR+Mh4YsBv6p7?=
 =?us-ascii?Q?DQiI9kcNiylfzeWE+LfHdFmSDI96QrGO/UH6RzdUz/Rg3aIxzXW/C9g1+8dY?=
 =?us-ascii?Q?wYC6KArRwJNNnAThVY5IyRrifIHE4dXGi5QwA2OO9ErW1hstn4Dfa9qn4+16?=
 =?us-ascii?Q?gB8lRuxSRPSFcZM82Vcl/HxEFCVBZAHCEdLyhKbaDl5yN7FljlsCr6cw9xSw?=
 =?us-ascii?Q?S0a8kNY5CuAQq91ANAyLQsAEOrPTOfJse6+lxwI1M14lDxyUXPFw61ppHlfZ?=
 =?us-ascii?Q?F0fHipFxEJHFLZg18VlT5e5W3qm+HdGBUYjTfCpNdmpXwx9imkbs8DvOjveA?=
 =?us-ascii?Q?uUR06ybngLUJXFWyImUvBtMzLFn1GLqle0Gz44FbIxzz1PE5cTwY+rLbjJ4z?=
 =?us-ascii?Q?c6q/Qsn5zXF+y53qx22QD9pl6Xgm/GvTnlIQeUixHGeTyV2xDtGgdKzC6zdy?=
 =?us-ascii?Q?y8wiazf6qAUjKfNmYqJpzRtznT8TSSGmxAFGokZXmMyrcOiS0wTrrVB9XCVf?=
 =?us-ascii?Q?MNMtb9u/RsV2r3eYXonUsEpcfWO39ZhQLaLJ6tXw0mfV1rKEJ6gcb5xBgfyS?=
 =?us-ascii?Q?+YzfaIvnKlMvGkorGIi3FSpQhzPf7Ld/0TjkdQDh98FcyzfqUCxNmDngFdXK?=
 =?us-ascii?Q?PY6lyYxuvqu568dSZifsdApthGsqIK6ARS9cyVQlZNs2yEkgP6ltKOIU5Eq7?=
 =?us-ascii?Q?i5vEwjF47Pb2J40MX34=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f35b9a3-5bc1-45b2-77e8-08dd33f10323
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 16:40:39.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1rNZs7iLCT7Ev6SZBy+NlJFrSwvh/twMuJqaZrjTFoGn51BN6uGHYMI7RmJ8m+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495

On Fri, Jan 10, 2025 at 07:32:24PM -0800, Nicolin Chen wrote:
> Now, iommufd has its own iommufd_sw_msi using iommufd_hwpt, the iommufd
> owned domain's private pointer. Similarly, iova_cookie can be seen as a
> dma-iommu owned domain's private pointer. So, move iova_cookie into the
> union.

This commit message would be clearer as:

Now that iommufd does not rely on dma-iommu.c for any purpose we can
combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the
same union. This union is effectively 'owner data' can be used by the
entity that allocated the domain. Note that legacy vfio type1 flows
continue to use dma-iommu.c for sw_msi and still need iova_cookie.

Jason

