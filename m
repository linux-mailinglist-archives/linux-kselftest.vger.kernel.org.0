Return-Path: <linux-kselftest+bounces-33117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7615AB8F7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F524A204D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BC29B76B;
	Thu, 15 May 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwkqDgrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FA296731;
	Thu, 15 May 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335396; cv=fail; b=oam1ojpy57eYRLK02EXpqo2QuHf8diFZvgzPaH8fs7WvgKoZy8NSf4cJYukkJUC1iCLcY7DVRzSLpESw2o0sHQE78FJeWUbKkHJLLlKcy6yFnx38EtoIGFLM+CdLdOKgab+S5w3UwP8yxUPnIhiBw4mlmWHo0Mew2xgN5yr2d1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335396; c=relaxed/simple;
	bh=qH2mZGK+/+UcBwsSxfgvcQoFyylEfwRRwJTs3egAGag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VTq8OGgDNNB5KUfb0eWGlGFHRE5aU5nfhrotBTG9H/ioEcNLYgvNWpqU7SlW+8cJqw7nqLIODpHwb6C+ZarK8e9qaFJip60h7sOjpeeHoajGSiLGXXwwJ2xKRzOw6H91rBI+zKNz/h6nrCA/8DTgnOb+tO1b25enc4Y7aENayPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwkqDgrM; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+chPdAlsPKhHCZix/rc+VPKuj4B1cI8yRP1JTxVpEv+1qtC8AkGcNGz/yw0i80YR6xHiV/M3w4GSjWiZ6Adz/q9Sycf6VG0T6/I0+Udct+SHMD5McqvKOCJq57LTG6YLcBxWYKOO6SigKxnekSpF723gPqK4Mzgg/zqEqm0G3ytQS72hEZGZts5eHA2NSXKRfElQ+jzV5KT2OTzWfvh+mWIdm11DSxI5PSLxhQ9P15ihKjUCdbB53bbNhEG3fEnN37LgW8N2jESyD3ZJoOKSy+dk4WQkzSHScG59VjTS9UDygar5zxg1Qamq33QX7n1mqmGY66J3tnZ8dTS6BD/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiUWyEmOfeYPGpRmimjlfQZv0TnlhAdYB7n+3BaX11g=;
 b=KqcBtBtty8Yoc33INi9x3KNh3ewvgH6BiflKSE9qCrchbgypl45KLYK132dFydikCkNhZbVZOzVpxHuHm7dpT+8tTIJGqWv2chfPF3hnwyhaCXn7s3suQ2+0Jsl7iBAJu1haAHoF7Op1S3eL+PG5WX5Eqiq5/VQcPSjlrRjQI3UAxi628diFxhYSk3SjEWrO7LD+hIL/wIBXj5wt92nfQccK5V/0VjpVFTOHGEt/MQdTUqFUu4fd4YzC4a3Mj1ZQAl0YGLYZ+ETZApQUaoqi919eXSo0r/jy18gm7A/VDgMWZw/riNyrTOCJp8YyGK67b0h548YmI9Pd/oFT7qoyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiUWyEmOfeYPGpRmimjlfQZv0TnlhAdYB7n+3BaX11g=;
 b=RwkqDgrMTdSuw33LlvwAFhiBrWQCcd0usekunAumBf0/5e00g6IbmoEywLQ2he4OpWtXeLUsRwMBHKdnVQiZzNXawGJkAklBtHu3UPT07A5rdkFcKmGpuDFivJbOZTu5YX2MNZKSwb10jxq63zUd9mgDhZylIeME+7X1uaVIIoTCLbxSyHyUVhkw0nsO+9iwRhwJr/QuWnEySTkL0TEI7SGvUauTQhCrE2gZlf01yfSxco2vV5q7lnpjVagJ8AXs4IDhW3YXI3BX01rJw6mvEKQ+gyjDJUnt0eXGQY+hLKZv1Kr8jWJ7QIfsuYmeXaOdUUpWrl9NScp8AHcDdlxIXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 18:56:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 18:56:31 +0000
Date: Thu, 15 May 2025 15:56:29 -0300
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
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <20250515185629.GS382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
 <aCY31VOs62/OAaca@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCY31VOs62/OAaca@Asurada-Nvidia>
