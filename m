Return-Path: <linux-kselftest+bounces-33118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DDAB8F94
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A8A174496
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB328AAEA;
	Thu, 15 May 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XtkBEjTp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9728540F;
	Thu, 15 May 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335588; cv=fail; b=niMdmSXNN2fysfTldOFWzXGBDqWJAJitKt4K+tG99mNQ4SN4xITYhduOiCZqcxUGqv6exBon1zKICztFFAhzAtHYW9/Jcpfno+NZGuLr+h07XjTNP1nozBQoQaqeTN6gSqL62v3+EuqW3FzJiaYg3QAOr/okIvEHGxCSnMYw+CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335588; c=relaxed/simple;
	bh=oAIxyeHjgEqvdXXla88TNf5ZI2wKUyo2N5akAXn60WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GgQHMwkrG8thxC84iLHqnOic6xXdI/Zifz9FSsr2ZXEY48XXBGIkzHvQj8XOBrRLJOwDdXK2z7iSHIj+1pP9lkO2SK9VR0jb5k0aY/cs1cXjEwKbU3vN/k+DqWkGftPQ33bI1FzwuQp1sFopxuJFQkYtzs0yUS626FMGCPSUxvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XtkBEjTp; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alNDMIoigcLGZDClgKvhPni7Y2SaFEnQRxUny24Mxj6bHjc6+HzgrXOi/t2updvQps1X4sCJ1Xp7sUC+pUyDxHGDSFItto/bshpO1slcoexnX4q05HP6JwoUXMHMNFDID7EZXNrNywUIhgn5gbyttstBICwtgCOR2hlOFYb2VB9BeM8cJqxZXLBw/qOB6gxJTyOyfQvaj9jWBbQncVW/TSkdQUV3RhUqwgN0PUtZD9mbuJ+Ndh7NRXQOj8J/kk3eeOtPqyJyl5rK84PLA3vmHspyBMbf2qxkzr6zLNxRMrEXb862UE6WGXDP5DyqXqpCNbJFEhPz6LMHk+KwrtgFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSuqZhzgHA5wVKUrbDbyttnHwgcuaT3IDVn3MMU04hA=;
 b=rIYMdKqREQZfVI8xzv/3lFVWYGeJKghoj9DlrB9gOok3cteHogxw2YdqdrQo5zgTKxQFUo88fwoojmqLoUBbU2v8ufqAC9XgTsq4H2+Lt1VeyEju7xq4b7+VnLzc1GKfU4XsuvkHnHrPIo/VPVW4JdCxi/IukhMqOmI0xskZJFfBzRqpTBIcj4H3QK83ORKHZsLn/BJYT8g0rY+wT6eSasNlB1RgBCzpcxOh4y4Nnphl6FkxdhKj9xU2BQmj381CVAAQcMmPgO/Z+LrTeIyZ404ogi2ooyfx92vgYE5HbDtZhyb9U2Icq1r9wCupRf8DowBibZwXPj1qTOSXbh5XgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSuqZhzgHA5wVKUrbDbyttnHwgcuaT3IDVn3MMU04hA=;
 b=XtkBEjTpg0qFr/yaGgzEiFE8PiBiLa2MGnxdy3zco90OW55vuI57ijfe8MSRN3oXP7eMugHV6jwhU5HkKeWSt0AEKYPd1lViGI4kVG97oW3UCjxlZKqDFePFXuBlQA1XbMqG8+5vNjEhWQjHrDpchFHRAICuzt0oOCb33B+IGZW3L13eQiVL6NGU0Zax/8EUnJGRaex/OS53rRPw0/dpOspnYJazxtSlpGc1K6paz4upnBuQtzUNP+O3ocuKhNV7GGeYhi9ncv4fk6P5BK4fMC96MESBJcGBhJm8oMsYmLAZdoAzurc35UyjPwt2Zr6jBBb8vW+WgCarxt/1B87O0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 18:59:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 18:59:39 +0000
