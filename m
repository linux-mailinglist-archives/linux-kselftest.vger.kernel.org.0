Return-Path: <linux-kselftest+bounces-33181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D59AB9D39
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4174D505F4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9A70810;
	Fri, 16 May 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fw9uHxwt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9472616;
	Fri, 16 May 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402000; cv=fail; b=GoxU3Tu1Qu84ntK1QNsr6wdnyD1pjb6xk3pv29WYAZgAwpJmNx9aylgFaZa0gfihzQkcAYOb0P6uG2LISEe0BMEQHZvtmnl0/fM4o2cl3llHywmSYL+3iy+d4V9bGtwEU++rs+neKF1aC5hjy5oPCwa477SAwPQxI5P0gRBynCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402000; c=relaxed/simple;
	bh=UOjRyeB9X88Oba05XtGCYd53c5+lMUIRJ6ADbT4svxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=THD0j1qO59Nbrm9d88uJR+mEUyk5jOG7DgSy4SRDTLNOCXBIvHEx25E0nOw4uigzUPvvtvyKHcuApCdob8ob4uugn1zCNwghj4G39EP1NNgUm4gI38/rtvSyZ5rSz6dWj3g6rRrD4Wvr7r+ul/pt4haEVUektR4ntXuIzw6TVF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fw9uHxwt; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScwLNqa+qAxIROawlhgHOmKUBcjdvn7FvkPDpilq56cFzTSPoQPCZV8bHKL/D4VP40Vlc5eyHZfmSjIrSCRbhnhGhkWTgeCgbEx5SmkyENk5lCLNjNwzEv1DLmV2DYdS1RIR2dFZxEWkBUERiNvnofkFYjun5cCi2xLFsv6whlbrHzn2nPgcqAk9KE8jMEG73IBMPAgSyl2Yx19OaPMMofVfu934GGcA8WIJKbOS8kBo1UJPQWMHB/lfLyKvzhabZTjnr8esFlG5M5rYO1HhYgOdFkHGyjDdVMvLIZ60sTbq8a3asvTj/j61s9UA0vW58ZqYKXFgHXoS+eLGgOvc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YpkEyKyzpEMSDK/ZmTPci9vCF3WxMbcBdHOvAmsTAE=;
 b=VCWxS/BaW9CbQbK4TE1wHa7cPg3yHfNg2ov9wa5KVW74bUK4XGu2JTxaYEqdyNFImN1Qn2d7l3fQ1KLYdRszprXeDCCXtXGCy+cvLhJvS/dADDuAShPYGEtFfLeWba7DxdL/NPnJQd+7yloAlVh4zD2tW4LMy/OPGYqFIaexMtdXYla8d6JBFlZPfmdAiYHD9g8NFO5YlHZRQIkhZTAyom2DM5qUwtV2QOTfPCGPa8dJXlwCHB5A32eE/h3Wa3J25VGfu1A51NgBRHY3jDt2tN6geJqoiJKBHf6k8jWSed3XQqQyXi5eh+9RISz0te9FZSGdlUPbBVbfSpDn9LQsZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YpkEyKyzpEMSDK/ZmTPci9vCF3WxMbcBdHOvAmsTAE=;
 b=Fw9uHxwt7zYpiSUnZryDzG/lLJOmNsW+S567NTUSGn8WVsq6CsV78i9NZWmjQn0j0yOsb4d2zD2ylKQhvJO8bx2W3PJcz1VG1S77ixXjWSrIZAMA67KfmzG0gsx0Jq1+N9rE0Wba88Wp4Q2EyqUgxqghHssGLj0Yb3ONHL/LJF32viOUrY2q1c7t7b0woo52Y836DNSkt54vtwZh13JczBqkBYxGglKZ9G0jQC1eDNnAt7etGsZ+B5shcKnRJjVVSFKXrYzZeq3NcJGi4NWpcyE0NV4m921HJQa649vRu4ILtbW6j5fhRag3ATSM1wqiZGEyOCVBbEsd4Vr7kTu2Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 13:26:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:26:32 +0000
