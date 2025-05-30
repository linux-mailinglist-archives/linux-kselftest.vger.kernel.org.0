Return-Path: <linux-kselftest+bounces-34085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B640AC94E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EDC1C078B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706D2609C6;
	Fri, 30 May 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="syKpiY8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FF25F99F;
	Fri, 30 May 2025 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626842; cv=fail; b=QArwGUK5YHYI8xGeGaWN3giPrWBdRDR3o/QbccXKIcTARKyMNu7QTveejrqX7LTHkpWQkEnmmyWaePVmzbFvWpj05PXQpi2ePFPUZ+7cKCbx7naSdJX1XklWpmA0/ciz3uuKSEtFcZiHt4pllitDghvoDICdgwGOOuo21t+UlxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626842; c=relaxed/simple;
	bh=Yd1F2d5x6+2/3frysvYSBs2IRCaTy4N5ctDy3XZ8LiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTvUnk8LMFONEJLL/QLbi65s6E4RkIWR8JAU/CkidtSkG8dBkOIo278wrY0pgC5M5sM32SBMZxkCOa7Y50NyxB5WJtFDUSp3pS4DxZOA13c+mCm8ur4up77vFgD29wMquzkWFEg3vHjjXACW+xNvE821c4lYE0icFHM4YszdFO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=syKpiY8w; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnauMDRyNPQu6OzYmSVM1S5i1OFLDaUaQlWeNc8pxHOYb/cfDR5++HsMsxKmRv48Ub8suXtxp7s1E4d+7WYIyUZJvUgkQdBBbhyMQYSfaCJDppPM2tmCrDHMFAip+OgpHRs/QVSWBzZQeWhnz0+hLXBQIaDl3sFpnjHwp0Ol/TGABWA5ZxvAO9oyPLm2b/CiLMaMStIWEiJ64E9zv0mp9XClT/ETFaw5mjLW12bx3lDpjbbdYSUymXzaGaS29BzBIjNka7Uh8dvyjlVuBtNm8rNs6moxo/BqTeBHNLERQPwC8mMYDMIRO6EJtBz3qtAgZrUy+vjQU0j8+oIunf8DTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJickMxWJJJsPSDP+xpLO7/xIXgc1/SG1k60SSmiHZQ=;
 b=n5/cEGnNPtVJlIRVBv6oLNciznt0FtHcDm+bMjyeyUMnK77OXCZDGR3SfEE92iLEZqHj70FI9RM6uakb32+kWm528Tdlq16jsSYZ3M9HJLFuxrKdZ8BZ1myHrT0Oh5TlFuons2OyT1SKUmORb35Q3ik1O8oTyZz3iCWeD0wmJ/syzPzLrA+WhHkomRIgLbqyQ8YmeaETLxCeb/qtFaZ2jCtBH0jEtF/c3UaEZOTQpkRkkqtOmZrXt4b3A8jCjiZW0CEawNYjTAFB02zfN6DxLS7aDeMiIn1f3s5DDqqOZLC1Sql9zqdGNky6dEz2HISuiaTkFEu6NCJKXwpAXJK0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJickMxWJJJsPSDP+xpLO7/xIXgc1/SG1k60SSmiHZQ=;
 b=syKpiY8w02bS4Pdu20Kt+Y4dOI+5Ba16hILWSqJnx2ODy+ZfMKlX8knXshUtKrp/tLDNeySGMHpRidI5I0tAH6pXRIyDugB6qIY3vCNlxySuIh3v7hIuMWg6670goxZ+L4I5JFQeO05xO6MA6KnOC93Lx/skCC+VytMZ9PiGyI41Dh5pmSyFRAvYe7Aee6zcZ2VwFuiMHNJBlbjufa6zjKfykVTaZZY4J48kGIgVS8Ts5LHryxKeSZmeSsDTw9BLPzo1/HdY/NPbfbFLyKv0a0THr1ojjgMnJIDDuhN/QsP/ssJYF4XKhiIOX728b2XX64NB3r3k7NNvc+Ht9QI07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 17:40:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 17:40:38 +0000