Date: Thu, 15 May 2025 15:59:38 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250515185938.GT382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <aCYvjeZW+7NmUtoE@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCYvjeZW+7NmUtoE@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: d309a0fb-e64a-48aa-50fe-08dd93e2a4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAx44Lez2HaHfoLYz5TpRgaAcUaAHM993XbcGt6RmB+mk8wXTJEhwi0SWObK?=
 =?us-ascii?Q?3onutPIQd18hiyuNjB66wFPix5PbHjDLWs76aRs7/Ra/hkdCgktPEaxPxrgi?=
 =?us-ascii?Q?Rg36rGaODZo6F7RUlGu2NIWVDsBCeIF3i1wzfDMie1PeTe/54D5pzcCYuQdb?=
 =?us-ascii?Q?2tEvQ6Pj8hHqheyUAS0MNdd4upf5BVX8fvVPcD5WTTkxKCcX56au+aByKmgc?=
 =?us-ascii?Q?YZnCCTni2m9Cl+3o5KHEfotbIgyjzJ/aunnoDKjVePTLM4J88V7sicJE5Mnh?=
 =?us-ascii?Q?bvj61GlmbvK8xQNbEAh3+RYotJBFTqzQDb5bwHw6PjPNyGJRqByLKhnjY1AD?=
 =?us-ascii?Q?f7+FZIaqlhZjzkYDH9dOyCRShmCJCxeGhGstP4XMtn4YgxyZ6QjH+RnY7RTv?=
 =?us-ascii?Q?sSSnrGIQ4hrKvtycOekX52xh15oBZqF2y6k9mpCMPdhHsZqrqRmZhyn9X8Uy?=
 =?us-ascii?Q?2BLR9ssoy12jP8K+SSXyZ8pM+lriZw7ANJBXRlIBmC6B9/zS0yIa2DPsrAKL?=
 =?us-ascii?Q?9exXZBIEwQ3KVCyhTxmq2AShHxQQzMPmo6a4JPMECm3atY7FMzQ71oNWCRG4?=
 =?us-ascii?Q?Sr2JLP7TDbYPL+JGNxo5qbhGHwrnS5eFLbI48kx7lB8XZBEEXWAQOElvMm8y?=
 =?us-ascii?Q?GvPvKi3wad03Xfplw/zLFP1CoDEKOtGXmIYSb2YLWYMOGgm+UIYs5DiNESgw?=
 =?us-ascii?Q?nzfS0WK7oph/iYWrWCrt2YBnc0b8M+fLGBDY+7Dd5VcP6jTZsbtiWawTrCpc?=
 =?us-ascii?Q?QEWmygCqSMRHKm0GYX5FErJWQW79mA7raUVHclJn5iQZnaJ69KrIPgDJLyO2?=
 =?us-ascii?Q?t3K4bjKtGiuJ4cFOo/yt1FkCqEWwwFjPTkMwn1e0qCQu5Sc+tSRZYnuU5lqh?=
 =?us-ascii?Q?bNdjmRpT8LkGEEnolxB1GdKKUond0JVJsBhgTsJK1tYIRWiHUj17eNj1/pyT?=
 =?us-ascii?Q?AXTfxA6tO6jfbndSBwiFqJdIDMyXpgCVNV4yxMbz8oJitNr/N6OJ/JKzQh1G?=
 =?us-ascii?Q?VSRbJfvTwLQtdxU5y2I3YZdR8dPie9FRGxFqtdVoyKoEN79g8hpQgFpUHVQW?=
 =?us-ascii?Q?V97dI1krWKhPaBKP8nZBrIN/HrKBtNHfDuNrixjoezwnjg/M5YI/z3fC+1Yw?=
 =?us-ascii?Q?gwzna0E3Qf3GWX/4HM8PqlR4IhGS7KO1kpdq0SNEHPXLvmlsA584tbLaUkDw?=
 =?us-ascii?Q?X0Z9IDq7PFaFjV1k4g6ReaevriHyRw0CTy4BE+229YhkSufJRFr0UnDQYO7z?=
 =?us-ascii?Q?ilOOjhOikDG2XbUFbrT9pE0NDc+CNpm2bKZmzLxtzQeCtAGU1TX6RMMhUZB1?=
 =?us-ascii?Q?7B6jDuqs1TH6pYL92yRJcArpNseeT3iwG8avECQrTMqFykh5Ju2yE1mwC+Yx?=
 =?us-ascii?Q?6sm/Ktyq2bvxXXhX9P1ttHNYToHu+cBk8afKG08GQpL+Ywno83GYjMfiR51J?=
 =?us-ascii?Q?+yteE9ajXCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pnl6QXCElz7qfbFPBIZY5oodZVFHKrLtsIfGWcLyt9/uCq6aDp7ghGpb9vuQ?=
 =?us-ascii?Q?K2udtaX3qncWuA3takLZtJdUr4sAfEwFzJpXk7pd5wTOQNf4KYWx5J59cxZY?=
 =?us-ascii?Q?C01mq7FIoF2kGH3PnZIbI37WdV0tW5TCRlCt61Z2tuZaI/0GXHYcutDn4BWf?=
 =?us-ascii?Q?nIQCZta52aLvJ97dQW8ZopkFHZyKOtNXeGK5nCHpvxewlqpQu8TzxQhRqLp3?=
 =?us-ascii?Q?LbzzEMASJJxnaiiZh8jiAZurhfQZGYzdqJa/skjM9vPRuAvA9JbuYn9yuLbm?=
 =?us-ascii?Q?nd7HwVMduKlQfGJGcInuPbuPx5LXr8p/v1XrRMHfhkFv+a5Gg7o9YyZemQNn?=
 =?us-ascii?Q?8soQGkIPbNzkVds+SG0QosFqIsYS3zQOQDlgCitfZTsPapQihQ1RZVGU2ORp?=
 =?us-ascii?Q?cnRqx7rSYbdU/B/ARQt1hxf5W3ZmMCR1kLaSZDiTlqQ0oB9oUkikgC9UD4nk?=
 =?us-ascii?Q?i7qDb4MNlXtFC1UGdVpnEH0uiDy6HdShvdgzmXogr8Pe5BIZm6/DnL3nhjpC?=
 =?us-ascii?Q?dd2CFDIvtJi4Aip33kEubG46SJn9Yrw6w4Yi1qi0idAFb9cjgkEi9fQRBU4i?=
 =?us-ascii?Q?Phl5VLAYIFuXut7k5hdvHFORL8ffHQLIDKR2ejrYFzXTEptmE2MdwPuUgLkh?=
 =?us-ascii?Q?w5f9F5GgWgq8YhA2WXVg1H7be8xXSy+fM5JMq8Pp8ngCZXld6HCdAh8i2dz5?=
 =?us-ascii?Q?4O8ICHM59B9+MWH6sXaWenVROloKQfUlZRxKwoMI4lF/cTGugkUjE7P2jmxx?=
 =?us-ascii?Q?eNdTEflMMo0F+hVEA2pbfNbPBg6q4epmDw8Cu6C9nzj/CBpbxb9GsQgrW625?=
 =?us-ascii?Q?UG0XJqMAXf9FhJhUSIuRhT4+2McTX02EbAxFBeG+I+96XztmLaL1dBNzZDyT?=
 =?us-ascii?Q?Du9Tm0pC452W8e7BzHhyEV9z8T/Skig5m5pfkwSJ9J724vYmMB04UPHakzTf?=
 =?us-ascii?Q?pTY7nDjeIxnf4C03HubtC+T55egjFowBLyE8FbcMXK9HjTof69eorQM2JfiR?=
 =?us-ascii?Q?pzRBBVWlNQu9vZR2fAlpjdI2bPmRCKm/WwaAbTdwn/acJlOCNjmjW1Hrjbgb?=
 =?us-ascii?Q?2TMEvaNJuHu/1+0u7oExOc4t2+UweHKvFhZcJHXOq/H/LC8E4IdLcf/kt5i1?=
 =?us-ascii?Q?zvL8Kt/cjrIIUgRU+XQanrRW5f7H0oWKV5Gc/7sKJzMHoo4qtO7ZsRMeKwX8?=
 =?us-ascii?Q?/OrL2t//C8lHu43o6293YZjFIdYsVDQ/f9/qYDF9myWPQXOncQB/U48o60Jd?=
 =?us-ascii?Q?PactsQzOXTk9s9Wp4npAPXVS2eWIX4DJ7VIbVKzTH2OOirieZwbOd3Twl8uQ?=
 =?us-ascii?Q?luVuD0VkwCfs+IfZudeoEwypgAtGlKy78zR/WQh0nlSdqAr7PAPZa4jt1ivz?=
 =?us-ascii?Q?9EzwQIu1Q466guqaR1yzw4KrJfeGcN9+hFyaLEOWZ/c4N66VmWutGGOkk/eK?=
 =?us-ascii?Q?7WvB5WYPsTvaUFUiToZhKdRAdPRBImfUyUYuhIuVr9+OxHQ24VEMPwyWz7ov?=
 =?us-ascii?Q?dBI0ioHrUtF22RdiOLv/AjrTm7363LLkAUoCm8hNZXrZBIegtgslkfotVDsp?=
 =?us-ascii?Q?zgEAPuCIM3jv6fwB/w5ptzqdNZySPLfKZzERjyy1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d309a0fb-e64a-48aa-50fe-08dd93e2a4b9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:59:39.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EfGNr9R18gVozqWjBCTs6JfOGtjSNuLrE3sV17it+9qMshv+d8XF4RZOs+44gPn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