X-ClientProxiedBy: YQZPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 265d26b3-0949-4265-9c55-08dd93e23464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CV+C07HnwxyKjX8fbDWDSwTfzQ3VJS3Q5vAsGtx7B6k2MedqBzp8QiYOqlPw?=
 =?us-ascii?Q?C3Dvn5ZB+/Z/kTxchtGmSCZgoQb0zq4+p7eH3dEvYqIz6glF+3Lko6yn/tpX?=
 =?us-ascii?Q?+E7KbeI3jFmeSP4MhcoojakQD7h/Cf3k167Q3xP8fTPNI1g/46XUa+ZCBvsz?=
 =?us-ascii?Q?5ktQwnU3UGg7G9jic7U98j3+I88LUFGHoDw5knP88aO4qAOV4F1yUIXMxJxm?=
 =?us-ascii?Q?Tcf0H2g3gLiZBGGa5U9P7OFYFMjZTcUJnHITCykYyeLZEUQymhwq0NJGIObR?=
 =?us-ascii?Q?iY+DZ/cQXYXSOn+lQNHamCzN2LbWCN8Eg2uY2NM8BJkgXVPCCff2pfookG/i?=
 =?us-ascii?Q?ZynbNhZJuxs9mb15HcyGuOACJ+H5ZkS0V7/FrRilUVUkVZqBdR9bXyyQzt8v?=
 =?us-ascii?Q?KQiLPFwjgCSbx/bw4cmFEKZy0u1h8gQP1AMzKjiQcKqVgNsgtaTINBUdcfqQ?=
 =?us-ascii?Q?GlHnSoVnTewVy1vVOM5hZZ9lF97yLQyU5gcgv5TjAZ6hE3z7eUpYkcjf4ygH?=
 =?us-ascii?Q?6qvP1SgAybdmvbw0BsFIJfp8bw+ZGAZ9m/fQsJQ4SRbUvh+FeEDEZ52lvQr1?=
 =?us-ascii?Q?UQ8Iw5hqgpuvGfw1Py7nKnOX5oWl+qq1EQJTYK2iSkIJ3YeEfR7nmDsCVaC7?=
 =?us-ascii?Q?/s+hzSCQw6gMjPK2Xmnv3gShfZWivFdbyZSo0STNFNCSyF+OcUN39xVTq/pK?=
 =?us-ascii?Q?14Dn9BmvXLQ8KUoSvB8RzXR9aAL9HqMSox9IiQoydztxYYGvlFyEZN5VT82U?=
 =?us-ascii?Q?Chxo5mpHF67Vfb/MZuNRRcLTENsp+/ObJF4r6j/fUBY5iTjD/gGGKfKQ87n4?=
 =?us-ascii?Q?tFSrNxSHk4UhFq6P+ugUv+0fT/olco3N9FqeNwtzljQISftfmcx8R83CzFy5?=
 =?us-ascii?Q?N5aVosNDRXSdExmlF8DuJo2uZEgpzix3i7HeCjoxoSCEyyXbcweaPQT6uyMk?=
 =?us-ascii?Q?lE+HK66oY/7YMn+q36vwnYbjj+Wua/3GSetD/JJNlg7BKjQ2sVQvJXP2Jrbz?=
 =?us-ascii?Q?rbZkDme/HfyYX4tA19xctVfDQZquqJ/DqEER+cV8h8AqQfc9ftRbI+i7LfcD?=
 =?us-ascii?Q?yl6HfzzAMDL1hRU2pskUxpzlzkUfvBTjiI2Nikv7MAjXPCa52mYnos3W8YZu?=
 =?us-ascii?Q?RswJb4WMla5SlKeyJygcmENkIzHWVFtuCWAk4KAQFHqywC2ja0dPYgZ9mi3f?=
 =?us-ascii?Q?XBtn4wfm39XC+PkZpw48LRypMZcuIgLKFtbgxbuIvUX39qPwK0kB83m4M5F1?=
 =?us-ascii?Q?dQXHYW+zK3oiNuuIQN3pUmNCCCkHlWckbENEUqj2DV/Wb5lXKSRPyf/GfSf9?=
 =?us-ascii?Q?UyDIKsbR22rh5DdKlaqhvboaulHrbtbJmIXlOA8z9CJlSACqupD3u+WeXBqp?=
 =?us-ascii?Q?DmuG5Sd1FbV+JZ5X9hrmyo55fqYEzq6idSPPMB98xCo3dfCuXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l8HStbnPR7LnWv7tmdmRd86YdDgJ7bO/C0JKT/cyQd3a5QhG2rT7cpTdfi4H?=
 =?us-ascii?Q?V5E+G3tg5iWyRYM1+Z9kDxHqj6B2VYJschS106qeGtoypvVE56PsJKyT2w+X?=
 =?us-ascii?Q?1UIpcLaU1rA7tq+/T5vA1OMkT7ID8o1OXiPyVCoqnmS1qjZWzZZqlUXBVtzm?=
 =?us-ascii?Q?hHL2tXGhlXeX4MVm6zZbiuh9RRwgnVRgiciLEwqzZidYrGLhY1TeGZT3XmGx?=
 =?us-ascii?Q?9pt0qAeIKOXtqMuIORr9nn2mMrZ8J0vk9TsJI8B7cP+Xnxxoimlmgzd1j/cV?=
 =?us-ascii?Q?2mjulfgic0H20hIg/noX4vR/2OiIKadsoMjkFxSi1KhOt/Q5dhKUmiQB74aX?=
 =?us-ascii?Q?24TrsGFlfvHVuyU0+vkys+fhXKd8xfBUPyeZ5WGQGEctKLbQrKXQj0fKe8vG?=
 =?us-ascii?Q?yysFSXKXFdfB2FK2GQVSqNO3fnOn7CLtLDto+xY5hpZzSCJxbdUu+3a3hlX0?=
 =?us-ascii?Q?wSoN5tmgtEyQBagOZeAfH8NpwH2yyrkSGbFbC2BNSzmYeyrBGUpyUSnIjxuz?=
 =?us-ascii?Q?vD9n7GptqPEdGw6vK2sbL29LBKw6khfX+9TAXRGuxTZnGHfE6Iv7pAoFHYg1?=
 =?us-ascii?Q?4mCid31T+4+pKZOtlmw6+ewSWXj1xzDK6sZtnEJJZLF+VWEfCB4ZNYBGh5sS?=
 =?us-ascii?Q?LCiqM3CUrRAkZ/t1E7sELsSoiz+u96vuATJ1kmsxwxenYTMR4lchI3TiSPtv?=
 =?us-ascii?Q?58zdixIgA67VMcSDOxH08H5WIeJ0PNCXQEpOT6gURnd+Utcp5FhCE7WwJVE+?=
 =?us-ascii?Q?MZTldOU0l2pD5GVN3Z/Jy2/odKjbIvDn92Gk12OyKyyP5RtanIxwBdL+an9n?=
 =?us-ascii?Q?B7q0bpu+sbJwAF6K8QeRX1yDLNe5mnBsJTo4c9OUxASGsuO6iIIhnwJr+Iuk?=
 =?us-ascii?Q?nS7lcL6pLMfpTQkpPHA5Ar1paov73yjbuOvxM+ka4kdFH24e0+j6DXoArj7z?=
 =?us-ascii?Q?NnZICRRQwT4Cyto5L+bYVVP5hlEAzdot00Obl6eprYA94g9cOAc6a3Ojs9ag?=
 =?us-ascii?Q?98uIbKcIPAAYkXzGsx3gjKaUF6QWrwszP5MJeRPDNKbWlGqrxpiiAqfWA8AQ?=
 =?us-ascii?Q?IIPqpSAYdhibbGl019sC2P75n3AzffAjSIYxnLFCOsAem3ONpMbvQ/2Vhicr?=
 =?us-ascii?Q?soH9Y+uERef5OdiA9iWuIg4WOu9gNK92ub1Fkuv+DfTNfGTaXEciyPNFjrWy?=
 =?us-ascii?Q?658WnP2dNicDS2s4IzQYcOKE3P1JY99axpF2O6IKvY8GdydFtLkUN+spjXol?=
 =?us-ascii?Q?s1Rveegjq/HPAlo1jdFsYT7yEr4yTcJlkmdNqHRBw4/D1fP4JBXtMlvxgn2x?=
 =?us-ascii?Q?LyNKPRPLCKw6ioMEZ7C7syMkP0XAEg6kRoLhea8D6vBKxE815bv98CqbvIo0?=
 =?us-ascii?Q?iDWj8j70WS3GSV0BhXubVNUQ/fJ1QatG27IWqG8uJThBqAy0tQfo0nXOFobG?=
 =?us-ascii?Q?TjOw5jrNckuA0VKm4+PFkA1yL3cdkX4UX0aiCRUPZZs8nv+rELsx8nJJUlrr?=
 =?us-ascii?Q?EgCaD7geIwF5LEavVVk1Rbhmvi00skmnO24h5a5mnfv+ss5qMbm0Jz7bfpwq?=
 =?us-ascii?Q?lHJ5BtlYOGGp0we2Y3JMOUmjuL23yyll1bFoqK/h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265d26b3-0949-4265-9c55-08dd93e23464
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:56:30.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmAL8SY8uDOlH1j5fer5yY/YjlCdRoAieqvRZ6VyhShzSWqkf7acUCtaFOQr/1hY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

