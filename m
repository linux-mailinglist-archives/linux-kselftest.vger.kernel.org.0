Return-Path: <linux-kselftest+bounces-18436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EB987D37
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBA1F219A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4BA16CD1D;
	Fri, 27 Sep 2024 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fx7mZKoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654C2AE84;
	Fri, 27 Sep 2024 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727405870; cv=fail; b=p3GVUN4qZy4fl5yEBrFtkUDKbb3slOSMBUk/uspwylzPsfnZkM89QM7KE7X5Bb9kKGxlipQLK1kGkmwJR3GtVeai6Y7IloZFlNf5k3JEEdOiE6lQTdNhwCj5ioE0X/nBoNmv3BBledB3hyNWjRTfEJuOd+gS9OhloDp2lBYmx1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727405870; c=relaxed/simple;
	bh=jgAZ29Q47uEAHwcrXl51FnnA+mVvhUriA77ryLyE/PY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQmep7CcV9CxGkK/9H1gYka9adNEwOXdty1UOkRKx2gKp/uD6TltIfsHUH4w7sioDP0l8Y1X+ej6KMUiysidoBK8ir8akmNyIVkV3M00X/fAKtQBV0/qmpdvIgJRuJGcsMMqpKv21vk9Q+bNTjs89clAU5XiHNpzN0WVWWhYfrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fx7mZKoY; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLNfpjJz202aRJ5JmJAlhDdoFcux8DSa4K3vBtbGtDwHeHBFDPoaHWV22rAp9xxNaREnxvz14qy7h4u/AO8ub5tcDjIs1X6hxIACt4HM7H+oZmAH52VtLnjtCNikTh5q8VWLL+KwfPIBINSNxp8UPYqRmgZTKF2kmPiH0NZWM7o5kYScyHwGmGgVU7ecfzv1tesB2kBaNI1EX8e3vPDPO67M7f5pyJrekVhGdkEGI7bpM272fKYVeAwqllQmz+RunrOm6mBK2JgKj1TJMaw1hZRuVum/vbtXqpQxzyhsr4rR/c6ZR9WLxPgwuwwBAbntmXH2ugtuBMJtZwRYjXHa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guYyaW+/GP64C0LE3ka9BsEgq29FrENofPz9y37J8yQ=;
 b=MVfgGZ6wcEiMvODYnOqIFBSTOZNBR7JFa9Bq22ie4DptbeNDfHIaPs/YRDJVU+iNx7C0VyWgAG/xu41z7YzOJ0LzxntvHsGhq4moLApcQEw4bSBlfMeD/ce6J+X9/aNuId6kGGsyZo0Xn5ZJVboVED7oBswKVMJWffnBFBQgLEJzkGShp4arCWjytJAEzPNuLPHAsk42AvCVcLWg+Gc3I32R0x3x1wsVaGSEUamKZyBmRjD5zI4egg4EWl57PDUBt7CwTu5rNbw4+Aw472KcgdiKZrOfN9DoL5gWRzRkxk7yUVhGbM6zRsztj7JEAFu7nnssAU7KIpBSC01X7VqFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guYyaW+/GP64C0LE3ka9BsEgq29FrENofPz9y37J8yQ=;
 b=Fx7mZKoYqVHF+tdil2+hVWCBiEc0Gcd/TAa0pNiEtlKSLYPWx0JXk94PYttW5ak7uMdSEXea9m7td1U0YkM51AsidQ59tSS7WFVdo6QRw0/qsFWlNSvvOfS96bnB58l8jbgsZ/NnYdS23c+KlRxblCNaYBiRANSJytQAJhApWWu7QB8Z8rpLoQ8PzOR1JAEnS1kGHXs6qeVa/c0JtVGhG7spdNIZVI0JTWERa8ISr9bzcP7ag64W9AcAlBQU6YBgJoc2S3okC/x+tp8+dRJ+oyDdRpUM/nmInFcNourxpIvnWTr21S6c0Nll29i2TRkxmTG/3ZpmAaWMQ/VnATEDDQ==