On Thu, May 15, 2025 at 11:16:45AM -0700, Nicolin Chen wrote:
> > As I understand AMD's system the iommu HW itself translates the
> > base_addr through the S2 page table automatically, so it doesn't need
> > pinned memory and physical addresses but just the IOVA.
> 
> Right. That's why we invented a flag, and it should be probably
> extended to cover the pin step as well.

Yes, no pin
 
> > Perhaps for this reason the pinning should be done with a function
> > call from the driver?
> 
> But the whole point of doing in the core was to avoid the entire
> iopt related structure/function from being exposed to the driver,
> which would otherwise hugely increase the size of the driver.o?

Ugh, yes, but also, maybe we need to figure something else out for
this. Pass down a function pointers struct to the driver or something
like that?

> > I don't think this actually works like this without an unmap
> > callback. unmap will break:
> > 
> > 			iommufd_access_notify_unmap(iopt, area_first, length);
> > 			/* Something is not responding to unmap requests. */
> > 			tries++;
> > 			if (WARN_ON(tries > 100))
> > 				return -EDEADLOCK;
> > 
> > If it can't shoot down the pinning.
> 
> Hmm, I thought we want the unmap to fail until VMM releases the HW
> QUEUE first? In what case, does VMM wants to unmap while holding
> the queue pages?

Well, if that is what we want to do then this needs to be revised
somehow..

> > This is more reason to put the pin/access in the driver so it can
> > provide an unmap callback that can fix it up.
> 
> As there are two types of "access" here.. you mean iommufd_access,
> i.e. vcmdq driver should hold an iommufd_access like an emulated
> vfio device driver?

Yes.

Jason

