Return-Path: <linux-kselftest+bounces-31857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65964AA039F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B944E4801E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85682749F6;
	Tue, 29 Apr 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWZC0h0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3367080D;
	Tue, 29 Apr 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909148; cv=fail; b=T6EnfCgpYYm5iwWpZTQaaZgm/eRt38GBKufr5yXOerCL76CNCUmV1X4krH7/U2a9cjpSv5PXZszS1yNET9zv59lwQID9DrDpHRRbCqcjtDcTZV3F1W3BbWFu2EwFOYnxWfDeKqJbXfU61pwatxaL+3BKwPDKHJornv6a1otaVEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909148; c=relaxed/simple;
	bh=lIUmsIV/I4e9CujcXdFFRIt/xRVL172jmJlk3SaKNRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TveqYhvrdkXmI83jHITr/sUD4qfxH28gaG7HnWcPfmumWc7tMf8zbEnq7cMbAjoCdx4nfNvkvnA/GpgM0T1/hkaGDfh7V2sa/dK1usryTlQx6z20oWr3zUOu7rboyimLJDYrfDW6hTzWZDKVl0szn96JM/6jUpeNzxiNtV0pbj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWZC0h0y; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcWKh7W5dJWfdfYEttFozo/92EiLgS3M6/YAZ4wTS9yg1/jYvdcWA7Ab0pO5mk4f2MnshYJXgqwcW+eTdsR+6IntlzWDLlzaz5tAUF0BPxh6VyS0W/delyk5iDKJACxnnrFJmzOadxnVNOxI+lWzJ7di5oVIy/ewnX3of0f+cCERxEsw7mEf3euNw8Gn6ljkQ816A8tUNR1jwljiGQdI/Ynqupf5aXwO8D6tbn7sMK5KIjmlzQhM11kNPHxdqKJmQ37Csx8608qsL7e7y27RExsUvgUqYF1gx7o16gGnKjznpKBLF10pMHU53fHe4bZmNoBGh/gnBrq7iP7uDVCEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSyY6XxtIYMJ8wgNhPyKsiWOPe16j2UHnEM4U8XVQVM=;
 b=N2d2hNDAgpwo76qq0eXYhquswAFVy0ppzSK4GWoKceOSru/EJE7W5nmI2/QN0GEzxY8MqBrSC+JVWGSxqp0LjOaJ/sokAVWxAKx8kYRGTyufleNfFdV1ye7lDoq1+MI+2uYRJxINChMhWuadJGbSVa8zZ5KYDHjIgPA/wZrZIZwe+nrMizXLvu1fNV68tZLzcJHswbBQ96PPNfovE1T8ab1lt+4+gqir//gEpFQ9n8ZUZcl2bEGt3cY+oCvVm8O5WYiT7TxMKy+opyA1ih6aOnO2IiRR0OC1gCpjb9Lz6KVJQazjSLn9Gi3ejUhyLdRdtu+xP3mnJfmr1tLr73Fr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSyY6XxtIYMJ8wgNhPyKsiWOPe16j2UHnEM4U8XVQVM=;
 b=IWZC0h0yQoyem03ne6CjngYnUw33nomrw5go6FtpuXQZ0KbyNvLHx4OnZ9quFSts0EwgA7gYH+fPQiaKcrc5JPE0owS2AycmqAHefjQQTVmCwAI77po8zLS0GM/zgWaOh7bOVvX0FhoSYd3Dcngl9YstuMkt0gDXDLpZI5h8zAtZuH+eS7jc5VipH6xRhwSuEsijMUHv0mDk8mOjJVoNwOP1PyOsyLh09JkkzUs19DNn7Ie3TPYEHwCMA4e2b279feOWF2237k0ZJpYfhXWiZjreTHv683hPEZTaqG66NVqTujZWI2qQP0Fok7isGVy/lCPpew3av1cpKkzjIlMiVA==
