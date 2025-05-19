Return-Path: <linux-kselftest+bounces-33341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A2ABC6F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E968116694B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B1288C14;
	Mon, 19 May 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cR73ycpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC5B67F;
	Mon, 19 May 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678486; cv=fail; b=WbTf0L11v66iRHs79Cixuf+sDOheG86UBnizMRGCcWXT3MvGGcIw7WoGmSwQIrAaVbZnPYGJKYGK2x1agIkH2T+sWAIu3F9Z91QvV4tCIt1LN/XgEuPa71RIMe7vrMTuB3bcU+ogvxSIa1fdaF0gQxPGR96w4f/XYvVG02BiwQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678486; c=relaxed/simple;
	bh=E43AkYRLdFE5+RqexdlrbVD9X6eueE2CIqfUGywhgmY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3KpDGQt/eoGtGzZtJC3MIIAah/78KJaV9YNQTvd8EuVkza4vvdhsyhXBQGefaibBdfoNbTSYlhC7cI4t3LnP6dXNc5l99DUSEgjG3uUA0brb+jOWXWlOFos88izmpBRIoHSfyp5D4EqFKqUlW8EkapVpZr6UJwPhhY0COw4U2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cR73ycpR; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duM+doj7pYvTdkoz/xDShOW0pXZo0ho6d4UA/qyPY0nPg4t+TMAFOEOLYfbbB9Hjv3fPFd/Fr5ToDgMkbhS9/fC7gU2iiHNeFTs5aKbIzliBf3jSubVGgnu6nxMqzz4Kph/cxhQn2ro8uhKuugQddz/RLUfrgDWbHqigB0p/vFCFOxZ4Ttj0mQKiwl5bSQeGTRNRrZfwx0BxpY8XcSfCv0a0haBdkJd9j1/eOFU/oR/pBNodjQBDrVMrdIuP9hGzIKuUjkE/SXe9tEkdgUpAEDDXdO0jox6V+ChZjPv/VXkb4HxPOKzgJqSUDxX7hSn/vpz46IjaDPrjnQJucFm1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiI7muI5EcSG+i3BLj2dZs+EX1mzG+fMXwUIvgZpRvQ=;
 b=Y11+ztooPYSqBItL76cyeBbRtUkM67lH6KB4O0eZrKbWh3ESP5IyrATzSBTzj4HzW8aFSwlOwMRV/TUp/XLt892SRNLdd1Yc8g1+3KmbA+y+ruMZaRsTm08moj7RqA2/61LNE4AiJbZugJsC4NX+P4r8IsWtw/KdWiMFO6eUZ2njFUxVfF9QXQpLKPpf3q61+x0IWCyJB16CPgy95nmY3IGMpuTJF8ibs5qh+S0mXc4tg32u/xZm+/95+xUN+2Zy+/nFjgFySwCuTSCkJhAVfOkCnvRkiH+Ou7vq5iqOKy92S6cTjft+CHw4CHAceb0D5i6cuNVe9X5YG1MbwyUB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiI7muI5EcSG+i3BLj2dZs+EX1mzG+fMXwUIvgZpRvQ=;
 b=cR73ycpRwVDuTqfkO4Wum/NAf4E4t+l/Jq4dvgirgtwuVe0kIKf6hVjnPRFyzyWnBVCXCgXElevTgyiWKfBFRB1z/aAsKED4MJ9jAZtXxnnB2lMmq7CftHcI6xKXnmAuwgOWenMJTREkobR54HAIpuCP8CnjgYmlqsiEwElK/wehu37BNSXYx/behP6ckIPy9XIx++VT7C+aMKquGvRAgMCegfGT35hDMyNMVWgzWEXFjnNiE7TZDuUWDdQ9u9tmAhol2PEuCZhTIW3xstwOnhGNfTNUmB8vzuXvYVIaCE3LGaUafwnW4qEU4DfsDj+vlff6xh+/cqhgCzJrX0XVgA==