Date: Fri, 16 May 2025 10:26:31 -0300
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
Message-ID: <20250516132631.GG613512@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <aCYvjeZW+7NmUtoE@Asurada-Nvidia>
 <20250515185938.GT382960@nvidia.com>
 <aCZPcH+GiZKUjzWn@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCZPcH+GiZKUjzWn@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 8111ba30-c042-4d0b-ffeb-08dd947d4638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7CQJKTHeLvg6zu7uTPjak2OSwie/wqA1rXWXu97uzFZNeMb17UCZtc2MIt/N?=
 =?us-ascii?Q?Np8rojoh1DeG5XjOqWIVaeFggn4rLTtr3lkWPtSyJq+uS6+DyuGNubAq/68i?=
 =?us-ascii?Q?wG2bSgqjJKeeCXUuSXLHrtj6NuqXB8SBvPijA5Xa9A3RRhVsTVOqf++8ePGw?=
 =?us-ascii?Q?P1ONIv20HAITJiq3qz4MYU99/T01Xol+55R29RGx1zwd/3LwmZKpAXy2vLu8?=
 =?us-ascii?Q?ipQRYYwWgK2ef7cr2PFci4VqwN8QnpKgYhQZ3A4JXnCXAy205Oe+Ko3TWhGG?=
 =?us-ascii?Q?7tVdD2dKsBYrkR0Ou+m9sJ8l2rJmSgvyJkgU7yQn6TCmBRnrprgVHJJm82Vt?=
 =?us-ascii?Q?78oF8sS8IdUQ7ZSAW8EkYg8S5V7EOQUjZm3+FNL+z/4o/q4Cd+Rz2MQpKTWg?=
 =?us-ascii?Q?0oI8jEA/JtfmPRCiJFjBozEbt1cV9FYVT1e0ku9fCMLFxEg+vBwom201+7bn?=
 =?us-ascii?Q?QSMQ9SeTK/FHCHFrxfb6xCZma+VL8f2oi7SpCWrnbY6g+yzO1UVlZKiCjUb4?=
 =?us-ascii?Q?ZwJfO/bPPsF1EDC0kqrE1JIt7DjLzbCNZPAVMPlj2LyTuDW3q8WdpA/t7xJG?=
 =?us-ascii?Q?cE8u9wqwrYhD3ZwOpa7f5KBAbE7TWIz0ixazCfc+rhEeAWwtUhyF5EBcRfkp?=
 =?us-ascii?Q?KrtY2+UJp8jNNeaJjnfFL3WSBeG7FKHWWrVB6HsI/Ay4BsJ9OCoWj8U/E2AD?=
 =?us-ascii?Q?G8aUKfDeEl1RHV1mLlmqRWBROyVTOjaI3d+3Jgkf6Xm/DK8/XNOlhoVzN0Rw?=
 =?us-ascii?Q?61UP/aNhC+DDLXoL0XoVMz8eaTLvQD/qiKtzSslJf9jP7sVTNFuUADhvRNMQ?=
 =?us-ascii?Q?I+xy5J5MaGBKVBv6kSh6cDrn+N+Puv11G8NcsfknhRzZsE1ikff5Emdh9lnq?=
 =?us-ascii?Q?LsR5jDex6SFU+sDqgCQgVqkrXiw8tpA37JSIJCaxBnXvgWaATJPltMbYjqMg?=
 =?us-ascii?Q?SCdnXHj8kLLj4vvju1OGRAPXCpCXqbJMpTplM2MIYgwZ9ZXO6Uw2VJmWpn/m?=
 =?us-ascii?Q?lcXRRuf1LUoOwKpMWa7TW/bifESUesMcwDw4u548zbXZDxTgoH9yBQrkjcPa?=
 =?us-ascii?Q?JY7iRX9FD1AtaNV45ZTbjxOKpnYM3sAjvptuH5b/y4yMA6Znsxi0E0ZCMqrj?=
 =?us-ascii?Q?h2ryFwwd16uqMcX6WGdMyv4fAw6vA5bncN1CLvt7Twe9a9JzzXMapZ9cMJZx?=
 =?us-ascii?Q?pkLan04vUn3uG+E9yND9HkzdoaTvhYG1HccDFZN5QYQZftliYBsJMJ2H7YX/?=
 =?us-ascii?Q?Z9+wJ2gpuc8eG0nNbOeSpWo4L/pQV2GpRRPnSjEeUGV7r1EiLxws3FRN73IA?=
 =?us-ascii?Q?t9gh1aA68HwgsLJYepqlsaggojDizw3a4zPuJrtA3QKjKbBHQxsIMFaSehyL?=
 =?us-ascii?Q?gQEIQlLsp9fDSkTzKZxMgW6RYnX39NsbiY1GiiskF2VbRn5NquSFrS1Fuk5b?=
 =?us-ascii?Q?zwnUuE6m5D8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h5GN3etaioLHDcqGkJgBb0iknXjhrjdNcdDYm0skqYDtXdGfwZdF/KqJcvkQ?=
 =?us-ascii?Q?trLMWM/EXj5k+43OZ3khDkXWNUThBMxN3+GhK/7M5r7p/dgA0CpT3mK0+4bz?=
 =?us-ascii?Q?ekHBnJ4f2oNU6fJs4eMCOvrhFe81L4Ukp+IUENV1IXkp+sSkrmfSLnm+HpPD?=
 =?us-ascii?Q?8UUgG5W86rQwlhUJ3s4MWio35RmsIZZJQbgn2NCBtFc+L6ZreNhNnl+Kreym?=
 =?us-ascii?Q?vPICGjrxxg6mbex4WqZrALVNvOcoGX7lElPExVdrnNS2w8lhR+SxwCQcBwgh?=
 =?us-ascii?Q?eL/XEzLJvOEMSbk300nEgLq4NFy0YUCo+RWBZYWsfS/HvpzGJciQ+gFVwEIK?=
 =?us-ascii?Q?yRteurip1inHdSym/nHic0yHRBYJi/ZzJwsJL3nxgIGexqd2ZZOJFwU7k+Ib?=
 =?us-ascii?Q?Ug5oqdvLiJA+XNyrdzmR+S4GhpvO9g0hU1X5Tg8ytoNhBEJlZCUxVvQC/fJq?=
 =?us-ascii?Q?KqVCbaEr0GTOEMrrm1pZBYaO818qY0nme1OF1ROWqeM8C+0aQzYZsXWwftr0?=
 =?us-ascii?Q?sS6ObWdoR5mvywKmEyRkLsxkiKhwcr+XrNs4PYVuu5wCaKxfYKTY5bflvOWu?=
 =?us-ascii?Q?Y/h5rAc2Z14I3XvDMZwOG4WXUxXWG+Et8Jkj6cTQEXZ7YDwyVavxjSTXHxc/?=
 =?us-ascii?Q?SLMtnTwfrwjOsB247UJjtMedftAqWA+hQyV5DUyVuFvvj0RzxglZp0R7a42h?=
 =?us-ascii?Q?oWKoz0MFbFej1uDQmZV1BQaiIeQJFlU2SikPpXKpOmE3xCvvU5xF2xaEe0jp?=
 =?us-ascii?Q?slDSPe+ya1yVD/C2LVJ0emmP2WeZ8Rdcgqzs3KtG2SyyCjd43DIhdOi8duQn?=
 =?us-ascii?Q?I2d154kmS6ONhVJnbKjgyaX9I0itkyYbc4xOqKsuRhUPwlJ4wfgIC1ko6Klf?=
 =?us-ascii?Q?MhDe8Yg1bvpoIK/ZTeYauqhavzphpY4NT279tkk7/U01woqMpjjxbA0ALOna?=
 =?us-ascii?Q?8TElxgY9qBBqKIZLjX3ZlgnBGHCxRkPsFaBvDaP1x17Jy+qoUJegSEERVFjh?=
 =?us-ascii?Q?VqDKp9WQUt1r6fGV/UwVz8tZ418aJF4p27OwI/bD5V+PWlnk2aIUg3rgTU/a?=
 =?us-ascii?Q?YJArolbdYKtyuXVl2nvSD8gfZKQGmgfydm1vuUY/i82sYqjQOWKDbLKYTRG/?=
 =?us-ascii?Q?P1Lz+9suashmV2oAhwpz70iCMIjVJx/shZIzVaMNU0Ut+8IbNQ88ZAUamCwc?=
 =?us-ascii?Q?iyqZ+mAwxxkc0Df6NwZpTXLi+49Na9kdR4cGAgbAFrHrGga/Q9SaiF3znb20?=
 =?us-ascii?Q?n+pQcIi9ANjOKKOwdBOO0QTMZ1H29IUnrHd5+5WtorLmWbZS4NHyBCYVMjWx?=
 =?us-ascii?Q?5Lw+SDYchF0sjnbIK3vxoX6uziY328d731ORT+QcbLk0C6kxIVamoEFxMDiT?=
 =?us-ascii?Q?h3b0hikq7wH0tIcW0M279zv4e04NFINGPGNgvCuCgo/h9ctVEagOvMFzCvXM?=
 =?us-ascii?Q?+/okeGovdjHQAPVP4mGnGM3iO1ZgMsju9rvvsRLI6Q/HUpZS+T7NclX5bV1i?=
 =?us-ascii?Q?SidTOhHx1zDolDL/85pdlLkZEb4vllFPYl7lg0vlGFXmQphgVcI48yhAicAb?=
 =?us-ascii?Q?DpEtMqhXh4yDnTRJO1eRhMwi6zCNICQCfkdtyUC4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8111ba30-c042-4d0b-ffeb-08dd947d4638
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:26:32.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpYtaR6bITcvfFalbt5AVK4U3EI8P+/y6bVI7ixGfzQfERlQuiQbkG7OCdu9Rd1I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