Received: from BYAPR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:e0::35)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 06:45:42 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::67) by BYAPR05CA0094.outlook.office365.com
 (2603:10b6:a03:e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Tue,
 29 Apr 2025 06:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 06:45:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 23:45:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 23:45:25 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 23:45:22 -0700
Date: Mon, 28 Apr 2025 23:45:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBB1gLfahnLmn0N1@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: e8137918-c50e-44f5-563e-08dd86e9757b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnVURkgvRGZMNlNnbkNuZms5VEFGOUVsbk41Q3piblU0R2hLK1dsZUhxMmhr?=
 =?utf-8?B?b1hRUkRtb3RFOFhUdUVMZXNsUy9lL1lUYkMwMWkwQ0hqZDdieDljMVM3dVV5?=
 =?utf-8?B?djV5bG9qbFduaWwzTDdua0JBeFJpek5MRnM4UEx6Z01DM0VOSDdTWXhmdGFh?=
 =?utf-8?B?dUFBdU5WRVdXeHJ4cktIY25oT01MWENSbkxLUGNmczZReWpPYVY1SXBXL3Rk?=
 =?utf-8?B?bTVjTzZTcE1EaDNDWUlIeEhsNWw3RlI2SDZISi9ZeGtHYmgxRWZSUlVQbFNH?=
 =?utf-8?B?aXVsU1RMSENwdDVZSEsrYytxN2h5bUdlSndoL3VXMTV6aXUxQnhnWHlVa3F2?=
 =?utf-8?B?azByM3Q4Vld1ZC9VNXhsa1NCRmc5M1Zva1ZuMDNBR2V2TVpaS2kxWk5IS2hK?=
 =?utf-8?B?SzhyR2txakpHaGtLNFJ1UWFEQXRwNVRoVk1ScjV6czVDY3VYcVJqalVlQWxD?=
 =?utf-8?B?MWRyeXcrWk5reEI4enNjZVVMUmNNNWdkUVIzOWdwZCtRWkNNVUlDV0RlMjNJ?=
 =?utf-8?B?eUREQktaTWg1b0Y4QXZjYmdsUHdRK0Uwd0RURG9iSVh2ZXVEVjFGbjJwZGVC?=
 =?utf-8?B?WFpMNlVzbDllTlJGK2dXWHIrdlNYRHNoS2ZJNHVkRWg0N1UzZHJDdnFXT0kr?=
 =?utf-8?B?Tmt4R1k4SFhZbnRqcHRybk5DMGdBYWpOWFFoL3YwVTRDeXArY2t1L2pPbUQ2?=
 =?utf-8?B?eTRqWjNvZ3FWVWNTdElGKzhiSjJhTDBlMzhvWVE4Q1R4R0FJZnE0dXlNOURU?=
 =?utf-8?B?YTlYNDZPLy9GZGxqcU8rWXRYNmFDQlQvdUhFSlpLM1hkbFYvajZMVkp5Wmhy?=
 =?utf-8?B?U0orSTJmVVlLNjUxeEV4ZnRDMTRFaExzczdyelBWRWZZNUFWcytxdmFRdFlV?=
 =?utf-8?B?OHN2djdyM25lc2xqS0lNckxQWjdJTTRUZ09CL3RvRkdzVmhpQTBzSkg0VlVh?=
 =?utf-8?B?MWlSTmFoQnBhWHBMSk5zNTdRblcwWlNJcVI1cWk3c2R1V3U3cW1ocVVnTC84?=
 =?utf-8?B?Z3RwUUhpaVBUUGdJdmxUcVZ5cW1ZSjhTRGt0UTdNL0krRWg2K2dHYzRJdExH?=
 =?utf-8?B?d0hTZTZ6Y0d0TnMrWTJndWYzeTBlOUx6Y3BwN3ZFMitDU3RwQ3pSNXI3ZitS?=
 =?utf-8?B?UE9XRlQvNHNjVEZpVUxlc0F3ekVwZjVDUjBRVzNxUndHdlJzYU1LZjFCc1lw?=
 =?utf-8?B?eExLS3pyaEplMnBBRFBqbCtpRWJjaFJNL2JoN1ArWmM0MlBuQVZKaUswUHRX?=
 =?utf-8?B?T0tWdXJTNWVNQk4xczhCMmlIWnFRTDIrNUZsS3F3TFMyYTltcWs0anpjalVw?=
 =?utf-8?B?UU1IRWRWOGQ1bXVsek1VZm9naU9iSXRmTy91RXMwemJORWJTUVpsckE0WDA3?=
 =?utf-8?B?bG5pN29GbXcybjFnbHhyaHNvSVRKbVdYVlFadGFwRjlnb1ludm1PN09QbXNw?=
 =?utf-8?B?VVY3MDRRWWxUamZROW1Ec2hlQXVpMUlnek9RVnY1cGdxb1RRK0FROU95eEc0?=
 =?utf-8?B?VVkva1NiK3Y0aFRCdWZaam0yem1xVUVjcHlMVXJnYlhlNlJjZDJqSTYwdWNo?=
 =?utf-8?B?MVZMSmRQVzcwelliSjdBaTNRRTMvMllYaHRNcXRIVFdFSHlYRS9TQm45YW55?=
 =?utf-8?B?dUE0UXR2YVd2NnJkQm9sUXpTdDhFSE8wcXpEdXBHcHovSXV3L01xblJiSUM2?=
 =?utf-8?B?MkpBQmMvZE9ZODJxMUxBOWM5TXhrdW5OL2N6SkNWNHFQemNCcHlWZmE0S1NP?=
 =?utf-8?B?azNCbmhDWHdjckRDaG9Ec1ZVaDIyMi9GSjhFaUZoVy9Od29DWlRsNjRsaW81?=
 =?utf-8?B?Z0R6cjVKdldsS2dDc01lZWM5bTVPNjZFRXVxaUZXc3BrT2xQdVllMFova2tE?=
 =?utf-8?B?V3hEc0xteTVJbklDRkI1bTlhZzZRa3psS3ZtTUlOUG1XMEVtMlBBVU90VjFn?=
 =?utf-8?B?dVdsUTBmWW5QZVlrbjR0WS94SWVPV0krMWdFOU1KSysydjR5dnk0Vitkc3VD?=
 =?utf-8?B?MSs2aFlCYjRnRStuTjZLdnZSMW1RQnBDOEtiazBYUVJPY0crV1dCNU9uOWN3?=
 =?utf-8?B?TVpUaGk4MTRPWGE3RjZWNGkxNitWVU95MmVyUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 06:45:41.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8137918-c50e-44f5-563e-08dd86e9757b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312

On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
> On 4/29/2025 1:32 AM, Nicolin Chen wrote:
> > On Mon, Apr 28, 2025 at 05:42:27PM +0530, Vasant Hegde wrote:
> >>> +/**
> >>> + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
> >>> + * @size: sizeof(struct iommu_vcmdq_alloc)
> >>> + * @flags: Must be 0
> >>> + * @viommu_id: Virtual IOMMU ID to associate the virtual command queue with
> >>> + * @type: One of enum iommu_vcmdq_type
> >>> + * @index: The logical index to the virtual command queue per virtual IOMMU, for
> >>> + *         a multi-queue model
> >>> + * @out_vcmdq_id: The ID of the new virtual command queue
> >>> + * @addr: Base address of the queue memory in the guest physical address space
> >>
> >> Sorry. I didn't get this part.
> >>
> >> So here `addr` is command queue base address like
> >>  - NVIDIA's virtual command queue
> >>  - AMD vIOMMU's command buffer
> >>
> >> .. and it will allocate vcmdq for each buffer type. Is that the correct
> >> understanding?
> > 
> > Yes. For AMD "vIOMMU", it needs a new type for iommufd vIOMMU:
> > 	IOMMU_VIOMMU_TYPE_AMD_VIOMMU,
> > 
> > For AMD "vIOMMU" command buffer, it needs a new type too:
> > 	IOMMU_VCMDQ_TYPE_AMD_VIOMMU, /* Kdoc it to be Command Buffer */
> 
> You are suggesting we define one type for AMD and use it for all buffers like
> command buffer, event log, PPR buffet etc? and use iommu_vcmdq_alloc->index to
> identity different buffer type?

We have vEVENTQ for event logging and FAULT_QUEUE for PRI, but both
are not for hardware accelerated use cases.

I didn't check the details of AMD's event log and PPR buffers. But
they seem to be the same ring buffers and can be consumed by guest
kernel directly?

Will the hardware replace the physical device ID in the event with
the virtual device ID when injecting the event to a guest event/PPR
queue? If so, yea, I think you can define them separately using the
vCMDQ infrastructures:
 - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
 - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
 - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
(@Kevin @Jason Hmm, in this case we might want to revert the naming
 "vCMDQ" back to "vQEUEUE", once Vasant confirms.)

Each of them will be allocated on top of one vIOMMU object.

As for index, it really depends on how vIOMMU manages those vCMDQ
objects. In NVIDIA case, each VINTF can support multiple vCMDQs of
the same type (like smp in CPU term). If AMD is a similar case, yea,
apply an index to each of them is a good idea. Otherwise, if vIOMMU
could only have three queues and their types are different, perhaps
the driver-level vIOMMU structure could just hold three pointers to
manage them without using the index.

> > Then, use IOMMUFD_CMD_VIOMMU_ALLOC ioctl to allocate an vIOMMU
> > obj, and use IOMMUFD_CMD_VCMDQ_ALLOC ioctl(s) to allocate vCMDQ
> > objs.
> > 
> >> In case of AMD vIOMMU, buffer base address is programmed in different register
> >> (ex: MMIO Offset 0008h Command Buffer Base Address Register) and buffer
> >> enable/disable is done via different register (ex: MMIO Offset 0018h IOMMU
> >> Control Register). And we need to communicate both to hypervisor. Not sure this
> >> API can accommodate this as addr seems to be mandatory.
> > 
> > NVIDIA's CMDQV has all three of them too. What we do here is to
> > let VMM trap the buffer base address (in guest physical address
> > space) and forward it to kernel using this @addr. Then, kernel
> > will translate this @addr to host physical address space, and
> > program the physical address and size to the register.
> 
> Right. For AMD IOMMU 1st 4K of MMIO space (which contains all buffer base
> address registers) is not accelerated. So we can trap it and pass GPA, size to
> iommufd.

Yes.

> .. but programming base register (like Command buffer base addr) is not
> sufficient. We have to enable the command buffer by setting particular bit in
> Control register.  So at high level flow is something like below (@Suravee,
> correct me if I missed something here).
> 
> From guest side :
>   Write command bufer base addr, size (MMIO offset 0x08)
>   Set MMIO Offset 0x18[bit 12]
>     Also we need to program few other bits that are not related to these buffers
>     like `Completion wait interrupt enable`.
>
> From VMM side:
>   We need to trap both register and pass it to iommufd
> 
> From Host AMD IOMMU driver:
>   We have to program VFCntlMMIO Offset {16’b[GuestID], 6’b10_0000}
> 
> 
> We need a way to pass Control register details to iommufd -> AMD driver so that
> we can program the VF control MMIO register.
> 
> Since iommu_vcmdq_alloc structure doesn't have user_data, how do we communicate
> control register?

BIT(12) is the CMD enable bit. VMM can trap that as the trigger to
forward the base address/length and other info.

And you'd likely need to define a driver structure:

// Add this to struct iommu_vcmdq_alloc;
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
..
+	__u32 data_len;
+	__aligned_u64 data_uptr;

// Refer to my patch in the v1 series that handles the user_data:
// https://lore.kernel.org/linux-iommu/5cd2c7c4d92c79baf0cfc59e2a6b3e1db4e86ab8.1744353300.git.nicolinc@nvidia.com/

// Define a driver structure
struct iommu_vcmdq_amd_viommu_cmdbuf {
	__u32 flags;
	__u32 data;
};

Thanks
Nicolin

