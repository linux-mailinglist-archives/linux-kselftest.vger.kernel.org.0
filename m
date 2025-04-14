Return-Path: <linux-kselftest+bounces-30738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE1A88AA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2458817CEB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C728B4E0;
	Mon, 14 Apr 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MP3yfeaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBB28935B;
	Mon, 14 Apr 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653743; cv=fail; b=Ud8Q284bHNGnU0LVXWV3VETg+DZJkAsn1Xmz5hlG32iNk9CoegjLGgx6TONvK2k67D+GjY3ERnDYT1zA9HEmt7RyKfyWBNMPifSNYQjQbU6jX7u96KBTDjkXa606VUZNTNwMF+HKMiUFMiJa0MKXxET3uuz3VVFh9nrKu/aKhRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653743; c=relaxed/simple;
	bh=jtMafV+sAX39IiCGCxQE7IoGjwugXUghLn4AOZ+ItWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzSfb9xMMjF6JxYeo9sy1Ya2XE5KSOu3Ats1uI4yZ7QZfstYBbQT9wKHTLJt9gjlC+yBGYnklP+XjKsC400zq1RfuKxF6xoL2TSu41CxtzouGpCL02yN8bPEuoOe+iRqMpUirVq6xom+BsVOLua4vRJWK5Lf8kuTgS79jmuKQso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MP3yfeaX; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQFktAbxIrjLPOFHpFq4Lm7mRG8Z9uDbzJobI9DHgtmpU6Nbm6s/OFdjuLGE6Y1bCiLuuiaorrJNV5lALstmvGItfoRjGLAT4Ssn2Cmo6RyNT6wEZZy1pt35Ygw8wlKasBeoaiYpIjZjW71et3MBDHmTo8jIttzhwzRunoWnfPYTuCnEpWfJ+Yr+4lpViNEtUSRAx0ibxLg6VWD2WjV8zBQ6/6B4Bu7zsd0yBTXk4D0lZz3chH5R/SsZCp8/AVmJlv1ZqANPU1cF+KayeeER5X5uP6k4gyAvJx8lPEi3i1QmWje1hOVAzbSL5brP3Q+7MaQO35M9tZ3UQcwjSgTBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLH+Co++08+Y9Wng81w5diSULkrJrfIgInXS5IrP/b4=;
 b=opD5K0K1bXi0U7HgoX2KbKvgRubOqwHwFAxRGQm/wbFXzaa1O0BRrwc1ySb4LJwaNhEKr2gPy3OvjERv1T34i3TBTQPgFYYOmKR+7xtFycxrWbhKYZof+njuVwjPpiE+U5ON+i2Bn6aM7vrecAtwiym2CLMlF5NfLEGRrUDKFzorpqJKrDxkPbTtuIV3heC6uWv5O6ab6Pfe1CAw4XQncTG4jBg7mgBnqiia/Smrbm8pGH9ee1q/FqVxiojocPxrc/SRFDC+wFhwu6t2yRmd1xQN8wV5++InyYFeKm3HijO9cdFwoVY7cpFCG6LOX02r7tzw7C7OsFTxgAUbDfOCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLH+Co++08+Y9Wng81w5diSULkrJrfIgInXS5IrP/b4=;
 b=MP3yfeaXa1oweB7mrqNQDgdQMSNIr6znYuU0eUZLEl4ZR3B5zjcRZfgGHJRh3UVkb/U3crAaKhuoPOoxwS4xb+zKlFlw4sngL8s3lD7mLj7MWx2J/H/YB5RRXZSSBRNrQHuvjK1U5rWFcl8u5Dl8t7jUa4F1RAGIf+5KUBKAtODAXNOySqEiKz4ANdpCrNDavPDs7WeVGWMIG1nXuPgJ6wOs/e6df6NWIrmi7xXaEWCLM0XK8osqRhIyKgxlM0x47vFvlD6+hWn73ptjsVBtbCgL/BkDuQjRsDV5W/3EeMNJju4jSv5dGSOdo2aYZ3ufIgzdXhZTEyE7zPthnIV0Vw==
