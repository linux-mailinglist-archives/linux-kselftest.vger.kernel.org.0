Return-Path: <linux-kselftest+bounces-17151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003596C417
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2845D2884E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386191DFE15;
	Wed,  4 Sep 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iqUwixQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36071CEE89;
	Wed,  4 Sep 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467189; cv=fail; b=UN8M2wiPBUlW315v8mZm3P5c6wXmm8U3gPOCFMKZwmGySaIs3UA3y/2k15sWsflmurnfr4IqvsaYw13jxOfxryuedyhp2lGESpR3CBxJrCdah2h9Du1HkzuI1eObTpQtYhQA2JtNmMvwwDcnG/NnTsoTq0RHrjSu6ee8i7eF3ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467189; c=relaxed/simple;
	bh=6Hz4oR5vM/fDIqqz65vbf8fNumYxU+7GpMYtsQNCOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axeQC+H+2G2gZksdU94n8VMr3kmd1uF438bhVanUdzFdP45wU/g152AifilBdkhqK0KrjRda2AoBfmHYZo6AB8T1M6I8aYrh6wTR2gTh+sVX/0lxmS/cbyJvNm9iuth+dOI5fiLkMDuZfgXivvbhi/tB2oYmxOE4Eb5Dh+8oMzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iqUwixQ8; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0qdiellIwXhY3DlEiAp8swTlr5HIACPeyiSTccWdvm0XuAPb66aKZ+RjJ9lcAshoQEpI3l/woWT+8y/qVwDIGKvPaz4nIMcj7FHjOy9XI0+0PR/CWgz1dyDF0NFpk3GJAXuuUpj70DuDGLpsbFu7OtDPgM3M0LA4M2dTcLCxQ/CS+AeQKG4kXKNUWAEcCaSry8eV4ZpknkyDFNfxn0euMgQwbzZgSVGsj9CC2suR+KtJCqf1Y/pGvDTMESaLFS/h2ifWGho9Q0EiET+FwgTHVA6BBzEXc6kXLhH6qX+G3XjTPCWxH5OEdY+Ptz0ec5KQtMpo0swtVWGp9bx3ejf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSH75q9wNqSSWHhPahzTmP9u6LiZx0a8vPshBX36/xY=;
 b=LnHh9gG/ZG4QLuJ1k3HjsUbnaaKEh7O+QWa4SDFryPa41rfNtTOplBkmdSuNZOv8UQpqGERB1iVy2FHHRdeyLXEMLdVcGBqwTKkP9DYaEHNcTH72EISc1x0i0ZVHcFa9xLoWZBU8LQ1+XlG6uzO4POZhjZ+I9fV8F6U8GOCer2Rhnt26EiHBZG/FPi5W4NsvJumFuJjgYLh0KcrQXamsBt/9LWu7RDNYBjNHM2Go432nDnUc8uNRc0kMQFw3vTcT9JZ2/RqakB6E93scVFO/tPtCPneIgW7tz69sxMcl83sRYzzMPwqjvOyQy6rZwo93uTBvQegbT3EorzrWav4ePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSH75q9wNqSSWHhPahzTmP9u6LiZx0a8vPshBX36/xY=;
 b=iqUwixQ8MIxHh9aZmc0ayRMGlQbhUoc7FzOQBQ8vSwsXbO+5f9IVkz1hePRtz4qt/a0PHTgXzFZMMBTAAfrMDK/Nn2ggi3YQkWz8x7D4cT3dZQpeo51ofUUZGOuRwpXBjB90jUc1Gvq93Zwts5lQpcZZgdiUxGuVEfk3fDS6EjFVAlHbYZ4MSELE8w5yBHifzzZqmAIT0VSeBpqzqWn7KFTmpXlSxQXsgsqbM8m8McbzAvNNLooTm4sCBdvaoNCSO1srrQ8T2CUf0VaxdzSLJDORpjtITYS05fFVXjJTsCMMtFbKblSuxERF8ti7u9svGybz9QipR4cdYDz+CrG8Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 16:26:23 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:26:22 +0000