On Thu, May 15, 2025 at 11:52:05AM -0700, Nicolin Chen wrote:
> On Thu, May 15, 2025 at 02:17:06PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 08, 2025 at 08:02:39PM -0700, Nicolin Chen wrote:
> > > Repurpose the @__reserved field in the struct iommu_hw_info_arm_smmuv3,
> > > to an HW implementation-defined field @impl.
> > 
> > It would be nicer to have a tegra/cmdq specific struct and a way for
> > iommu_hw_info to select it. 'impl' isn't going to scale very well if
> > something else wants to use this.
> > 
> > We have out_data_type but we could have an input sub_data_type too. 0
> > means what we have today, then a simple enum to select another info
> > struct.
> 
> So, there will be two hw_info calls back to back right?

yes

> Should the first call return out_data_type=CMDQV while returning
> the arm_smmu_v3 hw_info data? Otherwise, VMM wouldn't know what
> to set in the input sub_data_type of the 2nd ioctl?

No, either set a flag in the smmu_v3 hw_info, as you were doing here,
or just have the vmm probe it. Given the VMM is likely to be told to
run in vCMDQ mode on the command line try-and-fail doesn't sound so
bad.

And I guess we don't need a "sub type" just a "requested type" where 0
means return the best one and non-zero means return a specific one or
fail with EOPNOTSUPP.

Jason

