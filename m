Return-Path: <linux-kselftest+bounces-26898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3BA3A6E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174293AAF42
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E41F5853;
	Tue, 18 Feb 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDAZAG9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134E1EB5D8;
	Tue, 18 Feb 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905731; cv=fail; b=Jss8agZ5Vc0k5MUXMhf2Y9MN5KzEtlWcwRWKnybIM8WB5+xhjvve9P18NgkxSjFC0N9lX2mXsqJCbxoU3my2hGJLLJatORwrDJf/jqz+ojjW9f2mpTZUOLxJYuhgZnsMhus6gMHxNUhZvo53zFFzUUSRmMmqEAkh5Knb5pShEq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905731; c=relaxed/simple;
	bh=DhfieRT9Pcv+zohdnAD7e7RkdZMEwH0YyZUVXzJ1Xy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s9YTJ87Ydk2S6rKUe3TDhMz75znnkwGIYpAoM9iNpnwE8Yxnv7dNoKfRZPIMQfgtQiT2I2p13ePr9KNAnTBSRqJhaPAGhasjAKOhzZjZ3LP5MsFfzALXRnm2qGJqNqJ6fH7h+ojGl+/97Js6Y0Gwm2AQYmqIo4liTnVagNbpKIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDAZAG9D; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsMFncUJ4RsbdxSm8T8VVmR3O785ywqOt/fHTspH6mmxVXIkzgues45HwIrzM8BqM0nGYBqRbrMFYdqcDgLZgTAZ26p7yTEqoPymaLZhT9gSE/E3Yj1Nd4WyG7GClhYqpKsyILQ+aflZxZS28mKjxmVv94vYf6gRhQ27z+aHAr8nUjujOvCeZ19uN0dZIo6lieHr4zH9KiVKFU11niuR4G3ZYNXyFX535aYXMcXtpQOM1P5LQ8IpSY8RY9JsVuHTp3cH2FH1BzT6BwVCyQRb36SGHc6ExktxM0S3/mRM0lPPM/kDgW0BGKfDQZ8gGIL4iwNjOHMwlHW0uoF4htXZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy3ZmTEZc8uPz8RaYZfoySzu8h/56i3D6jUensxZ6SE=;
 b=LrdjQ2jlJzY+S6iWXRAdmLWxOncWb1MkBSBW+OFSlLhmMJawgUZ1VYmRaOMaJFStVzL/w35VznxrxmCl8wgyVTiABBwkFxDhEUyGuRSC4CYdkuhdmwBd1e349yPcDy45R8ufF4veloljhKUrl9f54pWoD3fh72nVdLJiro0kk7RWgYgcdtkUY5splSykj2GSQ1HPAcmxAh4N2MD5sgGRGJnV/UsLFrMrtRL5uegFOow7Krz5FqKOa3Qfh+eAkGf0lF5t17lUcazpibDUTq35nUNhrqPOkPpKMAUIOxYYDKG4IrOY+UPBxXIJbFTGKXHVk/lAt2MLWgELaoM1mLWdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy3ZmTEZc8uPz8RaYZfoySzu8h/56i3D6jUensxZ6SE=;
 b=YDAZAG9Dbr8qpWge71DOXKrsujaKbsUxuQ1Xu7+NCQv1dgFUgthozEhvYAosbXhFRRPTCXXixvQekJ2/g7BqcpCpvbFYKmRRfg+HRfDcWgi0xMR8teiBJfw7tctUIx4POu07xiUayyaYAd/F/qtut/KZgpyqrkR7TqzYTlCvWTmdSuDlppAmj2XjBVBEIKb9MMQjuhlSItKV+syvhIJEm7eGI5lFc8fwNRXdkLA3JqbDNn1WhhQvK36JZXutp8jAfBH6evfOcEA+qkGSskXNY3Yr4TYjxPrwB4YU473EgVbsnO9oZrBetkO4J2/P5tajizSaXqx+BMHar+1SS2JEbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:08:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:08:47 +0000