Received: from BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 19 May
 2025 18:14:42 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::1a) by BYAPR01CA0067.outlook.office365.com
 (2603:10b6:a03:94::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Mon,
 19 May 2025 18:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:14:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 May
 2025 11:14:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 19 May
 2025 11:14:25 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 19 May 2025 11:14:24 -0700
Date: Mon, 19 May 2025 11:14:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aCt0/kOwCn8wZJG0@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <0019943c-44c4-4dae-a175-8a5bdc02f017@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0019943c-44c4-4dae-a175-8a5bdc02f017@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 123ca0fc-542e-4a22-53c4-08dd970106de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUtybDNtZytxbVhLbDJINWVwaHNsbzU5U3g4UStsS00yMlFWSmp1bERzK2V2?=
 =?utf-8?B?QnlZQ3MxYjhhWVpScTQwWWNTaHJtM3I1UDFaQ0xpN1ZtZmZHakFOR1lrWHJr?=
 =?utf-8?B?TFZTMXRNQ0x2d0RDa0FWNDBJZ1dCZ2hJRXNaL3pMdGQrbG5BQ0JzWjBjRE5N?=
 =?utf-8?B?YThpN2syRGRSS3p1eldRayt1d3BOUVJhd0IwaHhlZlljS3BBUFd1aURNV3lv?=
 =?utf-8?B?UEYzbmNPakplMEdZcEFhYkxLcVVrQTJuNWUrVFdEZU95b1NuQkJKREVjWEgw?=
 =?utf-8?B?d2Z0ZHFkdVM2UXpqbW9aM2JoRWhVNzFEeFdNaEJMTnBqOWhWNjhKWmVWUjBM?=
 =?utf-8?B?Q3lXK1ZCRHhmckQvVmZwYVl0V214NFQ2SkRZTDJxRS9KeUptSU1Fc28rYzlJ?=
 =?utf-8?B?VmJyVlBkblU0VFU3a1p6SGcwbTZhWlJicTdYUlpvMHdHWUdMVG1LWlJHeDVT?=
 =?utf-8?B?bndWTkhLSTFXTkx1ZzA3Tkt3bUJRQldPUS80R2hBYlZ4WVJrd2VwWThyS25z?=
 =?utf-8?B?N1d3bTc0TDZuSmtaOVR4TnZYTi9sYjNCUDRxOHVNVGRXVEFzUU8wN2xFUFJE?=
 =?utf-8?B?eE5WTnBvOVE1aHJXVitMc2dndGJSdkNPVUIreUhRTWVnT3pXd25HYTJ0RHov?=
 =?utf-8?B?T29TaXlQQ3ZJckVoMTRRYkN0OW13WWNYbjZpemtCOEFQTWJjalFIUkF1MVc5?=
 =?utf-8?B?ZGNNdHhLNW1Hek9Lek5FQzU5UzVLTDNkU2JoRjZDbzVFSVhQTUg1QUpUcmM5?=
 =?utf-8?B?NlZvendPY0tpcmZLV1g0aldUYWxNb3F1TmFNWmltbGl6OFNkU09uQVlIeStJ?=
 =?utf-8?B?ZVhMbVVFVlZwYlV0VDkzMVNPeHp2R213WTVia21qWFl1clp4RVlZTU9mWms4?=
 =?utf-8?B?RHRXZUllekdaMzJrU0w3bHR1Zk5lV2RsUmV3dXhXNWZ1SDM2eEszWGxKeEpv?=
 =?utf-8?B?UXVwTzJ3TWtrcFI4WmwwU2M4RDJzMnY2QVVPQm1SUkxsOFJDTmZkaVZTUWtJ?=
 =?utf-8?B?cTh1UXEzRDJwVnFHMWpqUDVXcDJJVmU1cEY0cEtRSlBGazFJKzk0bmNrL2tD?=
 =?utf-8?B?S0M4VEhtdEhOeW1xN3ZVWnNva3lpbm4zZ0pGa2tqbEtKMWYrUDg5eXZ4VXpW?=
 =?utf-8?B?NTZGQ3FtU3NSMy9peEdXeDIwSlkvVmVwbVFDY0QzM2l4bkozNDBTNHFjS0Ew?=
 =?utf-8?B?THZ5Vm0wcXdEam52a1JWT2xuMmd6cWRrVXppQUNubytGV2Q4N251MW1oaHV1?=
 =?utf-8?B?T0tURXQvY1kzM0g2R2ZjeTJUT3d1SnF0TkU5MldFMm1JMmpkMTRmWTRZQUNZ?=
 =?utf-8?B?eDVmWklBSHVGT054TVgwdlpGRnZvM0pXbkRDQ3gwaHQvVSs2S2F1RGxUdnNh?=
 =?utf-8?B?QThMSXE4QXl2NlVPOWptQktJOUhZbm9VQzVwanc0cjJKa21wZXZaaTRnQ2RW?=
 =?utf-8?B?T3NYZzNBeVQybkttR3Z5WXVpTG5ITjZyRDN0RTVVNUR6NlRKaHd3V3p2ek5o?=
 =?utf-8?B?bmZJNnRXdVlvQ2U2TU5SRjRoaCtnZ2xMeDFSaFJDY3VjenZYYUc5TGpZRVk5?=
 =?utf-8?B?VFZudVFaUmlXNnpYdlNTTllKL21JNUtUMnNwT0VBZktjWCtIKzhoN2YvT3NR?=
 =?utf-8?B?RjNmRDRjVnFDS3JJcFJwV1B2VFd6MTZ5RENKQlV6Tm1GMmt2WU5yRElZWE1C?=
 =?utf-8?B?NEpGT0tvSkFVVEEzYlhmckdLN25pVGVSM01ZelVjL0pBNVFXMllBOXgyeWtY?=
 =?utf-8?B?dlRaL29rS3ArZzdWdzVNVTZOYzcrSHFzOVptanlrNXN2Z1NCV0pidG5JZ3Mv?=
 =?utf-8?B?ZmNOczNiR2psK0VKUVRHdCtLK3U1Z25MZ1pFMm96K0x6NnllM2FvamxqU3Jy?=
 =?utf-8?B?UzgyNXZZQ1BWVnRoajA5Njd0VzZheFJIUmxXN0hwUjF2UGsveHI4b2xQMUJE?=
 =?utf-8?B?ZU9NTnpRV2lxUDJZU1AxR3VMOEtiWmJmS3N0N0ttd1NLRzNUOHZjRzB3Ky9v?=
 =?utf-8?B?a1Z0K0NXVTVsYmdoSnhaQU5vV1k0QVFnTERmRWVwZXlwcmkzbHViMmdqTElB?=
 =?utf-8?Q?43vmJi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:14:42.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123ca0fc-542e-4a22-53c4-08dd970106de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

On Mon, May 19, 2025 at 10:59:49PM +0530, Vasant Hegde wrote:
> Jason, Nicolin, Kevin,
> 
> 
> On 5/15/2025 9:36 PM, Jason Gunthorpe wrote:
> > On Thu, May 08, 2025 at 08:02:32PM -0700, Nicolin Chen wrote:
> >> +/**
> >> + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> >> + * @size: sizeof(struct iommu_hw_queue_alloc)
> >> + * @flags: Must be 0
> >> + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> >> + * @type: One of enum iommu_hw_queue_type
> >> + * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
> >> + *         model
> >> + * @out_hw_queue_id: The ID of the new HW queue
> >> + * @base_addr: Base address of the queue memory in guest physical address space
> >> + * @length: Length of the queue memory in the guest physical address space
> >> + *
> >> + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
> >> + * allows HW to access a guest queue memory described by @base_addr and @length.
> >> + * Upon success, the underlying physical pages of the guest queue memory will be
> >> + * pinned to prevent VMM from unmapping them in the IOAS until the HW queue gets
> >> + * destroyed.
> > 
> > Do we have way to make the pinning optional?
> > 
> > As I understand AMD's system the iommu HW itself translates the
> > base_addr through the S2 page table automatically, so it doesn't need
> > pinned memory and physical addresses but just the IOVA.
> 
> Correct. HW will translate GPA -> SPA automatically using below information.
> 
> AMD IOMMU need special device ID to setup with  GPA -> SPA mapping per VM.
> and its programmed in VF Control BAR (VFCntlMMIO Offset {16’b[GuestID],
> 6’b01_0000} Guest Miscellaneous Control Register). IOMMU HW will use this
> address for GPA to SPA translation for buffers like command buffer.
> 
> So HW will use Base address (GPA), head/tail pointer to get the offset from
> Base. Then it will use GPA -> SPA translation.
> 
> 
> > 
> > Perhaps for this reason the pinning should be done with a function
> > call from the driver?
> 
> We still need to make sure memory allocated for page is present in memory so
> that IOMMU HW can access it.
> 
> Pinning at the time of guest boot is enough here -OR- do we need to increase
> reference in queue_alloc() path ?

For NVIDIA's vCMDQ that reads host PA directly, pages should be
pinned once when stage 2 mappings are created for the guest RAM,
and iommu_hw_queue_alloc() should pin the pages again to prevent
the gPA from being unmapped in the stage 2 page table. Otherwise
it will be a security hole, as HW continues to read the unmapped
memory through physical address space.

I understand that AMD Command Buffer also needs the S2 mappings
to be present in order to work correctly. But what happens if a
queue memory that isn't pinned (or even gets unmapped)? Will it
raise a translation fault v.s. HW reading the unmapped memory?

If so, I think this is Jason's point: there would be unlikely a
security hole, i.e. for AMD, iommu_hw_queue_alloc() pinning the
physical pages is likely optional.

Thanks
Nicolin