Received: from BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::23)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 18:02:17 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2b) by BL1P221CA0011.outlook.office365.com
 (2603:10b6:208:2c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 18:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 18:02:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 11:01:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 11:01:57 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 11:01:57 -0700
Date: Mon, 14 Apr 2025 11:01:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Will Deacon <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
Message-ID: <Z/1Nk+2kucCLx9+A@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
 <86881827-8E2D-461C-BDA3-FA8FD14C343C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86881827-8E2D-461C-BDA3-FA8FD14C343C@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af9499c-f0f7-4cfe-ec81-08dd7b7e7e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTBvWmtTaW9hOEpRN1pDeitMN0hRNkRQNitjRWJsMCtNZ1loblVLSDhhNW1v?=
 =?utf-8?B?UXc2QzZoYTBUbjd3Y21GeFJBaysyanNSME5ROENqOHQ0aWpIRFV5WFQ0bzZu?=
 =?utf-8?B?QjlobCtqZUpvWm1OTzNTcDdQMzFXanJ6cWtNMVJ4Mm5iUG9hSGxnODFnVlE3?=
 =?utf-8?B?bnFJaW81ZWJGcWtPcllXTmg1NDJXUmlvTjZJNmRjODUwRzJVQStHRlBoUHFB?=
 =?utf-8?B?YVM0WU9OTTI0cFViYm44SlhJTk5XTkpiOE50R0N4TGdaY0hJaW9NRGNqdmRh?=
 =?utf-8?B?VFNLaWJNK0V3ZDJRZlQ5VThGVklzSmtCZjJ1Y0dzTHZNcGUxTDJEU3k3QUlN?=
 =?utf-8?B?YlloUmpIUTlSSHh5VEh4cEtoQ294bFNQQ3c2ZHhYUUM3MGtrQU1RT0I4YnBY?=
 =?utf-8?B?SDEvckZhUm5hZnh2K2UrQWt4a3FMSWNOMTBsTmN1NFUzQ08vV2tjdGNmVitE?=
 =?utf-8?B?azFHYkJGd3BjUWFEU0xEQ24rZHdrb2x0Nks4LzMyWndQblNQdUdwWXpLT2dQ?=
 =?utf-8?B?NndDS3VFYnRoR2g0azgyclBuNVBzQWtqNFRkS3pJZ1hBNUE0QjB1RVI4cG0y?=
 =?utf-8?B?dnE2ZnN3c0lMV29PNUIrRUdoYTcwV0dYU0pUMHdCUW5aMFlxdzJLTzhuQzBt?=
 =?utf-8?B?eFNZNkZmQWVPSUJzNVd6NUNkdVU1dnE4eU1id1U3SS9ZL0didEI4NUtpSnNy?=
 =?utf-8?B?QzVCRTZrZGRsenVyZ1BDK2RkeWNZV2V3ZDQ5MVNrUm9MTVFCUzVsSS9BTEVR?=
 =?utf-8?B?YXhUaUljbHNTalNyc0VwdlB2SWF0Rkk0YTZ0SmRLaTFYWWdDSDRyVU4za29P?=
 =?utf-8?B?aldsQ1RNN2JJNEVER0laL1dIdUJKT3laeldidWlYN3JyVTVac1JZcVh4Zm92?=
 =?utf-8?B?MGNLV3cvbUlTSDZwWWYxUi9EekI4eVBRTHFTcFdlS0ZhZGpQenIyUUxhL1lJ?=
 =?utf-8?B?MWJpWWFUTFhLN1hZVm5vNW0vVjdmYldSMjdzVnl4a01RZFNQTDM5ZUF4bExB?=
 =?utf-8?B?VWVMZ0ZOTHQ3VTkzcXJpclZaNEF6M1lGQlJNc0ZYNmR3c0NxenJjY3ViU3kz?=
 =?utf-8?B?TSsrUlBiWGpvQ3N2ZkJ6MnVZWllpU3hzckFOZUhQTzFFb3pmY28wU25OazJW?=
 =?utf-8?B?RXdVZ1FFTGVZK2MwYUF3a2haWVBDVktXTWRXZFZsNXJxRHpBWmR1LytMb3Nk?=
 =?utf-8?B?Z256RDlzRnpZYVBmQVFKc3FnWHpqWFpYcHo2djNxRFZHc3AwWGNad3Q0Q05H?=
 =?utf-8?B?MmxuL1RPL3lLa2hsdjNjc3hXeUNrZGdNZWVZMG1jM1ViQzJ3VEtCcHhPZWxW?=
 =?utf-8?B?MXNiNTVBcm5NYUtpd29NajRLK1ZsZ05nMHNzSTcxTmZnRVBhRlc0bzhVaUNk?=
 =?utf-8?B?M0p3eTVYdjNheHlEUDdFR0RsclhHNlNVc0dYM0ZsT3pyNnR0S2FOSGZFcExB?=
 =?utf-8?B?bGxOb280WmNHOStNRTdYWXZkZHBaazRwUitpUWduR0w4OWdONlJGalJScWJ2?=
 =?utf-8?B?Ui9xdXBXU3lBMGZiSld1cHlFMHJMY3pOQmRjeXptZnZOTlp0WG00d1FNTStl?=
 =?utf-8?B?Ti9KWS93aWlHejBpSmxTWkV2Z2ZMYXdzcnJhTVZXQnJ6bVRZU3dQMERSeEox?=
 =?utf-8?B?UHYvUG1XWlByblhVRHVsQzNYRWJJWkkzYW5GaGthSnV5TU9CL1YrVENsc0Nm?=
 =?utf-8?B?V1FESHZVZkh4WU9IOVdTb0hiTzF1eXhYK25INFB2clNTbndiK25HN2d0ZG90?=
 =?utf-8?B?d0piYVYxQXZ0RDFuRVN3UHRTQnhqNEVTQWxneHdPNlFPQ29wNGZUZ0tNSWVu?=
 =?utf-8?B?WktBRnRacndhSTV0NnVTbTIyYmRnUmtRcUpiNUVzN2wweUxSYlY1TGtEa0ZP?=
 =?utf-8?B?N2NzYTByZjgzak9BVS81SzJqa2RMZWVyZE84MkhtR2dVQkplSWxYQkNmaEdJ?=
 =?utf-8?B?WUhaZEMyQTU0WWdTZEhrMHlOTVZKUmRCWGQ3cGdCZ1ZrajNXTFVUdG96OUJn?=
 =?utf-8?B?OEkrNERhZCs2dkZHaDkwK1NXRWpMQkZ6OHJMSVZKYTArek8rOWlKWGY5RjY2?=
 =?utf-8?Q?fzERCp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:02:17.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af9499c-f0f7-4cfe-ec81-08dd7b7e7e7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

On Mon, Apr 14, 2025 at 08:25:40AM -0700, Matt Ochs wrote:
> > On Apr 11, 2025, at 1:37 AM, Nicolin Chen <nicolinc@nvidia.com> wrote:
> > +__iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
> > +    void *src_data, unsigned int data_type,
> > +    size_t data_len, size_t min_len)
> > +{
> > + if (dst_data->type != data_type)
> > + return -EINVAL;
> > + if (WARN_ON(!dst_data || !src_data))
> > + return -EINVAL;
> 
> The NULL pointer check should be first.

Fixed.

We seem to have the same issue in __iommu_copy_struct_from_user().
Will send a patch fix that too.

Thanks
Nicolin