Date: Tue, 18 Feb 2025 15:08:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250218190846.GA4183890@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
 <Z7TRNL0u0YmN30ax@nvidia.com>
 <20250218185046.GK4099685@nvidia.com>
 <Z7TZP3jXlRzweFE8@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TZP3jXlRzweFE8@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f16f42-b207-4ca1-2548-08dd504fabb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8DxonPmCCs2mlHzyGp7IWujOdKrmjyUdVbyjELwoSq6ri3ZzUjwumVHkXsB9?=
 =?us-ascii?Q?lnJM3Fe9ve+oRzSkmYWU9ve+atcTNXE+/UsYmFwPBu7Xo5j7I8KoFLHyOe6E?=
 =?us-ascii?Q?dBvh4kySf5MQCK1ey3RIXnVdcaxYBXoBgzpnaAk4WZB0+4l9GvtiUnWQnmH0?=
 =?us-ascii?Q?qp0a9WS4BnjNqGMJvUQDQebhBnsCKnF9swNL45SC0l08UWC7ly/4d+g5Tszs?=
 =?us-ascii?Q?fweX1paGxCRFldHzk5NC6Ma2YH2lQ+IW84AVgU5QIZFOxIiAcUtvOT7jhmjB?=
 =?us-ascii?Q?PWxWNOKGeyDwlDIqODkjD+8D2B4swJCe5mIbz/67W0hnSF239wEr0nux38OV?=
 =?us-ascii?Q?0v9N7kN2wn4lg0h6s7YIg+OVpcumozJ9tZ1kzRRK579ZMWWY5AxSWd83nvhC?=
 =?us-ascii?Q?5RczQfHNQtK5F6bped+S8pxjz2K5A7TRPGeLS+jXuBtv16Kxfs+j7ih8Brbe?=
 =?us-ascii?Q?0TmANKT1e1tlR7ihB6PfOG8xNgZeVvw9DAwBXxKmA1uYnUjQeJjbkEZ+PFHP?=
 =?us-ascii?Q?xtkSQF9YDB5TEsiraolaUil6ucufSsJtkAZdBHOwVxao/XRJZF6877VsjJjW?=
 =?us-ascii?Q?/LR11BRc2ChL7+jiQajVK76Ww44EzC4v4K+DT115o4rBmawNKvK01gDDf0gO?=
 =?us-ascii?Q?+UnM9z8g0CLK3CMqfuAu+r6OKnw3LlcmmeLJu+400oVdzVh42LQsvtGRWZfk?=
 =?us-ascii?Q?6powrEoOz7h9z+ywrxVVdnJCOli40W1qeLRTZ2ao9Ys9UAxiRpQ8kgucyUem?=
 =?us-ascii?Q?hzDVGeJ982/aRHah9FBPHJem/dML4imJmUChuKXizJLSv65oP6eYfypCQoRg?=
 =?us-ascii?Q?0WmUW6L8uPP7Aiz7SqfO0i1Ua7w6MxcOVlrkfp69zhB0/o74TyVyWjdTTjF/?=
 =?us-ascii?Q?XWbbpH0hKuCn7t/WCOdP5khE87zMwSq3FWOKBIfItDqVCebM1EMMNVvB6JcP?=
 =?us-ascii?Q?LP5eCdAFfoQjm8G+bcrIS2Lj5aUnJmkewVEimYE8p5e8Viwc5seL+MYlrlwu?=
 =?us-ascii?Q?3MhnK4oW1XY+TU0ljYksC6w3cfGPV6U/GrPpF1I8IiLVMfvmdPbwjBqCPIm+?=
 =?us-ascii?Q?yha5BNORH6uVeT3tOxmj6nh76QPCyZTPp4rliIwD0w1QTOg9+U6IVIDg62xq?=
 =?us-ascii?Q?eRuwh+SGefCMddpIMGm6ckAMMfiPsVedAheEiswu6MCGai5LbtZGfyL1lko2?=
 =?us-ascii?Q?dFYwuUxs+sxa9uFR8X9EqCsHotn4ocGO/tU6eZwTZ5PdAYmJ2fYC9aJthiUt?=
 =?us-ascii?Q?4ilWofBC5bNj88hBA5e1xDV/RqjUt2jMuEh55EX6BGNPk4KgPdDtUi3/YaZd?=
 =?us-ascii?Q?vv3qAMtz+jNu+fIjIOa4CxqdWeNaf2AmGtsCKc67I+E3CsSLvvoR8srz5v1s?=
 =?us-ascii?Q?hHUYkv8vDSKx/QLduZzv82fGPbNs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IylQSCWdibOWM3OqQMbI1fjxs2tM20DO7FQaNXRtXlr/yyFtSLjTQqtnqTwP?=
 =?us-ascii?Q?yFQnZcBf4EVWZxiWieXKm2CJf0FMKLGoah8eqbuk9JkSJO+CxNiGFZzVFcQ4?=
 =?us-ascii?Q?B5z6mEsI3UC1GartqF3c8m+iSLajnCR+tRLYdhESllVQgHp2JYWKCD7qLCOI?=
 =?us-ascii?Q?973xiEq7cNIf9izGitdHsypZJe/5mHWk6f11rrRz/2dfVZIXgwhVQygam3pb?=
 =?us-ascii?Q?5qaZod48gBgS2qASh/b4GuXb3VALyXoVLu5FHVZM7g2UlHibE0Ra+gBK06XR?=
 =?us-ascii?Q?1vrMgeVnNTJ4Ix7FPTEgKlKHAJPe6JqkNvScjafau0Rv9QQgTQcCAWDwZ5pp?=
 =?us-ascii?Q?DUqjdzB2ZJV/ZUwCzotsU3AlA+nBJWtSDSZRFRvcmll1E0wy855uZh8y6Cll?=
 =?us-ascii?Q?+cFMG3CvZCA7wfOxVQOqhLOffGPs0lG/kbGABGoc3OYFG3ZmaHRFUJvLBNik?=
 =?us-ascii?Q?tEgxvWTlACo+0qiYwAPFNRjp+eWovSWvI/+Oub/+ZhPVqOfdhIQIh24lBHAL?=
 =?us-ascii?Q?oMpiyhgYjwiIC6n42Cko4o61eEE84juoO1b5cUFBgcBX4Q7z3/VAyLwo32Q0?=
 =?us-ascii?Q?gubITwxuDU+wTX9m+DiY3DEjQo8awfIe6dfD1ix5IZmeb1WEZ1HuNOz7vZfX?=
 =?us-ascii?Q?8DmInCaFS5BETeXu6el9YETyKbyqEf2jaNA+prfdeRzNu1SNgUJ2Ruvlga6Y?=
 =?us-ascii?Q?Cy4xAfhqn6gYq7+Ee55FY47e9RegglaSeAnR3clnj9OPtXM/XQhXoZjBfZeT?=
 =?us-ascii?Q?3UiJcsSkiagwR3jZtV1EslE8iS4QigwBg3NVjbepRyfxGMdO9fXCgIks2ItU?=
 =?us-ascii?Q?qaLp9TsgPDQHWPamX8bJslnqx/lHWCfV7IzU3aArKXEc+EI7Tsr+z3rY2i9r?=
 =?us-ascii?Q?31vkqmciWLY8GjFxmMoaFUa2oNDjOaRVK8NEXkdsVSYPxvBSGvtlalUxf03b?=
 =?us-ascii?Q?nTG5d6aB6baJQ41jqozjx7/tXeOEG/qLA5vn3cOdIP4TbnnYYxdVDDo0JyiJ?=
 =?us-ascii?Q?7iqMfAwi5AGAnz4nn4cDQMRLlvek1bqehfcZ5qM/n7GO919CigaNGVdeZBg4?=
 =?us-ascii?Q?2qEhLw6AtkLAUs19BRpfZOiSU5HoRGiKlGQan/HADjhGQWgceDTSBowYOFmq?=
 =?us-ascii?Q?83T2TEKeL5lLeMVcYhUuprczv7tzsLqX/iAjmMFkF6wqQrpoFh2NzA8TbaHi?=
 =?us-ascii?Q?PlmBDjHEtN3hWlUZbiRZ8Dv4+eMBFEu2qd8V67tqLpsbgEJo8KJMP3LRgkns?=
 =?us-ascii?Q?bHosujathdwmC6AgGC32d5rBevyy3jLFjvHW/fPnZVoZmXHAJhnIXxy721lA?=
 =?us-ascii?Q?va6qjzOl3nHIR/wCBYmyQVO0IXGT0mYtjhcbCF2veJrvR/G+JxMS2RTmcOl/?=
 =?us-ascii?Q?xmZYtLbXoDQBZsUIcH8s4xrlXWjerh6afkZOhiQHrs1W6au3JZgQjRs7jJFI?=
 =?us-ascii?Q?4ZzB2cSLVqI1UvApQPZG5MFjCQtbU0J2rBMcGMBobq+Ixd1EdEfEzFIGJx62?=
 =?us-ascii?Q?3yiApIF0LsSKO8+e0iCetINOCZi4wJ8ph1QDm91ds6Gcfv+KYoMfqDWA2WYK?=
 =?us-ascii?Q?01d/AVjuhEplBkgj1vsfkEUe14ULL6vufCntF7wc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f16f42-b207-4ca1-2548-08dd504fabb9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:08:47.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg1UgpOOV2JLCaNvN95jlZZ7O/u0k0bXiR9Ec6mHyjJEcjHRw76L2ZTi35a7owvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Tue, Feb 18, 2025 at 11:02:23AM -0800, Nicolin Chen wrote:
> > > > This already holds the streams_mutex across all of this, do you think
> > > > we should get rid of the vmaster_rwsem and hold the streams_mutex on
> > > > write instead?
> > > 
> > > They are per master v.s. per smmu. The latter one would make master
> > > commits/attaches exclusive, which feels unnecessary to me, although
> > > it would make the code here slightly cleaner..
> > 
> > I'd pay the cost on the attach side to have a single lock on the fault
> > side..
> 
> OK. Maybe a small patch to turn the streams_mutex to streams_rwsem?

I don't think the interrupt path is multithreaded, is it? So only 1
reader anyhow?

Jason

