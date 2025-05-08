Return-Path: <linux-kselftest+bounces-32643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA7AAF33C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 07:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8915F189A5B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 05:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB621766A;
	Thu,  8 May 2025 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sy+2y/lL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349EF15B102;
	Thu,  8 May 2025 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683812; cv=fail; b=umQ3JFuyybldgjvIDxjSJd9QgrxQERaBax1eejk1/udf7tmLe81PZT0T1OgHRC7dI0bOWXadxEAxNajeFntxUY61xOxoy/QuUrcHZ1XVAE8zgVlzlPwcmT578rk3PfjoeC5o3YAJZ42feyNCvUNF2dhOhowsxtZ4dED3lszYYwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683812; c=relaxed/simple;
	bh=VlpvxeXDNfHWgUW8O8jSPiIpWArmUhyrQEW37SL6ypk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7DbwOs2hLQJjM52lWhaUeymTbyDMsH+ziNPi/8pMEsD56Cq3k2QbCJI0CzkS3zHY3okCUV94VYAMYVEwgI6BVEdu4aut7tADInB8QvxONYPeElAFtaVbUdrwIP5ZAJ/Vq9uGu0+OuaoUMsC0bBwfIt8HqI781LfjCe+16eas/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sy+2y/lL; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUqOeEu9itrJsv4JgBx4WvWSqm1xC0VYDjyYxL0TGj7pSi22Y3f6waUPEUTe1eZOarbCbmtN4wYsddMbZhbdDqQl82dgLMRZZ9VDu+yIE/8KaZofDk2d2YH+xGq/L3ic4FD0PG3PpYFImBU7r6YH6ILp0wqDu/lD6265dEcuBK0GG+D1XsYuH3SX0vu+pyxGMpCGzWOpsOk4e0iksJYUDcq6RNQXcHlujLxObI/cQ62bkQQzi2lTZ+nHYzZnQirZTmTatPadZzT5GAp1mZf/HBQzYvWycNUETyJmdNeJlbu0e7zoCl0mpHoM3H6vOtEyidwnYCYydwhl3XGOJY+Z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmvjnBE2oEwhye8goQClYmTzurS1AJd7We1OWo6cDbk=;
 b=bGUyQsVWzRDt8IERBGQnoOMebVvbsvNpZV+ErrhdAdW9TVe8m+cRPFAQncPHYVvMsbNJralsJzUyl2tJyWVkid0bTkqpFmyf17FdHeNZjugMuqym3nYtuAI0IsZfKLVdlz5DDlBskxXAljzsuUq3fzV04Md43qdSCvTaTOoBjSDZ3wIPOfhLSnDuQxx1e0jttseBDoBK121LIawoz2ocY71tpTzkyn+S9EAsHvuiglwkkvj0m4hqX0oUuS9cRhSsac0MWlm3HjB4NGmXymeiavS2sVxN6Ak17mdmk0tKu6HlB55NH6bnkTKwUzVD/5RRDTUXW70XRCkZVUhpQYVuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmvjnBE2oEwhye8goQClYmTzurS1AJd7We1OWo6cDbk=;
 b=sy+2y/lLR4RvRJW9dzsY1WN200JFY9OFS8DROMuw4W6ujSIQtIYznkF63dC2fKcXdRypF3mcXR+Pu3ZSUKltatij6gH9LgbUYvKm8I6l1C9XHjKkigbZCJFv+U7fUEpSkg05zDW4z2ZhMo6Qmly4W2QFPgcisKESFwq49/I3JQpUjSYQK8e/ypFypoaPgLbKmj6CX278IUEU4rwJV09TKFj4ma2nQ7giTJTzPzwI8xnvzcHTYVk/FAYRHyCeAM7zTIsX9MQ5PTdw/SY/T7ZbyiRM69w7lQVMX+XEdR5Fx9aQRd/ZxDgbZkKO1m+NrGW14uCbv30xqVR21OczfyGUgQ==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 05:56:42 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:303:84:cafe::f6) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Thu,
 8 May 2025 05:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:56:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 22:56:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 7 May
 2025 22:56:25 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 22:56:20 -0700