Received: from PH7P220CA0149.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::19)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 02:57:42 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::ae) by PH7P220CA0149.outlook.office365.com
 (2603:10b6:510:327::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 02:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 02:57:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 19:57:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 19:57:19 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Sep 2024 19:57:18 -0700
Date: Thu, 26 Sep 2024 19:57:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZvYfDR0cKeRdMFQr@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <BN9PR11MB52763F8856FE20ACACDDCCE68C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZvYJl1AQWXWX0BQL@Asurada-Nvidia>
 <BN9PR11MB52761E58692F05D741DAF2758C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52761E58692F05D741DAF2758C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a01f6a-9a7b-44df-4333-08dcdea027a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0JBSmlKWWp0dC93MGFubk52cEFTbHNIRnkrS0F3L3F6NWdpbzU0YVFJUEF1?=
 =?utf-8?B?ODVjcGhwUkN3L3RkeDZnL1ZQY1F4cGg5WXNheG9xUlVveUNzUmJlQ25VbU5D?=
 =?utf-8?B?UHM5MkxReFkwYStHU3p2eHI1QkxwU0N4c043SWZuWmVWbzBnYUdPL0Q1cHpm?=
 =?utf-8?B?cTVzNHYvUnEra2hObEk2b0RjZE1tNmp3bG9aSittczc5VHVzT2tXbktZa1RM?=
 =?utf-8?B?djU2ZHZiY1FmbUFkWk82aWlGM1pFRXVmZk1vUWFmaUEyUnA1SkgzdkM3czRl?=
 =?utf-8?B?U3hKQytxR1M4Y3d6OGN5N0dUWDI3cGErN1N5SzY4bXR6Z3AwZDhjYUNvSlFB?=
 =?utf-8?B?Sm9kRkpmMWRkM0FSU3BkS0lsN2FOdXFEVHovMVZ3YURRcmVYK05sUGVJY3Yx?=
 =?utf-8?B?ZDNIM2puUURWRkl3a0x3Ym4wVTU3QlRrUXFIQ0lGb2xQeU9ocklIWkJpTG1J?=
 =?utf-8?B?akNYR0xrUXpsNERVTmtBcFE0ZEZYblYweUNVMjFIM0dpeUlvN2UvaEZDS1ZB?=
 =?utf-8?B?a2FKekJiVjlvV0tVbDM2NVpYNndJZWM4aXBZb092NDBwTjNzWUd1bGNNM2Zq?=
 =?utf-8?B?dVFtRHZCcUdTNDQ3NUI4bzdsSWJzRjZSVGxnQ1Qwc2lGcjNDUHcrRExBV01C?=
 =?utf-8?B?ZkZRaEpGMEl0U0NibU4rUUJKWFRXNDJtS2hwa1lqOGJWYk0wVkVtN1dIenZl?=
 =?utf-8?B?d2t6NllDMU1QYVFoOWUyZWt2WldXd2phak1OZ3VEWmJTNTJNTlc1NzEzNldE?=
 =?utf-8?B?REhYK2x0QStBNW15ck9ITk8xR29Xem9uOE8yeW1MaEZWdm1DeEdNRVZJNmd0?=
 =?utf-8?B?Q0h6RitLYnladitkTnRDZXhvcjBBalNGL1RzQjBLTWxaaUxqbHFoY2plVVQ5?=
 =?utf-8?B?Tlo3R0tqeWhzU2ZaRFZodWVBWkRCTU1IUUsvVWFHRy9iZTd3T2d4ZmFCOE1Z?=
 =?utf-8?B?QmhIVmo1WURESFVQTy9KejdUUEM4YnJxbnlIYVkrSlQrRXpiemQ2SFYxU2d5?=
 =?utf-8?B?Tm5wN0xTVjZYZ2x3bUxpdWlJVjZJMXhrVDdFeENHTFdWTkhZOEcvSUpHdk8x?=
 =?utf-8?B?ei95U2tLVDBnckRvZFJvdTVxbEFwOGQ5YXE1Z0lvSjBDVEtVbitYNVZxSHJT?=
 =?utf-8?B?T0hOY05udm9tWDNsUVlXTFhDcU1qV0p1Y0xCenRiRUdMZHFmMTgxK09sM0F5?=
 =?utf-8?B?T3hXanlnejYvc1Z3SlRQd2orTWRkK085RkJRL1ZESGhYOStaamdaMVZSdCtm?=
 =?utf-8?B?c2pYbllNT1Rqb0FtaEZKR0g1YTNTdHBnaGpFaHF3cDhoUTJFREllbm9UQ3Ir?=
 =?utf-8?B?b01FUS9CV0tLSEx0M0NIZWxudm9IdDUrQ0lGZGhoZWRnTkFmdWxUcFRRWUpx?=
 =?utf-8?B?MEVLYjdrd2ZpVHdPNTQ3TDdSdkdBcEM0VitJbmpubXF0aVA4VmVQRUJiZDVl?=
 =?utf-8?B?RVVLeUpoQ0duREtNQU0yTExyZ2dTL1EvZGFON2FCcEVMcTZxK0dSMUhkaDlD?=
 =?utf-8?B?TThBY0d3UjNyK1UvV0h3L1UzVy93K05LVnRka0h3MnF3bjNETUhDQ1k5bjZn?=
 =?utf-8?B?RFRZWkRwbUpTNzFGQUQ0U0RQQ3AvZW54MDFDZTRvZUEranlYZ0k1MlhBaDNS?=
 =?utf-8?B?U25jT0FSUThWREVzMjM0Qys5M0N1OWlWa2JRblRiTlVVc2tyRC9GamdYTFBz?=
 =?utf-8?B?ZExGcXdseXJlakNlREY4ZEh2eERWSnFIbnk4bkJ6TStpRXE0MWFsMk53Z2Vh?=
 =?utf-8?B?OWwyUnRsbDh4cmthRjgzTEhiL1RzbDZpbTg3cHpORW10UmhzTUh3VVI1UXVM?=
 =?utf-8?B?QmdHUkY4ZjI4Sm5WVmI4b2l0eU5zNTU2eEt4alc3K3RjdnZYalpNZjhDVEU4?=
 =?utf-8?Q?GBNgAPBV455RA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 02:57:41.9440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a01f6a-9a7b-44df-4333-08dcdea027a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

On Fri, Sep 27, 2024 at 02:23:16AM +0000, Tian, Kevin wrote:

> > > > > Does it mean each vIOMMU of VM can only have
> > > > > one s2 HWPT?
> > > >
> > > > Giving some examples here:
> > > >  - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
> > > >    kernel holding one S2 HWPT.
> > > >  - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
> > > >    kernel that can hold two different S2 HWPTs, or share one S2
> > > >    HWPT (saving memory).
> > > >
> > >
> > > this is not consistent with previous discussion.
> > >
> > > even for 1 vIOMMU per VM there could be multiple vIOMMU objects
> > > created in the kernel in case the devices connected to the VM-visible
> > > vIOMMU locate behind different physical SMMUs.
> > >
> > > we don't expect one vIOMMU object to span multiple physical ones.
> >
> > I think it's consistent, yet we had different perspectives for a
> > virtual IOMMU instance in the VM: Jason's suggested design for a
> > VM is to have 1-to-1 mapping between virtual IOMMU instances and
> > physical IOMMU instances. So, one vIOMMU is backed by one pIOMMU
> > only, i.e. one vIOMMU object in the kernel.
> >
> > Your case seems to be the model where a VM has one giant virtual
> > IOMMU instance backed by multiple physical IOMMUs, in which case
> > all the passthrough devices, regardless their associated pIOMMUs,
> > are connected to this shared virtual IOMMU. And yes, this shared
> > virtual IOMMU can have multiple vIOMMU objects.
> 
> yes.
> 
> sorry that I should not use "inconsistent" in the last reply. It's more
> about completeness for what the design allows. 😊

No worries. I'll add more narratives to the next version, likely
with another detailed update to the iommufd documentation. This
discussion made me realize that we need to clearly write it down.

Thanks!
Nic