Date: Fri, 30 May 2025 14:40:37 -0300
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
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250530174037.GR233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <20250530161455.GE233377@nvidia.com>
 <aDntEDywhsgMoZwc@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDntEDywhsgMoZwc@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: a5410a4c-56b5-482a-88c5-08dd9fa1170f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zZTyv7PWU4a+11mBSXNJ4qAP+8Ob607IUYHYM411NfhOh5tg5e4wST1evYyB?=
 =?us-ascii?Q?nHhwMSUZSeMKcW2jzfKQ/hzEZmicywV8FgCY6DyEH7lYBFwWX48hv4oXjXle?=
 =?us-ascii?Q?vXk4jCVbdHLxFbW9GXbCDMRuz5wBOKoQGEmu31VQX8JwIolaFpnPhFPG6WVe?=
 =?us-ascii?Q?vjlYANWRRHpBa15gN4odKo+LFpv9AVehhM/TgMlOQvBThd5WF7IJR+pRTB+D?=
 =?us-ascii?Q?XXcmYx6P7niMdv4xW2cgvOK4KfnqDPKBs9lS3a5v6nHlYWsYGGYofPVY3dOP?=
 =?us-ascii?Q?SsQ8I11aIAHmPLm2CDihmKcXKT2ssF3rhrGO+UBeB0ccgrxFwKhQCcZlW1xH?=
 =?us-ascii?Q?ZqlKPDWadJ2tuyfSVvSlg/qwL7VvpcbgvdamyCc98OydIAfPU8o2X3xeyLx4?=
 =?us-ascii?Q?pQ4pF/gxslXt+6u6IXH3HXGMGlQ3LFRAXp7tKoP3cd2ypyepqqc/3zCKed8l?=
 =?us-ascii?Q?9x6jRhs+Alvowo1yPRJnSpo9OFQEVcINj5hTItQd2q0sZ7COwwtlAWXcdFW1?=
 =?us-ascii?Q?J8kMqX8gBcgVnJptjRwe7TGQW982eGGL2Ypu/LsMqw+8jGW4+O4SpfKZoJDQ?=
 =?us-ascii?Q?HOcurI9lkRoaMxp8vKH+zhoaQ9s4fMfgYtE3IIOgZFPogydnVK2pAisHsaJG?=
 =?us-ascii?Q?ZrhNBrj1GAFCOu5Ef1Yql5OVduY0Q9MM5tRp35KQu+hrQ+ktL8QDvsDf6Ktv?=
 =?us-ascii?Q?/ZevxIFnVJghU1CJR+oRBtQPAv2Drk1q1uOaMh7Sf4UqY65v4g6/tTkusMpm?=
 =?us-ascii?Q?ttK4nYJi88P1KI9ClY8v1v2eJJziBA/bpJFlO0hgeBM0MCEjxnLHGBmByfJe?=
 =?us-ascii?Q?pjPogA/s0wJwB5rTyafoP3k9IeWZTeg8G6Y/gxRklePOeD6j8bDVvjEJJlan?=
 =?us-ascii?Q?pj8ZB4MPwBQPfPNEShWgm73GZHM/Wuf5xXImtdR+lL++BnUXZhxK2galq2LV?=
 =?us-ascii?Q?EuTiFBx8BeYYV4QqpZwzxUBBR5PB3CPnvScZD6k8KCrjdmHVloE1qwhVwoE7?=
 =?us-ascii?Q?IUC4U7yU5YXZ61twt7JP2pggVQ7o5vw2rJ9yih+jWUXkJJg2A4YXzufHuNp7?=
 =?us-ascii?Q?bA4mrFKm0sGlVWyKnN2h7kaUSmUPtLOje7pnxKz4W94mUHq7UvqY3V4oyZ8V?=
 =?us-ascii?Q?5OC7/weTV2BbXOtjJADC+PonZDbXVXtPm34ujHEoJnVk5WdWLpOrDzMRbm56?=
 =?us-ascii?Q?tBd9oIOzl6shRuwhjiNWaDXbJlINDSnALd8Fq2ftmEJ3peBrMBaPzfpShoTr?=
 =?us-ascii?Q?CkNwjopJNao2t9APl7EcsdsACZ6lkU6KlQ40WXkbl3AigY1MK2/W3XeKbzWU?=
 =?us-ascii?Q?tD20KM5NaxxGH4bwRxlgoxGaQH6lxL+wuXSrc/uNGrNZ7/wNKSPbTzlfpzzY?=
 =?us-ascii?Q?PUFcf86mwRzfYzz3ZKBT0jpSuwOi+65iALJ7Yr5tHV8SSn2uJdT19tLaUAmG?=
 =?us-ascii?Q?d1OTD0CGTwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZW20notMWbc/n5Uo1A4twxAMEjlzFfcAujMdoaPJcY0TmLvjVdaOxuZ38no?=
 =?us-ascii?Q?FEBKhTl0Rs/kekswYiHooxEvI29netY95V/3QKb5FrU+hBi6R1ASXX5APVkk?=
 =?us-ascii?Q?VyCpHvOPA1go2/Fuyh23bGudzW5h15ynqep7fryC2OCwv3Dk5cyhgsdGagtS?=
 =?us-ascii?Q?3EATDZK9tLYutNZM5aylzmXLrANeQIWJIEbirjZhvAXyHOaqJx7uQWkilQgN?=
 =?us-ascii?Q?BvNKn4zLZgeTSAsUdPb0MxEAQjLROFk9O7snHDQdqu+2bIL/URasfCm9xqdD?=
 =?us-ascii?Q?ktwcHoFminSFpkc36BW1h7H95wz3TyN6L3K0TAKTBSkzQ6cibSiYM9G55tbX?=
 =?us-ascii?Q?DDT8s4Qm6z2h9118Ug9MS2/hobm+h7FWO8hNmy0lZAvOOh+GOHUIuiUmiubF?=
 =?us-ascii?Q?qBwhksRHHtYWeRizkKIKtGQ9aFG+0yvdxeccHpThGsF7Ts3ufgJb+jhDpe9g?=
 =?us-ascii?Q?nLrZpI7oq4dyN9IS4r9cydUR5WXiil6lgEh5t/yqBUu7tEeAJOGPxywZ3vDh?=
 =?us-ascii?Q?5a8uCkvsC5t6H1/l6P6m97d3+8ctMzLBjCZev8a7crJ77OJHhGXxya0Mu/xl?=
 =?us-ascii?Q?pjxAM0+KXBKe/RovfH5kbDFmHUN5kpAi3XX6kPlDhUdCHeBZ629lHjB+3mqx?=
 =?us-ascii?Q?5zwtu3GbpfJMzuq/MXBIHNW1JhlBg8qVvctQerWIQ5KvTbcSv1f/G/k2Kxgr?=
 =?us-ascii?Q?xu/Js4+rqTB3jCm3OtuUT8G9hGc6faOv8oS3BvUg/EsyqxCFvQUr462yeiz9?=
 =?us-ascii?Q?ubJ6o/H6iOGpzJQtXubETzk5PMxZdcykajS1XDhc1KJ9gslX6/0p/DzFcdsQ?=
 =?us-ascii?Q?EQ5mN6BCWXhpzAb4BCzwnE6K9Z3caUjUEE1TKmCk5QAD/QU8hLvI473XpaYd?=
 =?us-ascii?Q?zfufU1q6X9vITEEv01ttdg6F9BjLiavEujdBmdQoEIAjrl70PgVWteWBz4sJ?=
 =?us-ascii?Q?bqhjlkPrD3dxHAK4LBlYqJ+ouCndu5qZfRgWwh06b0HVhWNW/AmccoAVnvzJ?=
 =?us-ascii?Q?gRpgMDtvqvl1Usz+jLlwSzgUx3fr2/Ff2I6E8R1M8P84mCc3BCgi069ar+7t?=
 =?us-ascii?Q?/b8S6/HLIFNStYHKZ9oE0x//pjemGv1MeEOuJZ7q81Mt7kyz8l6MC7+5I+MC?=
 =?us-ascii?Q?lLlxQuy/xfAzyku71bpNBym0Rdn1HZ7DYjtzZ7YHHE/ExuDkOv/TRbr6ELun?=
 =?us-ascii?Q?KHhQTHOrsdsX2+LIYny8vKRkXBEGfciZLgl4Mk0v3z9/a/f3GbrkEL3djEzE?=
 =?us-ascii?Q?xnezEN+TwI4mUF8iqzjnH9wP0GRE3aISWLIji9hCoR5kqZx9l8jzPv8il+3U?=
 =?us-ascii?Q?F1sO+7lJjIxei/4Q4u+CWwiucZeCXQzXaDD8oh7nwKbdV96Bz+oVE2TaSj6I?=
 =?us-ascii?Q?K8ZdATDRTK3nbguUmcGuL16Rw9YTMDbdhP1R68sY/+vqDmCl5UtBAAwaf1Ka?=
 =?us-ascii?Q?s2Aknos04EUJfOuk4JfboJun4aGKEvPk608FxuqmUFD4Km3vaq7kKHr3lolG?=
 =?us-ascii?Q?fRfyJBRzXyxcyYg+hTz/8VYUVc6/v9029gagWZ44qt6c/wJIYXY+BpzIVwqJ?=
 =?us-ascii?Q?AmPxweaBEov9fT5JdzytLNsmdC83Stfb7W/BwRiS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5410a4c-56b5-482a-88c5-08dd9fa1170f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:40:38.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEvEqD9vs10zhAX5htvq1jX4YBj2qzdKw5I3VOMyhLpLhp2kjxJEsCFMAlCRjP1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

On Fri, May 30, 2025 at 10:38:24AM -0700, Nicolin Chen wrote:
> On Fri, May 30, 2025 at 01:14:55PM -0300, Jason Gunthorpe wrote:
> > On Sat, May 17, 2025 at 08:21:31PM -0700, Nicolin Chen wrote:
> > > +	offset =
> > > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> > > +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> > 
> > This should probably be capped to PAGE_SIZE/sizeof(void *), return
> > EINVAL if not
> 
> Hmm, mind elaborating where this PAGE_SIZE/sizeof comes from?

We can usually allocate up to a PAGE_SIZE without too much
trouble. Beyond that it gets more likely to fail.

> > > +	hw_queue->viommu = viommu;
> > > +	refcount_inc(&viommu->obj.users);
> > > +	hw_queue->length = cmd->length;
> > > +	hw_queue->base_addr = cmd->nesting_parent_iova;
> > 
> > When the driver is running, which can be a source of bugs.
> 
> Hmm, I don't quite follow the "bugs" here. Any example?

Like if the driver thinks that hw_queue->length should be valid during
init, it turns out it isn't.

Jason