Date: Wed, 7 May 2025 22:56:17 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Message-ID: <aBxHgf4llBd7vA5w@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
 <20250507123103.GC90261@nvidia.com>
 <2356ff85-6651-47d9-90c7-f8cbf43b053b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2356ff85-6651-47d9-90c7-f8cbf43b053b@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: da343667-7c14-4fd7-4eb0-08dd8df51b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUdKTVIzRDd4QlYwUURacWZJOGlpUWpVS1RLWDUyYnNFeUVRTTVTN1d3Q0dr?=
 =?utf-8?B?c0hPRm1ITks0NEwvRVYyWlY0VXpkQVNvYWhvd2ZqNmJzZFMzeGt2dFBPZnRY?=
 =?utf-8?B?cnNZY2RYay9uL0tBSyt1dHJLcXR2aUFudTVHaEFSdnJsWWxjWGNmSmkrUXV0?=
 =?utf-8?B?Tmt5d0RDZVB1V2J0ZWRIbWNndm9qWlp5aFhFdENJZk9VVjMyaTR2UE9JdFYx?=
 =?utf-8?B?cGU4TUxWTFhnYU5iTGlJdjJNelMweHhCL2JzUVJUYUJoTTFDWkR5UUlaRmxl?=
 =?utf-8?B?NkN2YzIyRWRRR3hjR3BOd2swUjlRMTVMRTk3aml6TXJKcjNKNHhwWFhyb1ZH?=
 =?utf-8?B?ZjQyQktMRnV3RG90TURvd083UkMrT0hsZTJmOFFJNU44aHJJRVppd3h5elpa?=
 =?utf-8?B?YkhJWWZwVkVEcHFrMDM3RkhHQmVBaXdqelNiNXZ5QXBWNlFQRUNFdVBIRk9Z?=
 =?utf-8?B?TVJ4aHFGNmRrSlduVE50dmJOb29tL1ZkZ3V2ekVwVG9OQ1dFbldrL2k0NlNP?=
 =?utf-8?B?K3ovUHJjZ00yTWpZUDYzSlgyUXRaUTkwQkhIdVBobHpEUzdXQXlyeko3Wkhy?=
 =?utf-8?B?VEkrc040SFpvSTZOSnl6bTdHaWZDOWp3NndEcGJmYzhsTGJJanhSSUlvNFcw?=
 =?utf-8?B?TmFUMWMvbGhlMkNtYWI5NzByVUhaWDhHcHZEQmZCQTJqSHNYWTI5bnNtaGFh?=
 =?utf-8?B?c21rY0FubHJxWS9MSEFKRHQ1bnBPdStkVGhhaURxYmlSOWtnenFLdGVMaUYv?=
 =?utf-8?B?ZHBmK2tFWlk1bFhVSStuSHpMMXk2dkJLaC94dGo0TWdiL3VnVm85ZjRsd1Ju?=
 =?utf-8?B?aHZqbTBkSDVuRXZWRldnOFl2RnBmQlNGOE1XMkZ0bDY4ZHpUY3lkdGVKVnlB?=
 =?utf-8?B?YnhCQzBYMnJtdkpmalBJSUkzM2hLU1JNZUNVZ1Y0UUs4dVhVVWk1bldzS1dD?=
 =?utf-8?B?THlDQlpEYklCQVk5MkRPR0YyQjUya0g4L0pXSjZtUmJjaVRxb0wzU09kUEJC?=
 =?utf-8?B?VitWVmNtdHg4aFp5eEVlcnBMUjl1ZGxaNlVmZ2FRdnY0eHg4L2hFZHIweFZQ?=
 =?utf-8?B?Wk9xU3YyL0JBSklwcTZKSWNXc2hMMzBqQUZFakJ0U0xrVURIRUFpOTk3MFVU?=
 =?utf-8?B?S1ZLYmY2Yjljb0tqRk5MekdJa2xiZVhaZDM4Y3oyUlJUR1Y0ekpwWk1zRThE?=
 =?utf-8?B?NlF4UHdWVTh1S1I5VXBXbEIyVTZieEVjdmwxNU13aGhEVkd1bnoxa1oyVTY1?=
 =?utf-8?B?czVLZGtpcE1CL3lFa3lIVnJkeUNlMWFQSXFFZVBJeFlLMkFMK1ljK2dtbVNT?=
 =?utf-8?B?VEFzZFBOWFBnUmZmeDlZZ2thTEJQS1NnWVVqNHlMak0xdk8vK3NFQVZiazFz?=
 =?utf-8?B?TENYNTViVlBiNktjOUQvdnFjNnl3NnQxT3JKcWpleGpyZ1pIRC90N1BkenV1?=
 =?utf-8?B?RkZjc1BLeWNDeDl6SVVnQzlFNHo5YTFmRmtHUTgvSHFlMlRTV1V5RjNmNDNZ?=
 =?utf-8?B?MVM2Z1N0cC9sS0FsTDBBQm5WeFJ4V3YyeHlNMmc2WTFtZFQxUUNKZFNKVmdY?=
 =?utf-8?B?RVo2WWFLb2lDdjlFRi9TUW1jNzdqcSs2Q3QwSFBFZGxoVXZNZWRPWmhxdnEw?=
 =?utf-8?B?SFZGZ0pLb3ZMcXJrbXJ0bjVFV0hqYkZYVk5YUjhoK3pCZ1VFaDUvUlgrTnNq?=
 =?utf-8?B?QXQrVUt3NVBlZWE3RTNPL3ZHUkRQSi9MKy8wN1piU0UrWEVKMUdQdU12cXZi?=
 =?utf-8?B?L3ozeWttVkJKYlU4ZUtxditZT1I0TzVPVDBwZ09UL1JvbEFSTkoxc1hKVVBv?=
 =?utf-8?B?a01CVTU0NjVIUkZSSi80dHZrOFFPbGJTWnAyQVF3Ym90YXFYQllHUS8rTWd6?=
 =?utf-8?B?UEpVc210T1pmanVVaXRsTTNHb2hETlNuclRTWk5pWUlnM2U2TTh0THYzYUM3?=
 =?utf-8?B?TWxWYnNxTTVUTUM5RkthcW8rSEdYWkNmVzhZTXhtZHE3WWRtcXF3REtCZmhK?=
 =?utf-8?B?a2VKS0lIRHF1U1VQQ0MvTU12WCtlaGRMWWI0RFpxNmQwdlJ3UnBYZkF0Z0Zh?=
 =?utf-8?B?V05iaUdwR0lQSmFNTWpFdjZ1ZS9UOTlKWmRVdz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:56:41.8828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da343667-7c14-4fd7-4eb0-08dd8df51b31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On Thu, May 08, 2025 at 10:16:51AM +0530, Vasant Hegde wrote:
> >>   - There is other bit "Completion wait interrupt enable"
> >>     This doesn't related to any buffer. Instead if we configure this for
> >> completion wait command it will generate interrupt.
> > 
> > This sounds like a modify on the VIOMMU object?
> 
> Again in my view its VIOMMU object as it tells HW what to do when it finishes
> completion wait command.

According to the spec:
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

This is for an interrupt from a COMPLETION_WAIT command:
"The COMPLETION_WAIT command allows software to serialize itself
 with IOMMU command processing. The COMPLETION_WAIT command does
 not finish until all older commands issued since a prior
 COMPLETION_WAIT have completely executed."

So, basically it's like the IRQ for CMD_SYNC on ARM. IMHO, this is
very specific to Command Buffer (i.e. a vQUEUE object, and now HW
QUEUE object), though the bit is located in a global IOMMU control
register.

Looking at this paragraph:
"
To restart the IOMMU command processing after the IOMMU halts it,
use the following procedure.
• Wait until CmdBufRun=0b in the IOMMU Status Register
   [MMIO Offset 2020h] so that all commands complete processing as
   the circumstances allow. CmdBufRun must be 0b to modify the
   command buffer registers properly.
• Set CmdBufEn=0b in the IOMMU Control Register [MMIO Offset 0018h].
• As necessary, change the following registers (e.g., to relocate
   the command buffer):
   • the Command Buffer Base Address Register [MMIO Offset 0008h],
   • the Command Buffer Head Pointer Register [MMIO Offset 2000h],
   • the Command Buffer Tail Pointer Register [MMIO Offset 2008h].
• Any or all command buffer entries may be copied from the old
   command buffer to the new and software must set the head and tail
   pointers appropriately.
• Write the IOMMU Control Register [MMIO Offset 0018h] with
   CmdBufEn=1b and ComWaitIntEn as desired
",
the ComWaitIntEn bit is suggested to be set along with the CmdBufEn
bit, i.e. it can be a part of the IOMMU_HW_QUEUE_ALLOC ioctl.

What I am not sure is if the HW allows setting the ComWaitIntEn bit
after CmdBufEn=1, which seems to be unlikely but the spec does not
highlight. If so, this would be an modification to the HW QUEUE, in
which case we could either do an relocation of the HW QUEUE (where
we can set the flag in the 2nd allocation) or add an new option via
IOMMUFD_CMD_OPTION (as Kevin suggested), and I think it should be
a per-HW_QUEUE option since it doesn't affect other type of queues
like Event/PRR Log Buffers.

Similarly, an Event Log Buffer can have an EventIntEn flag; and a
PPR Log Buffer can have an PprIntEn flag too, right?

Thanks
Nicolin