Date: Wed, 4 Sep 2024 13:26:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240904162621.GN3915968@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
 <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0348.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db701b1-6009-4276-ec4b-08dcccfe5081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hw076n3BX8zQIor2w1vhv6zUuWnzhChyRi0s7WNFRApXRkYxrjAritztJwkA?=
 =?us-ascii?Q?v5DxZ9MCS+BXGRjl7tvs1TI7skEj5WlqDBhqH+av9hg/CNFahCtRXibxEPXZ?=
 =?us-ascii?Q?n69w1VoHoao9mu7Q/RRvvcDAzth1b6xRekUNtlxfcpvBhT9c7FyN6jsAwSk4?=
 =?us-ascii?Q?3875sK/80XhKj1eP9EN4Pdsrd+rSainabJiIfvc3/7gByveZYfaATCHcQmiz?=
 =?us-ascii?Q?cyZZwgN7RF6AWeLWJaLr7uJwPLJa21wr9E3tglERFirtfaRTAk5g1KwNYACI?=
 =?us-ascii?Q?EUT9tPhsIwgpTtGYY5f7Eu8bQqN5Me51RFiGYG3/ewF8lqzgW54tkihLYxc9?=
 =?us-ascii?Q?2pIkvbQqEyS+urrTJCCL4Kmo+cWU53pQzLwN6z3lAK1n0rsxMIob+pxL/I0T?=
 =?us-ascii?Q?nrBL/bnnXwjd8+nfDhmwYxM3VLujY7S1S92V4GwZ5MyA9u5AbeHt0rVkVMBP?=
 =?us-ascii?Q?7ddOslGOGNYarxqPUkEpD8ZW6btSYRJszRwldlU7rHmJYUMOMAbW/J9MPwoh?=
 =?us-ascii?Q?Jf8xVrzHMeUniSkaowgbJK2LRTM7EkPaeJbAq/uoAXMV4kzTPsLSO2feN5Hm?=
 =?us-ascii?Q?IPZ6+c0a5EbEIpq5rpv21iRfXr1EhZGSpEnuDI85euRgZKFfqQwcIi+KvV/f?=
 =?us-ascii?Q?7Zm7dflR9FYMB9GTz1b97+eXVkBP3/FXsmf5xyFG47XIIgHWOoHfPenEaAJ7?=
 =?us-ascii?Q?xbN4U7CUkOGhIgFwjEoJW8kzssWuMjsLjQYYzmzz+ue+6xECVCz0858nkQa6?=
 =?us-ascii?Q?76gCcIYZP0yoT9D1JMVtQyjmk7YQ13KU4iCr8/gBwTVk9slba/Vb+0VPtjKY?=
 =?us-ascii?Q?kpF4sWER5mKcTZ42yw3U0UzUP8Njj4QWSocW7tc6qrrS9mpBWvBSHomvV5ZA?=
 =?us-ascii?Q?7BE7KOU7XU1SXxgjjfziB6E67j12moU4Tzq/UTDmgzbJ5/SBdB2z4+bet1sB?=
 =?us-ascii?Q?+FUsImw4tG3DjL+pjYPb8rkg0kx1fge9ilYXVGnNwRka1g9nyFQA0od5qDf8?=
 =?us-ascii?Q?6GKgaD3semrs9frPgnnWaW339YazrGUkzH0KZGvzEeVC1GashiW/yLBQ2c9Z?=
 =?us-ascii?Q?Iu25cmj9y2z3khVPEptS6tD8J1XlV+ASSrnoZQg8U/pMRCtD2FEAT1vhznzZ?=
 =?us-ascii?Q?Tmb0CYoxTRngd5OaJyRBK2rPkJiEmRLfsJd5RFT/yTR0s+8/CG0ppPQ0EBK3?=
 =?us-ascii?Q?JQAa2j9TZ1Jk5Ba0OcPsheLxgOje4G1rjKAHNJjMDB4nRot+ffNuDAAN2ooA?=
 =?us-ascii?Q?+djctDDWAgfJxavL/O+P1tpxTRgtxUBo5/9OeMfy29u38Fz7dP5ZOvwgCD9X?=
 =?us-ascii?Q?GDkeosi8Nasc6VGb9BpH0u/sSes6+W7RrJ/PBJy4b9uUlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QMmscrrL9ND+wQI5m0KS6HDlyFqq0rpWRhPfCGKd1SEJgDeqwdhMnlA3Xqt?=
 =?us-ascii?Q?8IbHgN8+1Q+1Vs21ixMbVze4+0ynQP+0MrAHFbqZc5vTtuVfu5y+hOVlVCDl?=
 =?us-ascii?Q?TF1QbUwFkt4xRVmxIURIGlSCbOwkF5AMOk708Avh1ovJxIvC4+8YHcYp3zo5?=
 =?us-ascii?Q?YzyCWzZxKstPgAE2/C1njUPjmB1/TXTIGQW01UJsYkzkBv5iLr2uLOU9lt4R?=
 =?us-ascii?Q?981KvHwXNlBaM8z/0tK3xrJZKAtq29Oveo1umpmio4/Feb+ulZE/5gVSdAjv?=
 =?us-ascii?Q?4h1wKq4BPiCF/nxQTmhMqfJJo932J2ycu/hZKZKIdU7WDFbi/Wxk3HdbkyGW?=
 =?us-ascii?Q?Sl9lH/QKBMsbjKmvyRq4fvn49MhOGccDTZbS2QiO44+xjWB3Jr99vvl65BBe?=
 =?us-ascii?Q?H0/UW00zGaRpTj33LhQnLf+n95ixdhlC61Yo4WsWVQoeSwE3SjG0zqfgLRPN?=
 =?us-ascii?Q?7Bnsb2Lyxycc6Gq2HK5D88HXbYwCIz07HN7ahpx9UmztJyFcLGQ/J8UBo4DW?=
 =?us-ascii?Q?5Xche1zxEinVcPaCo1Enn8wr9hXm5FptnEwCTyxriG85a7EAwXzL/poKzBtq?=
 =?us-ascii?Q?9zVFgPQhO2q0740bxi61gH71JhZW8AFzSJ/8TlZH/rFt2iTqS5AVlouOcocN?=
 =?us-ascii?Q?gjxLIvLKgJyQS6XK665sWGEUYcixvEoI2Upv31zU8f4pHjt04yI1Xm7el4rX?=
 =?us-ascii?Q?3iIMExFp+uWQicGAtPTETf72SihDPXzbMGoYupzXoXengGl5pPnLK7MlPd4j?=
 =?us-ascii?Q?9Bi9UkNiQ3faqfXuS6Onre/iw7ZbJDWhG5uOz0woSTnWcORAOEUWrPpTf4RZ?=
 =?us-ascii?Q?2tHWKLaA6LeQLY3x5Yz1aaeSK9fLkZ4Av1YS7EVSwW9mV9xeO/XeIqsRUGjG?=
 =?us-ascii?Q?9Sx7/s9stnEQROQ58ZJS2+pEF+bsx8iKmrpg75WwkuEBRg9jDE0FK5zmEn+X?=
 =?us-ascii?Q?29ED9jYcjC59hORt5lrqfHF6ggRPqcpsZ99tbYAXOtnzo9CbWPwR/79tRhz7?=
 =?us-ascii?Q?reiGE1pzmYEr74Y/5/Bud4paFOV/eqQby400UIfyv59B+mp5M+70FY8SAVtR?=
 =?us-ascii?Q?hOTkgwgx4KD+i7r8P43Lpf6BE0484yhJLFHIBYZj9R+4lEX0CUskYFWQmKd8?=
 =?us-ascii?Q?ZC0eiGlXg6Fn1AZsbIfCeB1p/HUM8KiQoxf9TP8vgJcIsfqGjiApJDjkcxwL?=
 =?us-ascii?Q?M6pvtYmBFxG6yPVwKljWl5n9ZAdw1/kCq0hwtQIN2sBE9ZRXfUoNKsVS8OlS?=
 =?us-ascii?Q?nqCIwqLdDYe8nwHux6zes/eiU/lSZ2Ka5nHbKPPOfkpHmVZtEvBlP2qlkuh+?=
 =?us-ascii?Q?rWUiMING9EFMrvovNfIfLy3RiFU0Vyz1h1md0bEQpGjAbKtKyHT55cNj3J2p?=
 =?us-ascii?Q?qhMMI0iL+cZSOzgMeAqmDAOEsQtgKyNuVX/KwZib2FBknSGpb7eREGUAsg+G?=
 =?us-ascii?Q?kXVVCd42vbs3AQAagvQQ9hbpZukiJ+pBknZPbM2MKCCWfK9j0N/JjPWFfHII?=
 =?us-ascii?Q?t3A6ZK34tBTxs0mj/Bi1qnQ33KLWuqnM2fP77pCyl8gmfaB8V7ZLDnRypB0X?=
 =?us-ascii?Q?fIpC6TJ1nO9i5fbQKlsPG8C+XgreiVHlBKptXVX4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db701b1-6009-4276-ec4b-08dcccfe5081
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:26:22.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSt9lGt0FDYIg6UKEsT4siK7dV7fjSXcRjs5t2Q3ZZetnot+8VMpFDFM/h/zTS8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

On Sun, Sep 01, 2024 at 10:27:09PM -0700, Nicolin Chen wrote:
> On Sun, Sep 01, 2024 at 10:39:17AM +0800, Baolu Lu wrote:
> > On 2024/8/28 0:59, Nicolin Chen wrote:
> > > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > > +{
> > > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_viommu *viommu;
> > > +     struct iommufd_device *idev;
> > > +     int rc;
> > > +
> > > +     if (cmd->flags)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > 
> > Why does a device reference count is needed here? When is this reference
> > count released after the VIOMMU is allocated?
> 
> Hmm, it was used to get dev->iommu->iommu_dev to pin the VIOMMU to
> a physical IOMMU instance (in v1). Jason suggested to remove that,
> yet I didn't realize that this idev is now completely useless.
> 
> With that being said, a parent HWPT could be shared across VIOMUs
> allocated for the same VM. So, I think we do need a dev pointer to
> know which physical instance the VIOMMU allocates for, especially
> for a driver-managed VIOMMU.

Eventually you need a way to pin the physical iommu, without pinning
any idevs. Not sure how best to do that

Jason