On Thu, May 15, 2025 at 01:32:48PM -0700, Nicolin Chen wrote:
> On Thu, May 15, 2025 at 03:59:38PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 15, 2025 at 11:16:45AM -0700, Nicolin Chen wrote:
> > > > I don't think this actually works like this without an unmap
> > > > callback. unmap will break:
> > > > 
> > > > 			iommufd_access_notify_unmap(iopt, area_first, length);
> > > > 			/* Something is not responding to unmap requests. */
> > > > 			tries++;
> > > > 			if (WARN_ON(tries > 100))
> > > > 				return -EDEADLOCK;
> > > > 
> > > > If it can't shoot down the pinning.
> > > 
> > > Hmm, I thought we want the unmap to fail until VMM releases the HW
> > > QUEUE first? In what case, does VMM wants to unmap while holding
> > > the queue pages?
> > 
> > Well, if that is what we want to do then this needs to be revised
> > somehow..
> 
> Yea, unless we have a strong reason to allow unmap while holding
> the HW queue.
> 
> I think we could set a new flag:
> 
>  enum {
>  	IOMMUFD_ACCESS_RW_READ = 0,
>  	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
>  	/* Set if the caller is in a kthread then rw will use kthread_use_mm() */
>  	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
> +	IOMMUFD_ACCESS_NO_UNMAP = 1 << 3,
>  
>  	/* Only for use by selftest */
>  	__IOMMUFD_ACCESS_RW_SLOW_PATH = 1 << 2,
>  };
> 
> and reject iopt_unmap_iova_range().

Okay, it would need a patch for this too. I think we wanted to limit
this no_unmap behavior though. Linking it to deliberate action that
the user took to create a vqueue with a user provided address seems
reasonable

I would probably put the flag out of the public header though, just to
prevent abuse from mdev drivers.

Jason

